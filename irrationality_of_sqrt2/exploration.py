"""
Computational exploration for the irrationality of sqrt(2).

This script performs numerical checks that support the formal proof:
  - Verifies that no integer solutions to p² = 2·q² exist for small values.
  - Confirms the parity lemma: an odd integer squared is odd.
"""

import math


def check_no_small_solution(limit: int = 200) -> list:
    """Search p,q in [1, limit] for a solution to p² = 2·q².

    Returns a (hopefully empty) list of counterexample pairs.
    """
    solutions = []
    for q in range(1, limit + 1):
        # p ≈ q·√2, so we only need to check p in a narrow band
        p_approx = int(q * math.sqrt(2))
        for p in range(max(1, p_approx - 2), p_approx + 3):
            if p * p == 2 * q * q:
                solutions.append((p, q))
    return solutions


def parity_lemma_check(limit: int = 20):
    """Verify: if p is odd then p² is odd, and if p is even then p² is even."""
    results = []
    for p in range(1, limit + 1):
        p_sq = p * p
        is_odd = (p % 2 == 1)
        sq_odd = (p_sq % 2 == 1)
        results.append((p, is_odd, sq_odd, is_odd == sq_odd))
    return results


if __name__ == "__main__":
    print("=" * 60)
    print("Exploration: Irrationality of sqrt(2)")
    print("=" * 60)

    # 1. Check for small solutions
    print("\n[1] Searching for integer solutions to p² = 2·q²  (q ≤ 200)...")
    sols = check_no_small_solution(200)
    if not sols:
        print("    ✓ No solutions found. Consistent with irrationality.")
    else:
        print(f"    ✗ UNEXPECTED: found {len(sols)} solution(s): {sols}")

    # 2. Parity lemma
    print("\n[2] Parity lemma verification (odd ⇔ odd², even ⇔ even²):")
    parity_data = parity_lemma_check(20)
    all_ok = all(row[3] for row in parity_data)
    for p, is_odd, sq_odd, ok in parity_data:
        status = "✓" if ok else "✗"
        print(f"    {status}  p={p:2d}  odd? {is_odd}  p² odd? {sq_odd}")
    if all_ok:
        print("    → Lemma holds: p is odd  iff  p² is odd.")
    else:
        print("    → UNEXPECTED failure.")

    # 3. The descent step
    print("\n[3] Simulating the infinite-descent step:")
    print("    If p² = 2·q² and p = 2·k, then q² = 2·k², so also 2|q.")
    print("    Example: if (p,q) = (2k, 2ℓ) then k² = 2·ℓ², a smaller solution.")
    print()
    print("    This produces an infinite descending chain ℕ → ℕ/2 → ℕ/4 → …")
    print("    which is impossible by the well-ordering principle.")
    print()
    print("=" * 60)
    print("Conclusion: All computational checks are consistent")
    print("with the formal Lean proof of irrationality.")
    print("=" * 60)
