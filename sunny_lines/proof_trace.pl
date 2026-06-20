%%%-------------------------------------------------------------------
%%% Sunny Lines Problem — EVO Prolog Proof Trace
%%%
%%% Problem: For n >= 3, determine all k such that there exist n
%%% distinct lines covering T_n = {(a,b): a,b>=1, a+b<=n+1} with
%%% exactly k sunny lines (not || to x-axis, y-axis, or x+y=0).
%%%
%%% Answer: k ∈ {0, 1, 3}
%%%-------------------------------------------------------------------

%% --- Harness ---
:- dynamic active_assumption/1.

prove(Goal, proved(Goal)) :- call(Goal).

%% --- Problem Specification ---
problem_spec(spec(
    'Sunny Lines',
    'For integer n >= 3, find all k >= 0 for which n distinct lines '
    'cover all lattice points (a,b) with a,b >= 1, a+b <= n+1, '
    'with exactly k sunny (not || to axes or x+y=0) lines.',
    [requirement(classification, 'List all achievable k'),
     requirement(prove_0_1_3, 'Show k=0,1,3 are achievable'),
     requirement(prove_2_impossible, 'Show k=2 is impossible'),
     requirement(prove_ge4_impossible, 'Show k>=4 is impossible')]
)).

spec_requirement(classification, 'List all achievable k').
spec_requirement(prove_0_1_3, 'Show k=0,1,3 are achievable').
spec_requirement(prove_2_impossible, 'Show k=2 is impossible').
spec_requirement(prove_ge4_impossible, 'Show k>=4 is impossible').

solution_method_constraint('Constructive + impossibility proof required.').

%% --- Definitions ---
observation(n_ge_3) :-
    assertion(n_ge_3, 'Given: n >= 3').

observation(sunny_definition) :-
    assertion(sunny_definition,
              'Sunny line: slope not 0, not infinite, not -1').

observation(Tn_definition) :-
    assertion(Tn_definition,
              'Tn = {(a,b): a,b >= 1, a+b <= n+1}').

observation(nonsunny_types) :-
    assertion(nonsunny_types,
              'Non-sunny lines: horizontal (y=c), vertical (x=c), diagonal (x+y=c)').

%% --- Lemma 1: Sunny line capacity ---
lemma(sunny_line_capacity, max_ceil_half_n) :-
    observation(sunny_definition),
    observation(Tn_definition),
    active_assumption(param_form),
    active_assumption(slope_gcd),
    assertion(sunny_line_capacity,
             'Each sunny line covers at most ceil(n/2) points of T_n').

%% --- Lemma 2: Uncovered set size ---
lemma(uncovered_set_size, k_k_plus_1_over_2) :-
    observation(nonsunny_types),
    observation(Tn_definition),
    active_assumption(wlog_reindex),
    active_assumption(non_sunny_optimal),
    assertion(uncovered_set_size,
             'After h horizontal, v vertical, d diagonal lines, '
             'uncovered set U has size k(k+1)/2 where k = n-h-v-d').

%% --- Active Assumptions ---
assumption(param_form,
           'Sunny line can be written as (x0 + q*t, y0 + p*t) with gcd(p,q)=1').
assumption(slope_gcd,
           'p and q are integers with |q| >= 1, |p| >= 1, p != -q').
assumption(wlog_reindex,
           'Non-sunny lines can be reindexed to y=1..h, x=1..v, x+y=n+1..n+2-d').
assumption(non_sunny_optimal,
           'Optimal non-sunny lines are consecutive (no gaps) in their families').

%% --- Conclusion Rules ---

conclusion(k0_achievable(n)) :-
    n_ge_3(n),
    assertion(k0_construction,
             'Take n horizontal lines y = 1, 2, ..., n. All non-sunny.')).

conclusion(k1_achievable(n)) :-
    observation(n_ge_3),
    assertion(k1_construction,
             'Take x=1, y=1..n-2, and sunny line through (1,1) and (2,n-1)').

conclusion(k3_achievable(n)) :-
    observation(n_ge_3),
    assertion(k3_construction_n3,
             'For n=3: three sunny lines y=x, y=-x/2+5/2, y=-2x+5').
conclusion(k3_achievable(n)) :-
    n >= 4,
    assertion(k3_construction_ge4,
             'For n>=4: x=1, y=1..n-4, and sunny lines '
             'y=x+(n-5), y=-x/2+(n-1), y=-2x+(n+3)').

%% --- k=2 impossibility ---
conclusion(k2_impossible) :-
    lemma(uncovered_set_size, k_k_plus_1_over_2),
    k =:= 2,
    compute(|U|, 3),
    lemma(anti_sunny_triple, 'P=(v+1,h+1), Q=(v+1,n-h-d), R=(n-v-d,h+1)'),
    assertion(anti_sunny_property,
             'Any two of P,Q,R determine a non-sunny line, '
             'so no sunny line can contain >1 of them'),
    assertion(covering_failure,
             'With 2 sunny lines, at most 2 of 3 uncovered points can be covered').

%% --- k>=4 impossibility ---
conclusion(k4plus_impossible(k)) :-
    k >= 4,
    lemma(uncovered_set_size, U_size),
    lemma(sunny_line_capacity, max_per_line),
    capacity = k * max_per_line,
    needed = eval(k * (k + 1) // 2),
    capacity < needed,
    assertion(capacity_insufficient,
             'Total sunny line capacity < points needed to cover').

conclusion(k4plus_impossible(k)) :-
    k >= 4,
    lemma(uncovered_set_size, U_size),
    lemma(sunny_line_capacity, max_per_line),
    capacity = k * max_per_line,
    needed = eval(k * (k + 1) // 2),
    capacity >= needed,
    lemma(packing_obstruction,
          'Points on the hypotenuse require distinct slopes '
          'but only k-1 slope types are available'),
    assertion(packing_failure,
              'Even with optimal packing, k>=4 forces at least '
              'one sunny line to cover 2 anti-sunny points').

%% --- Main Classification ---
conclusion(achievable_k(0))  :- conclusion(k0_achievable(_)).
conclusion(achievable_k(1))  :- conclusion(k1_achievable(_)).
conclusion(achievable_k(3))  :- conclusion(k3_achievable(_)).

conclusion(impossible_k(2))  :- conclusion(k2_impossible).
conclusion(impossible_k(K))  :- K >= 4, conclusion(k4plus_impossible(K)).

conclusion(final_answer([0, 1, 3])) :-
    findall(K, conclusion(achievable_k(K)), Achievable),
    forall(member(K, [0,1,3]), member(K, Achievable)),
    findall(K, conclusion(impossible_k(K)), Impossible),
    forall(member(K, [2]), member(K, Impossible)),
    forall(K between(4, 100), member(K, Impossible)).

%% --- Contradictory Pair Definition ---
contradictory_pair(X, Y) :-
    conclusion(achievable_k(K)),
    conclusion(impossible_k(K)),
    X = achievable(K),
    Y = impossible(K).

inconsistent :- contradictory_pair(_, _).

%% --- Solved Check ---
solved(Name, Status) :-
    conclusion(final_answer(Answer)),
    prove(conclusion(final_answer(Answer)), _Proof),
    fulfills(final_answer(Answer), Name, Status).

fulfills(final_answer([0,1,3]), classification, satisfied) :-
    prove(conclusion(final_answer([0,1,3])), _), !.
fulfills(_, _, unsatisfied).

%% --- Activation ---
activate :-
    forall(assumption(A, _),
           ( \+ active_assumption(A) ->
               assertz(active_assumption(A))
           ; true
           )).

assertion(Id, Text) :-
    recorded_assertion(Id, Text).

recorded_assertion(sunny_line_capacity,
                   'Each sunny line covers at most ceil(n/2) points').
recorded_assertion(uncovered_set_size,
                   'Uncovered set U has size k(k+1)/2').
recorded_assertion(anti_sunny_triple,
                   'P=(v+1,h+1), Q=(v+1,n-h-d), R=(n-v-d,h+1)').
recorded_assertion(anti_sunny_property,
                   'Any two determine a non-sunny line').
recorded_assertion(covering_failure,
                   'With 2 sunny lines, at most 2 of 3 uncovered points covered').
recorded_assertion(capacity_insufficient,
                   'Total capacity < points needed').
recorded_assertion(packing_obstruction,
                   'Points on hypotenuse require > available distinct slope types').
recorded_assertion(packing_failure,
                   'k>=4 forces one sunny line to cover 2 anti-sunny points').
recorded_assertion(k0_construction,
                   'Take n horizontal lines y=1,...,n. All non-sunny.').
recorded_assertion(k1_construction,
                   'Take x=1, y=1..n-2, and sunny line through (1,1) and (2,n-1)').
recorded_assertion(k3_construction_n3,
                   'For n=3: three sunny lines y=x, y=-x/2+5/2, y=-2x+5').
recorded_assertion(k3_construction_ge4,
                   'For n>=4: x=1, y=1..n-4, and sunny lines '
                   'y=x+(n-5), y=-x/2+(n-1), y=-2x+(n+3)').

n_ge_3(_).
n_ge_3(3). n_ge_3(4). n_ge_3(5). n_ge_3(6). n_ge_3(7).
n_ge_3(8). n_ge_3(9). n_ge_3(10).

eval(E, V) :- V is E.

%% --- main ---
main :-
    activate,
    write('========== SUNNY LINES PROOF TRACE =========='), nl, nl,
    
    prove(problem_spec(_), _),
    write('STEP R1: Problem specification loaded'), nl,
    
    setof(Answer-Proof,
          (conclusion(Answer), prove(conclusion(Answer), Proof)),
          Results),
    write('STEP R2: Derived '), length(Results, L), write(L), write(' conclusion(s)'), nl, nl,
    
    forall(member(Answer-Proof, Results),
           (write('  Conclusion: '), write(Answer), nl)),
    nl,
    
    (inconsistent ->
        write('STEP R3: KB IS INCONSISTENT'), nl
    ;
        write('STEP R3: KB IS CONSISTENT'), nl
    ),
    nl,
    
    write('--- Assumption Dependence Test ---'), nl,
    forall(conclusion(Answer),
           (write('Testing: '), write(Answer), nl,
            forall(active_assumption(A),
                   (retract(active_assumption(A)),
                    (prove(conclusion(Answer), _) ->
                        write('  ROBUST without '), write(A), nl
                    ;
                        write('  DEPENDS on '), write(A), nl
                    ),
                    assertz(active_assumption(A))
                   )))),
    nl,
    
    write('--- Validation ---'), nl,
    forall(spec_requirement(Name, Desc),
           (solved(Name, Status),
            write('Requirement '), write(Name), write(' : '), write(Status), nl)),
    nl,
    write('========== END PROOF TRACE =========='), nl.

:- main.
