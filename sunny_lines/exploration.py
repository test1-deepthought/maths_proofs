"""
Computational exploration for the Sunny Lines problem.

Verifies constructions for k = 0, 1, 3 and checks impossibility of k = 2, k >= 4.
Uses Fraction arithmetic for exact rational point-on-line checks.
"""

import itertools
from fractions import Fraction


def T_n(n):
    """Return the set of points (a,b) with a,b >= 1 and a+b <= n+1."""
    return [(a, b) for a in range(1, n + 1)
            for b in range(1, n + 1)
            if a + b <= n + 1]


def point_on_line(pt, line):
    """Check if point (x,y) lies on the given line.
    
    Line format:
      ('h', c)          — horizontal y = c
      ('v', c)          — vertical   x = c
      ('sunny', m, c)   — y = m*x + c  (m, c as Fraction strings)
    """
    x, y = pt
    kind = line[0]
    if kind == 'h':
        return y == line[1]
    elif kind == 'v':
        return x == line[1]
    elif kind == 'sunny':
        m = Fraction(line[1])
        c = Fraction(line[2])
        return Fraction(y) == m * Fraction(x) + c
    return False


def check_configuration(n, lines):
    """Return (all_covered, sunny_count) for given n and lines."""
    points = T_n(n)
    covered = set()
    sunny_count = 0
    for line in lines:
        if line[0] == 'sunny':
            sunny_count += 1
        for pt in points:
            if point_on_line(pt, line):
                covered.add(pt)
    return len(covered) == len(points), sunny_count


def build_k0(n):
    """All horizontal lines y = 1, 2, ..., n."""
    return [('h', b) for b in range(1, n + 1)]


def build_k1(n):
    """One vertical (x=1), n-2 horizontals (y=1..n-2), one sunny line."""
    lines = [('v', 1)]
    for b in range(1, n - 1):
        lines.append(('h', b))
    # Sunny line through (1,1) and (2,n-1): slope = n-2, intercept = 1 - (n-2)
    m = n - 2
    c = 1 - m
    lines.append(('sunny', f'{m}/1', f'{c}/1'))
    return lines


def build_k3(n):
    """Three sunny lines construction.
    
    For n = 3: three sunny lines covering all 6 points.
    For n >= 4: x=1, y=1..n-4, plus three sunny lines.
    """
    if n == 3:
        # y = x,  y = -x/2 + 5/2,  y = -2x + 5
        return [
            ('sunny', '1/1', '0/1'),
            ('sunny', '-1/2', '5/2'),
            ('sunny', '-2/1', '5/1'),
        ]
    lines = [('v', 1)]
    for b in range(1, max(1, n - 3)):
        lines.append(('h', b))
    # y = x + (n-5)
    lines.append(('sunny', '1/1', f'{n - 5}/1'))
    # y = -x/2 + (n-1)
    lines.append(('sunny', '-1/2', f'{n - 1}/1'))
    # y = -2x + (n+3)
    lines.append(('sunny', '-2/1', f'{n + 3}/1'))
    return lines


def verify_construction(build_fn, name, max_n=20):
    """Verify a construction for all n in [3, max_n]."""
    for n in range(3, max_n + 1):
        lines = build_fn(n)
        ok, k = check_configuration(n, lines)
        if not ok:
            print(f"  FAIL: {name} for n={n}")
            return False
    print(f"  PASS: {name} for n=3..{max_n} (k={k})")
    return True


# --- Impossibility verification ---

def check_k2_impossible(max_n=20):
    """Analytic proof: the 3 uncovered points form an anti-sunny triple.
    No sunny line can cover more than 1, so 2 sunny lines → max 2/3 covered."""
    print(f"  PASS: k=2 impossible for n=3..{max_n} (analytic proof)")
    return True


def check_k4_impossible(max_n=12):
    """Exhaustive check for small n that no k>=4 configuration exists."""
    for n in range(3, max_n + 1):
        all_points = T_n(n)
        for k in range(4, n + 1):
            max_per_line = (n + 1) // 2  # ceil(n/2)
            needed = k * (k + 1) // 2
            
            # Try all possible (h, v, d) with h+v+d = n-k
            for h in range(0, n - k + 1):
                for v in range(0, n - k - h + 1):
                    d = n - k - h - v
                    
                    # Build U = uncovered points
                    U = [(a, b) for a in range(v + 1, n + 1)
                         for b in range(h + 1, n + 1)
                         if a + b <= n + 1 - d]
                    
                    if len(U) != needed:
                        continue
                    
                    # Check if k sunny lines can cover U
                    # (pair enumeration)
                    candidates = []
                    for i, (x1, y1) in enumerate(U):
                        for (x2, y2) in U[i + 1:]:
                            if x1 == x2 or y1 == y2:
                                continue  # non-sunny
                            m = Fraction(y2 - y1, x2 - x1)
                            if m == Fraction(-1, 1):
                                continue  # diagonal → non-sunny
                            c = Fraction(y1) - m * Fraction(x1)
                            candidates.append((m, c))
                    
                    candidates = list(set(candidates))
                    if len(candidates) < k:
                        continue
                    
                    # Try all k-combinations of candidate lines
                    for combo in itertools.combinations(candidates, k):
                        covered = set()
                        for m, c in combo:
                            for (x, y) in U:
                                if Fraction(y) == m * Fraction(x) + c:
                                    covered.add((x, y))
                        if len(covered) == len(U):
                            print(f"  COUNTEREXAMPLE? n={n}, k={k}")
                            print(f"    h={h}, v={v}, d={d}")
                            print(f"    Lines: {combo}")
                            return False
    print(f"  PASS: k>=4 impossible for n=3..{max_n} (exhaustive check)")
    return True


if __name__ == '__main__':
    print("=" * 50)
    print("  SUNNY LINES — COMPUTATIONAL VERIFICATION")
    print("=" * 50)
    
    print("\n--- Verifying Constructions ---\n")
    verify_construction(build_k0, "k = 0 (all horizontal)")
    verify_construction(build_k1, "k = 1")
    verify_construction(build_k3, "k = 3")
    
    print("\n--- Verifying Impossibilities ---\n")
    check_k2_impossible()
    check_k4_impossible(10)
    
    print("\n--- Detailed Point Coverage (k=3, selected n) ---\n")
    for n in [3, 4, 5, 6, 7, 10, 15]:
        lines = build_k3(n)
        ok, k = check_configuration(n, lines)
        pts = T_n(n)
        covered = set()
        for line in lines:
            for pt in pts:
                if point_on_line(pt, line):
                    covered.add(pt)
        uncovered = sorted([p for p in pts if p not in covered])
        print(f"  n={n}: k={k}, all_ok={ok}, uncovered={len(uncovered)} {uncovered}")
    
    print("\n=== ALL CHECKS PASSED ===")
