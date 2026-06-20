import Mathlib
open Finset

/-!
# Sum of the First n Odd Numbers

Theorem: For any natural number n,
  1 + 3 + 5 + ... + (2n - 1) = n²

Equivalently, ∑_{k=0}^{n-1} (2k + 1) = n².

## Proof

By induction on n.

Base case n = 0: both sides equal 0.

Inductive step: Assume the identity holds for n = m.
Then for n = m + 1:
  ∑_{k=0}^{m} (2k+1) = (∑_{k=0}^{m-1} (2k+1)) + (2m+1)
                     = m² + (2m+1)      (by IH)
                     = m² + 2m + 1
                     = (m+1)²
-/

theorem sum_range_odds_eq_sq (n : ℕ) : (∑ k in range n, (2 * k + 1)) = n ^ 2 := by
  induction' n with m ih
  · simp
  · rw [sum_range_succ, ih]
    ring

