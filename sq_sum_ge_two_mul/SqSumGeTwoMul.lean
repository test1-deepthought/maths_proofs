import Mathlib

/-!
# Sum of Squares Inequality

Theorem: For any natural numbers a and b,
  a² + b² ≥ 2ab

## Proof

We consider two cases: a ≤ b and b ≤ a.

**Case 1: a ≤ b.**
Since a ≤ b, we have a·a ≤ a·b (multiply by a) and a·b ≤ b·b (multiply by b).
Thus a² + b² ≥ a·b + b² ≥ a·b + a·b = 2ab.

**Case 2: b ≤ a.**
Symmetrically, we have b·b ≤ a·b (multiply by b) and a·b ≤ a·a (multiply by a).
Thus a² + b² ≥ a² + a·b ≥ a·b + a·b = 2ab.

In both cases, the inequality holds.
-/

theorem sq_add_sq_ge_two_mul (a b : ℕ) : a * a + b * b ≥ 2 * a * b := by
  -- 2*a*b is the same as a*b + a*b
  have h2ab : 2 * a * b = a * b + a * b := by ring
  rw [h2ab]
  by_cases h : a ≤ b
  · -- Case 1: a ≤ b
    have h1 : a * a ≤ a * b := Nat.mul_le_mul_left a h
    have h2 : a * b ≤ b * b := Nat.mul_le_mul_right b h
    -- So a*a + b*b ≥ a*b + b*b ≥ a*b + a*b
    have hsum : a * a + b * b ≥ a * b + b * b := by
      exact add_le_add_right h1 (b * b)
    have hsum2 : a * b + b * b ≥ a * b + a * b := by
      exact add_le_add_left h2 (a * b)
    exact le_trans hsum hsum2
  · -- Case 2: b ≤ a
    have hba : b ≤ a := by omega
    have h1 : b * b ≤ a * b := Nat.mul_le_mul_right b hba
    have h2 : a * b ≤ a * a := Nat.mul_le_mul_left a hba
    have hsum : a * a + b * b ≥ a * a + a * b := by
      exact add_le_add_left h1 (a * a)
    have hsum2 : a * a + a * b ≥ a * b + a * b := by
      exact add_le_add_right h2 (a * b)
    exact le_trans hsum hsum2

