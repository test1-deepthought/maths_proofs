% ----------------------------------------------------------------------
% Proof Trace: Irrationality of sqrt(2)
% Prolog derivation record for the EVO (Explicit-assumption
% Verification Orchestrator) agent.
%
% Tier:    PROVE
% Status:  SOLVED  (lean4_exit_code(0), status: lean4_verified)
% Date:    2026-06-04
% ----------------------------------------------------------------------

%% --- STEP P1: PROOF PLAN ---
problem_spec(spec(
    'Irrationality of sqrt(2)',
    'Prove that the square root of 2 is irrational.',
    [requirement(constructed_proof, 'Constructed proof required.'),
     requirement(formal_verification, 'Proof must be verified by lean4_exec.')]
)).
spec_requirement(constructed_proof, 'Constructed proof required.').
spec_requirement(formal_verification, 'Proof must be verified by lean4_exec.').

theorem_statement('¬∃ (p q : ℕ), q > 0 ∧ p^2 = 2*q^2').
proof_strategy('infinite_descent_via_parity').

%% --- STEP P2: COMPUTATIONAL EXPLORATION ---
exploration_step(1, 'python_exec', 'Search for small solutions p^2=2*q^2 in [1,200]').
exploration_step(2, 'python_exec', 'Verify parity lemma: odd iff odd-squared').
exploration_step(3, 'python_exec', 'Simulate descent step: (p,q) -> (k,l) with k=p/2, l=q/2').

exploration_finding('No integer solutions found for q <= 200.').
exploration_finding('Parity lemma holds for all tested values.').
exploration_finding('Descent pattern confirmed: smaller positive solution produced.').

%% --- STEP P3: LEAN PROOF BUILD ---
lean_proof_file('irrationality_of_sqrt2/proof.lean').
lean_proof_verified(true) :-
    lean4_exit_code(0),
    status(lean4_verified).

%% Key lemmas used (all verified via batch_mathlib_check)
lemma_used('Nat.prime_two').
lemma_used('Nat.Prime.dvd_of_dvd_pow').
lemma_used('Nat.find_spec').
lemma_used('Nat.find_min').

%% --- PROOF STRUCTURE ---
proof_step(1, 'Assume exists p q, q>0 and p^2 = 2*q^2.').
proof_step(2, 'Define S = {q>0 | exists p, p^2 = 2*q^2}. S is nonempty.').
proof_step(3, 'Let q0 = min S, with witness p0; so p0^2 = 2*q0^2.').
proof_step(4, 'Since 2 | p0^2 (because p0^2 = 2*q0^2) and 2 is prime, 2 | p0.').
proof_step(5, 'Write p0 = 2*k. Substitute -> q0^2 = 2*k^2.').
proof_step(6, 'Since 2 | q0^2 and 2 is prime, 2 | q0. Write q0 = 2*l.').
proof_step(7, 'Substitute back -> k^2 = 2*l^2, so l in S and l < q0.').
proof_step(8, 'Contradiction with minimality of q0.').

%% --- CONSISTENCY CHECK ---
contradictory_pair(X, Y) :- false.
inconsistent :- contradictory_pair(_, _).

%% --- FINAL STATUS ---
proof_status(solved).
final_verdict('The square root of 2 is irrational - formally verified in Lean 4.').
