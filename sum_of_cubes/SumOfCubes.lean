import Mathlib
open Finset

/-!
# Sum of Cubes Identity

Theorem: For any natural number n,
  1³ + 2³ + 3³ + ... + n³ = (1 + 2 + 3 + ... + n)²

This is proved by induction on n, using the triangular number formula.
-/

theorem sum_range_cubes_eq_sq_sum_range (n : ℕ) : (∑ k in range (n + 1), k ^ 3) = (∑ k in range (n + 1), k) ^ 2 := by
  induction' n with m ih
  · simp
  · rw [sum_range_succ, sum_range_succ, add_pow_two]
    rw [ih]
    have hsum : (∑ k in range (m + 1), k) = (m * (m + 1)) / 2 := by
      calc
        (∑ k in range (m + 1), k) = ((m + 1) * m) / 2 := by
          rw [Finset.sum_range_id, mul_comm]
        _ = (m * (m + 1)) / 2 := by ring
    rw [hsum]
    ring_nf
    -- After ring, we need to show: (m*(m+1)/2)^2 + (m+1)^3 = ((m+1)*(m+2)/2)^2
    -- This is an algebraic identity that holds in ℕ with division
    -- Let's use the standard formula approach
    have hcalc : ((m * (m + 1)) / 2) ^ 2 + (m + 1) ^ 3 = (((m + 1) * (m + 2)) / 2) ^ 2 := by
      -- Multiply both sides by 4 to clear denominators
      have h4 : 4 * (((m * (m + 1)) / 2) ^ 2 + (m + 1) ^ 3) = 4 * (((m + 1) * (m + 2)) / 2) ^ 2 := by
        calc
          4 * (((m * (m + 1)) / 2) ^ 2 + (m + 1) ^ 3) = 4 * ((m * (m + 1)) / 2) ^ 2 + 4 * (m + 1) ^ 3 := by ring
          _ = (m * (m + 1)) ^ 2 + 4 * (m + 1) ^ 3 := by
            have hsq : 4 * (((m * (m + 1)) / 2) ^ 2) = (m * (m + 1)) ^ 2 := by
              calc
                4 * (((m * (m + 1)) / 2) ^ 2) = ((m * (m + 1)) ^ 2) := by
                  nlinarith
                _ = (m * (m + 1)) ^ 2 := rfl
            rw [hsq]
          _ = (m + 1) ^ 2 * (m ^ 2 + 4 * (m + 1)) := by ring
          _ = (m + 1) ^ 2 * ((m + 2) ^ 2) := by ring
          _ = ((m + 1) * (m + 2)) ^ 2 := by ring
          _ = 4 * (((m + 1) * (m + 2)) / 2) ^ 2 := by
            have hsq' : 4 * (((m + 1) * (m + 2)) / 2) ^ 2 = ((m + 1) * (m + 2)) ^ 2 := by
              nlinarith
            rw [hsq']
      -- Since 4 ≠ 0, we can cancel
      have hpos : 0 < 4 := by norm_num
      exact (Nat.eq_of_mul_eq_mul_left hpos h4)
    rw [hcalc]
