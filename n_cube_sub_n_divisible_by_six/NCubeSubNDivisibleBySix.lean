import Mathlib
open Nat

/-!
# n³ - n is Divisible by 6

Theorem: For any natural number n, 6 divides n³ - n.

## Proof

We proceed by induction on n.

Base case n = 0: 0³ - 0 = 0, and 6 ∣ 0 holds trivially.

Inductive step: Assume 6 ∣ m³ - m. Then

(m+1)³ - (m+1) = (m³ + 3m² + 3m + 1) - (m + 1)
                = m³ - m + 3m² + 3m
                = (m³ - m) + 3m(m+1)

By the induction hypothesis, 6 ∣ (m³ - m).
Also, m(m+1) is always even, so 3m(m+1) is divisible by 6.
Thus 6 divides the sum, completing the induction.

The key lemma that m(m+1) is even is provided by `Nat.two_dvd_mul_add_one`.
-/

theorem six_dvd_n_cube_sub_n (n : ℕ) : 6 ∣ n ^ 3 - n := by
  induction' n with m ih
  · simp
  · have h_expr : (m + 1) ^ 3 - (m + 1) = (m ^ 3 - m) + 3 * m * (m + 1) := by
      -- Expand (m+1)^3 - (m+1) and simplify
      calc
        (m + 1) ^ 3 - (m + 1) = (m ^ 3 + 3 * m ^ 2 + 3 * m + 1) - (m + 1) := by ring
        _ = (m ^ 3 + 3 * m ^ 2 + 3 * m - m) := by omega
        _ = (m ^ 3 - m) + 3 * m ^ 2 + 3 * m := by omega
        _ = (m ^ 3 - m) + 3 * m * (m + 1) := by ring
    rw [h_expr]
    have h1 : 6 ∣ m ^ 3 - m := ih
    have h2 : 6 ∣ 3 * m * (m + 1) := by
      have h_even : 2 ∣ m * (m + 1) := Nat.two_dvd_mul_add_one m
      have : 3 * m * (m + 1) = 3 * (m * (m + 1)) := by ring
      rw [this]
      have h6 : 6 = 3 * 2 := by norm_num
      rw [h6]
      exact mul_dvd_mul_left 3 h_even
    exact Nat.dvd_add h1 h2
