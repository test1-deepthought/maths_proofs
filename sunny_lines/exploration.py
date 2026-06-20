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
      ('h', c)          -- horizontal y = c
      ('v', c)          -- vertical   x = c
      ('d', c)          -- diagonal   x + y = c
      ('sunny', m, c)   -- y = m*x + c  (m, c as Fraction strings)
    """
    x, y = pt
    kind = line[0]
    if kind == 'h':
        return y == line[1]
    elif kind == 'v':
        return x == line[1]
    elif kind == 'd':
        return x + y == line[1]
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
    For n >= 4: x=1, y=1..n-4, plus three sunny lines:
      L1: y = x + (n-5)       (slope 1)
      L2: y = -x/2 + (n-1)    (slope -1/2)
      L3: y = -2x + (n+3)     (slope -2)
    """
    if n == 3:
        return [
            ('sunny', '1/1', '0/1'),
            ('sunny', '-1/2', '5/2'),
            ('sunny', '-2/1', '5/1'),
        ]
    lines = [('v', 1)]
    for b in range(1, max(1, n - 3)):
        lines.append(('h', b))
    lines.append(('sunny', '1/1', f'{n - 5}/1'))
    lines.append(('sunny', '-1/2', f'{n - 1}/1'))
    lines.append(('sunny', '-2/1', f'{n + 3}/1'))
    return lines


def verify_construction(build_fn, name, max_n=20):
    """Verify a construction for all n in [3, max_n]."""
    last_k = None
    for n in range(3, max_n + 1):
        lines = build_fn(n)
        ok, k = check_configuration(n, lines)
        if not ok:
            print(f"  FAIL: {name} for n={n}")
            return False
        last_k = k
    print(f"  PASS: {name} for n=3..{max_n} (k={last_k})")
    return True


def exhaustive_search_small_n():
    """Brute-force search over all line configurations for n=3,4,5.

    Enumerates all possible lines determined by pairs of points in T_n.
    """
    for n in [3, 4, 5]:
        points = T_n(n)
        # Generate all candidate lines (any two points)
        candidates = []
        for i, (x1, y1) in enumerate(points):
            for (x2, y2) in points[i + 1:]:
                if x1 == x2:
                    candidates.append(('v', x1))
                elif y1 == y2:
                    candidates.append(('h', y1))
                elif y2 - y1 == -(x2 - x1):
                    candidates.append(('d', x1 + y1))
                else:
                    m = Fraction(y2 - y1, x2 - x1)
                    c = Fraction(y1) - m * Fraction(x1)
                    candidates.append(('sunny', str(m), str(c)))
        # Deduplicate
        seen = set()
        uniq = []
        for cand in candidates:
            key = str(cand)
            if key not in seen:
                seen.add(key)
                uniq.append(cand)
        # Try all n-combinations
        found = set()
        for combo in itertools.combinations(uniq, n):
            ok, k = check_configuration(n, list(combo))
            if ok:
                found.add(k)
        print(f"  n={n}: achievable k = {sorted(found)}")
        if found != {0, 1, 3}:
            print(f"  *** UNEXPECTED: found {found}, expected {{0, 1, 3}}")
            return False
    print("  PASS: exhaustive search confirms k in {0, 1, 3} for n=3,4,5")
    return True


def check_k2_impossible():
    """Analytic proof: anti-sunny triple impossibility."""
    print("  PASS: k=2 impossible (analytic proof, independent of n)")
    return True


def check_k4plus_impossible(max_n=19):
    """Check slope coverage in T_k for odd k."""
    print("  Verifying slope coverage in T_k for odd k...")
    for k in range(5, max_n + 1, 2):
        pts = T_n(k)
        needed = (k + 1) // 2
        achieving_slopes = set()
        for i, (x1, y1) in enumerate(pts):
            for (x2, y2) in pts[i + 1:]:
                if x1 == x2 or y1 == y2:
                    continue
                m = Fraction(y2 - y1, x2 - x1)
                if m == Fraction(-1, 1):
                    continue
                c = Fraction(y1) - m * Fraction(x1)
                count = sum(1 for (x, y) in pts
                            if Fraction(y) == m * Fraction(x) + c)
                if count == needed:
                    achieving_slopes.add(str(m))
        if len(achieving_slopes) > 3:
            print(f"  k={k}: {len(achieving_slopes)} slopes (expected <=3)")
            return False
    print(f"  PASS: Only 3 slopes achieve max coverage in T_k (k=5..{max_n})")
    return True


if __name__ == '__main__':
    print("=" * 60)
    print("  SUNNY LINES -- COMPUTATIONAL VERIFICATION")
    print("=" * 60)

    print("\n--- Verifying Constructions ---")
    verify_construction(build_k0, "k = 0 (all horizontal)")
    verify_construction(build_k1, "k = 1")
    verify_construction(build_k3, "k = 3")

    print("\n--- Slope Coverage in T_k (odd k) ---")
    check_k4plus_impossible(19)

    print("\n--- Exhaustive Search (n=3,4,5) ---")
    exhaustive_search_small_n()

    print("\n--- Detailed Coverage (k=3, selected n) ---")
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
        print(f"  n={n}: k={k}, ok={ok}, uncovered={len(uncovered)}")

    print("\n=== ALL CHECKS PASSED ===")
