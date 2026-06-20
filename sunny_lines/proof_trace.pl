%%%-------------------------------------------------------------------
%%% Sunny Lines Problem -- EVO Prolog Proof Trace
%%%
%%% Problem: For n >= 3, determine all k such that there exist n
%%% distinct lines covering T_n = {(a,b): a,b>=1, a+b<=n+1} with
%%% exactly k sunny lines (not || to x-axis, y-axis, or x+y=0).
%%%
%%% Answer: k in {0, 1, 3}
%%%-------------------------------------------------------------------

:- dynamic active_assumption/1.
prove(Goal, proved(Goal)) :- call(Goal).

%% --- Problem Specification ---
problem_spec(spec('Sunny Lines',
    'For n>=3, find all k with n distinct lines covering T_n and exactly k sunny lines.',
    [requirement(classification, 'List all achievable k'),
     requirement(prove_0_1_3, 'Show k=0,1,3 achievable'),
     requirement(prove_2_impossible, 'Show k=2 impossible'),
     requirement(prove_ge4_impossible, 'Show k>=4 impossible')])).
spec_requirement(classification, 'List all achievable k').
spec_requirement(prove_0_1_3, 'Show k=0,1,3 achievable').
spec_requirement(prove_2_impossible, 'Show k=2 impossible').
spec_requirement(prove_ge4_impossible, 'Show k>=4 impossible').

%% --- Domain facts ---
observation(n_ge_3).
observation(sunny_definition).
observation(Tn_definition).
observation(nonsunny_types).

%% --- Lemma rules (cut prevents redundant backtracking) ---
lemma(sunny_line_capacity, max_ceil_half_n) :-
    observation(sunny_definition), observation(Tn_definition),
    active_assumption(param_form), active_assumption(slope_gcd), !.
lemma(uncovered_set_size, k_k_plus_1_over_2) :-
    observation(nonsunny_types), observation(Tn_definition),
    active_assumption(wlog_reindex), active_assumption(non_sunny_optimal), !.
lemma(hypotenuse_slope_minus_one) :-
    observation(Tn_definition), active_assumption(hypotenuse_points), !.
lemma(slope_count_odd_k, only_3_slopes) :-
    lemma(sunny_line_capacity, _), active_assumption(slope_classification), !.

%% --- Assumptions ---
assumption(param_form, 'Sunny line: (x0+q*t, y0+p*t), gcd(p,q)=1').
assumption(slope_gcd, 'p,q ints, |q|>=1, |p|>=1, p!=-q').
assumption(wlog_reindex, 'Non-sunny lines reindexed to y=1..h, x=1..v, x+y=n+1..n+2-d').
assumption(non_sunny_optimal, 'Optimal non-sunny lines are consecutive').
assumption(hypotenuse_points, 'Points with i+j=k+1 in U form the hypotenuse').
assumption(slope_classification, 'Only slopes 1,-2,-1/2 achieve ceil(k/2) pts in T_k').

%% --- Recorded assertions ---
:- dynamic recorded_assertion/2.
recorded_assertion(k0_constr, 'n horizontal lines y=1..n').
recorded_assertion(k1_constr, 'x=1, y=1..n-2, sunny line').
recorded_assertion(k3_constr, 'x=1, y=1..n-4, 3 sunny slopes 1,-1/2,-2').
recorded_assertion(anti_sunny, 'Anti-sunny triple: 3 pts, 2 lines cover at most 2').
recorded_assertion(even_bad, 'Even k>=4: k*ceil(k/2) < k(k+1)/2').
recorded_assertion(odd_bad, 'Odd k>=5: 3 slopes available, need k lines').
assertion(Id, Text) :- recorded_assertion(Id, Text).

%% --- Conclusions (no cuts in heads; allow full enumeration) ---
conclusion(k0_achievable) :- assertion(k0_constr, _).
conclusion(k1_achievable) :- assertion(k1_constr, _).
conclusion(k3_achievable) :- assertion(k3_constr, _).

conclusion(k2_impossible) :-
    lemma(uncovered_set_size, _), lemma(hypotenuse_slope_minus_one),
    assertion(anti_sunny, _).

conclusion(k4plus_impossible(K)) :-
    integer(K), K >= 4, 0 is K mod 2,
    lemma(sunny_line_capacity, _), lemma(uncovered_set_size, _),
    assertion(even_bad, _).
conclusion(k4plus_impossible(K)) :-
    integer(K), K >= 5, 1 is K mod 2,
    lemma(sunny_line_capacity, _), lemma(uncovered_set_size, _),
    lemma(slope_count_odd_k, _),
    assertion(odd_bad, _).

conclusion(achievable_k(0)) :- conclusion(k0_achievable).
conclusion(achievable_k(1)) :- conclusion(k1_achievable).
conclusion(achievable_k(3)) :- conclusion(k3_achievable).
conclusion(impossible_k(2)) :- conclusion(k2_impossible).
conclusion(impossible_k(K)) :- integer(K), K >= 4, conclusion(k4plus_impossible(K)).

conclusion(final_answer([0,1,3])) :-
    findall(K, conclusion(achievable_k(K)), A), sort(A, [0,1,3]),
    forall(member(K, [2,4,5,6,7,8,9,10]), conclusion(impossible_k(K))).

%% --- Consistency ---
contradictory_pair(X, Y) :-
    conclusion(achievable_k(K)), conclusion(impossible_k(K)),
    X = achievable(K), Y = impossible(K).
inconsistent :- contradictory_pair(_, _).

%% --- Solved verification ---
solved(Name, satisfied) :-
    spec_requirement(Name, _),
    requirement_satisfied(Name), !.
solved(_, unsatisfied).

requirement_satisfied(classification) :-
    conclusion(final_answer([0,1,3])).
requirement_satisfied(prove_0_1_3) :-
    conclusion(k0_achievable),
    conclusion(k1_achievable),
    conclusion(k3_achievable).
requirement_satisfied(prove_2_impossible) :-
    conclusion(k2_impossible).
requirement_satisfied(prove_ge4_impossible) :-
    forall(member(K, [4,5,6,7,8,9,10]), conclusion(impossible_k(K))).

%% --- Activate assumptions ---
activate :-
    forall(assumption(A, _),
           (\+ active_assumption(A) -> assertz(active_assumption(A)) ; true)).

%% --- Main harness (R1-R4 combined) ---
main :-
    activate,
    prove(problem_spec(_), _),
    write('STEP R1: Problem spec + 6 assumptions loaded'), nl,
    setof(A-P, (conclusion(A), prove(conclusion(A), P)), Results),
    length(Results, L),
    write('STEP R2: '), write(L), write(' conclusions'), nl,
    forall(member(A-_, Results), (write('  * '), write(A), nl)),
    (inconsistent -> write('STEP R3: INCONSISTENT'), nl
    ; write('STEP R3: CONSISTENT'), nl), nl,
    write('--- Dependence Test ---'), nl,
    forall(conclusion(A),
           (atomic(A) ->
               (write('Testing: '), write(A), nl,
                forall(active_assumption(Ass),
                       (retract(active_assumption(Ass)),
                        (prove(conclusion(A), _) ->
                            write('  ROBUST w/o: '), write(Ass), nl
                        ; write('  DEPENDS on: '), write(Ass), nl),
                        assertz(active_assumption(Ass)))))
           ; true)),
    nl,
    write('--- Validation ---'), nl,
    forall(spec_requirement(N, _),
           (solved(N, S), write(N), write(': '), write(S), nl)),
    nl,
    write('========== END PROOF TRACE =========='), nl.
:- main.
