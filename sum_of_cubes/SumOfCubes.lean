import Mathlib
open Finset

/-!
# Sum of Cubes Identity

Theorem: For any natural number n,
  1³ + 2³ + 3³ + ... + n³ = (1 + 2 + 3 + ... + n)²

## Proof

We proceed by induction on n. The base case n = 0 is trivial.

For the inductive step, let S = ∑_{k=0}^{m} k. By the induction hypothesis,
∑_{k=0}^{m} k³ = S².

Then ∑_{k=0}^{m+1} k³ = S² + (m+1)³.

We need to show this equals (S + (m+1))² = S² + 2·S·(m+1) + (m+1)².

So it suffices to show (m+1)³ = 2·S·(m+1) + (m+1)²,
i.e., (m+1)² = 2·S + (m+1), i.e., 2·S = m·(m+1).

We prove this key identity using Finset.sum_range_id_mul_two.
-/

lemma two_mul_sum_range_succ_eq_mul_succ (n : ℕ) : 2 * (∑ k in range (n + 1), k) = n * (n + 1) := by
  calc
    2 * (∑ k in range (n + 1), k) = (∑ k in range (n + 1), k) * 2 := by ring
    _ = (n + 1) * n := by
      have h := Finset.sum_range_id_mul_two (n + 1)
      -- h: (∑ i in range (n+1), i) * 2 = (n+1) * ((n+1) - 1)
      -- But (n+1) - 1 = n for n+1 > 0
      simpa [Nat.add_sub_cancel] using h
    _ = n * (n + 1) := by ring

theorem sum_range_cubes_eq_sq_sum_range (n : ℕ) : (∑ k in range (n + 1), k ^ 3) = (∑ k in range (n + 1), k) ^ 2 := by
  induction' n with m ih
  · simp
  · rw [sum_range_succ, sum_range_succ, add_pow_two]
    rw [ih]
    have hsum : 2 * (∑ k in range (m + 1), k) = m * (m + 1) :=
      two_mul_sum_range_succ_eq_mul_succ m
    -- We need: (∑k)^2 + (m+1)^3 = ((∑k) + (m+1))^2
    -- Expanding RHS: (∑k)^2 + 2*(∑k)*(m+1) + (m+1)^2
    -- So we need: (m+1)^3 = 2*(∑k)*(m+1) + (m+1)^2
    have hcalc : (m + 1) ^ 3 = 2 * (∑ k in range (m + 1), k) * (m + 1) + (m + 1) ^ 2 := by
      calc
        (m + 1) ^ 3 = (m + 1) * (m + 1) ^ 2 := by ring
        _ = (m + 1) * (m * (m + 1) + (m + 1)) := by ring
        _ = (m + 1) * (2 * (∑ k in range (m + 1), k) + (m + 1)) := by
          rw [hsum]
          ring
        _ = 2 * (∑ k in range (m + 1), k) * (m + 1) + (m + 1) ^ 2 := by ring
    rw [hcalc]
    ring
