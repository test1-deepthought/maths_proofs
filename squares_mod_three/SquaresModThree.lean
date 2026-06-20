import Mathlib
open Nat

/-!
# Squares Modulo 3

Theorem: For any natural number n, the square n² is congruent to
either 0 or 1 modulo 3. In other words, there is no integer whose
square is congruent to 2 modulo 3.

Equivalently: 3 ∤ (n²) → 3 ∣ (n² - 1)

## Proof

We consider n modulo 3. Every integer can be written in one of three
forms: 3k, 3k + 1, or 3k + 2, for some integer k.

- If n = 3k, then n² = 9k² = 3(3k²), so n² ≡ 0 (mod 3).
- If n = 3k + 1, then n² = 9k² + 6k + 1 = 3(3k² + 2k) + 1, so n² ≡ 1 (mod 3).
- If n = 3k + 2, then n² = 9k² + 12k + 4 = 3(3k² + 4k + 1) + 1, so n² ≡ 1 (mod 3).

Thus n² mod 3 is either 0 or 1.
-/

theorem sq_mod_three_eq_zero_or_one (n : ℕ) : n ^ 2 % 3 = 0 ∨ n ^ 2 % 3 = 1 := by
  -- Use the division algorithm to write n = 3q + r with r < 3
  have h := Nat.div_add_mod n 3
  let q := n / 3
  let r := n % 3
  have h_n_eq : n = 3 * q + r := by
    calc
      n = 3 * q + r := by
        rw [Nat.div_add_mod n 3]
        ring
      _ = 3 * q + r := rfl
  have hr_lt_3 : r < 3 := Nat.mod_lt n (by norm_num)
  -- Since r < 3, r can be 0, 1, or 2
  have hr_cases : r = 0 ∨ r = 1 ∨ r = 2 := by
    interval_cases r
    · left; rfl
    · right; left; rfl
    · right; right; rfl
  rcases hr_cases with (hr | hr | hr)
  · -- r = 0: n = 3q, so n² = 9q², which is divisible by 3
    rw [hr] at h_n_eq
    rw [h_n_eq]
    simp [show (3 * q) ^ 2 = 3 * (3 * q ^ 2) by ring]
    left
    rfl
  · -- r = 1: n = 3q + 1, so n² = 9q² + 6q + 1 = 3(3q² + 2q) + 1
    rw [hr] at h_n_eq
    rw [h_n_eq]
    calc
      ((3 * q + 1) ^ 2) % 3 = (9 * q ^ 2 + 6 * q + 1) % 3 := by ring
      _ = ((9 * q ^ 2 + 6 * q) + 1) % 3 := by ring
      _ = ((9 * q ^ 2 + 6 * q) % 3 + 1 % 3) % 3 := by rw [Nat.add_mod]
      _ = (0 + 1) % 3 := by
        -- 9q² + 6q is divisible by 3
        have h_div : 3 ∣ 9 * q ^ 2 + 6 * q := by
          have h9 : 3 ∣ 9 * q ^ 2 := by
            have : 9 * q ^ 2 = 3 * (3 * q ^ 2) := by ring
            rw [this]
            exact ⟨3 * q ^ 2, by ring⟩
          have h6 : 3 ∣ 6 * q := by
            have : 6 * q = 3 * (2 * q) := by ring
            rw [this]
            exact ⟨2 * q, by ring⟩
          exact Nat.dvd_add h9 h6
        rw [Nat.mod_eq_zero_of_dvd h_div, show (1 : ℕ) % 3 = 1 by norm_num]
      _ = 1 := by norm_num
    right
    rfl
  · -- r = 2: n = 3q + 2, so n² = 9q² + 12q + 4 = 3(3q² + 4q + 1) + 1
    rw [hr] at h_n_eq
    rw [h_n_eq]
    calc
      ((3 * q + 2) ^ 2) % 3 = (9 * q ^ 2 + 12 * q + 4) % 3 := by ring
      _ = ((9 * q ^ 2 + 12 * q) + 4) % 3 := by ring
      _ = ((9 * q ^ 2 + 12 * q) % 3 + 4 % 3) % 3 := by rw [Nat.add_mod]
      _ = (0 + 1) % 3 := by
        have h_div : 3 ∣ 9 * q ^ 2 + 12 * q := by
          have h9 : 3 ∣ 9 * q ^ 2 := by
            have : 9 * q ^ 2 = 3 * (3 * q ^ 2) := by ring
            rw [this]
            exact ⟨3 * q ^ 2, by ring⟩
          have h12 : 3 ∣ 12 * q := by
            have : 12 * q = 3 * (4 * q) := by ring
            rw [this]
            exact ⟨4 * q, by ring⟩
          exact Nat.dvd_add h9 h12
        rw [Nat.mod_eq_zero_of_dvd h_div, show (4 : ℕ) % 3 = 1 by norm_num]
      _ = 1 := by norm_num
    right
    rfl

-- A cleaner corollary using the ModEq notation
theorem sq_mod_three_not_two (n : ℕ) : ¬ n ^ 2 ≡ 2 [MOD 3] := by
  rcases sq_mod_three_eq_zero_or_one n with (h | h)
  · intro h2
    have : n ^ 2 % 3 = 2 := Nat.ModEq.modEq_iff_mod_eq.mp h2
    rw [h] at this
    omega
  · intro h2
    have : n ^ 2 % 3 = 2 := Nat.ModEq.modEq_iff_mod_eq.mp h2
    rw [h] at this
    omega
