import Mathlib

/--
  Theorem: The square root of 2 is irrational.

  Formal statement: there are no natural numbers p, q with q > 0 such that
  p² = 2·q².  (Equivalently, √2 cannot be expressed as a reduced fraction p/q.)

  Proof strategy — infinite descent (well-ordering principle):

  1. Assume a solution exists, i.e., ∃ p q, q > 0 ∧ p² = 2·q².
  2. Let S = {q > 0 | ∃ p, p² = 2·q²}.  By assumption S is nonempty.
  3. Let q₀ = min S, with witness p₀, so p₀² = 2·q₀².
  4. Since 2 | p₀²  (because p₀² = 2·q₀²) and 2 is prime, 2 | p₀.
     Write p₀ = 2·k.
  5. Substituting: (2k)² = 2·q₀²  ⇒  4k² = 2·q₀²  ⇒  q₀² = 2·k².
     Hence 2 | q₀², and since 2 is prime, 2 | q₀.  Write q₀ = 2·ℓ.
  6. Substituting back: (2k)² = 2·(2ℓ)²  ⇒  k² = 2·ℓ².
     So ℓ ∈ S with ℓ < q₀ (because q₀ = 2·ℓ > 0).
  7. This contradicts the minimality of q₀.  Hence no solution exists.

  Key Mathlib lemmas used:
    • Nat.prime_two          —  2 is prime
    • Nat.Prime.dvd_of_dvd_pow  —  prime p ∣ mⁿ ⇒ p ∣ m
    • Nat.find / Nat.find_min   —  well-ordering (minimal counterexample)
    • omega / nlinarith         —  arithmetic reasoning
-/
theorem sqrt_two_irrational : ¬∃ (p q : ℕ), q > 0 ∧ p ^ 2 = 2 * q ^ 2 := by
  intro h
  -- S = {q > 0 | ∃ p, p² = 2·q²}
  set S := {q : ℕ | q > 0 ∧ ∃ p : ℕ, p ^ 2 = 2 * q ^ 2} with hS
  have hS_nonempty : S.Nonempty := by
    rcases h with ⟨p, q, hqpos, h_eq⟩
    refine ⟨q, ?_⟩
    rw [hS]
    exact ⟨hqpos, p, h_eq⟩
  -- q₀ = min S  (well-ordering principle)
  let q0 := Nat.find hS_nonempty
  have hq0_mem : q0 ∈ S := Nat.find_spec hS_nonempty
  rcases hq0_mem with ⟨hq0pos, p0, h_eq0⟩
  have hq0_min : ∀ x, x < q0 → x ∉ S := by
    intro x hx_lt
    exact Nat.find_min hS_nonempty hx_lt
  -- 2 is prime
  have h2prime : Nat.Prime 2 := Nat.prime_two
  -- 2 ∣ p₀², hence 2 ∣ p₀
  have hp0_2 : 2 ∣ p0 := by
    have h2_dvd_p0sq : 2 ∣ p0 ^ 2 := by
      rw [h_eq0]
      exact ⟨q0 ^ 2, by ring⟩
    exact h2prime.dvd_of_dvd_pow h2_dvd_p0sq
  rcases hp0_2 with ⟨k, hk⟩
  -- From p₀ = 2k, substitute into p₀² = 2·q₀²  ⇒  q₀² = 2·k²
  have hq0sq_eq : q0 ^ 2 = 2 * k ^ 2 := by
    nlinarith
  -- 2 ∣ q₀², hence 2 ∣ q₀
  have hq0_2 : 2 ∣ q0 := by
    have h2_dvd_q0sq : 2 ∣ q0 ^ 2 := by
      rw [hq0sq_eq]
      exact ⟨k ^ 2, by ring⟩
    exact h2prime.dvd_of_dvd_pow h2_dvd_q0sq
  rcases hq0_2 with ⟨l, hl⟩
  -- From q₀ = 2ℓ, substitute back  ⇒  k² = 2·ℓ²
  have hk_eq : k ^ 2 = 2 * l ^ 2 := by
    nlinarith
  -- Since q₀ = 2ℓ and q₀ > 0, we have ℓ < q₀
  have hl_lt_q0 : l < q0 := by
    omega
  have hlpos : l > 0 := by
    omega
  -- Then ℓ ∈ S, contradicting minimality
  have hl_mem : l ∈ S := by
    rw [hS]
    exact ⟨hlpos, k, hk_eq⟩
  exact hq0_min l hl_lt_q0 hl_mem
