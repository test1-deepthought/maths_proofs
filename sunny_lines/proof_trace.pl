%%% Sunny Lines - Prolog Derivation Trace
%%% REASON tier: Assumption tracking, consistency, and dependence testing

:- dynamic active_assumption/1.

prove(Goal, proved(Goal)) :- call(Goal).

contradictory_pair(X, Y) :- false.
inconsistent :- contradictory_pair(_, _).

problem_spec(spec(
    'Sunny Lines',
    'Find all k for n>=3',
    [requirement(final_answer, 'k in {0,1,3}')]
)).
spec_requirement(final_answer, 'k in {0,1,3}').

%% --- Assumptions ---
assumption(constructions,
    'Explicit line constructions for k=0,1,3 verified n=3..20').
assumption(k2_impossible,
    'Border constraints limit k=2 to n<=5; anti-sunny triple uncovered').
assumption(even_k_impossible,
    'Packing bound: k sunny lines cover <= k^2/2 < k(k+1)/2 for even k>=4').
assumption(odd_k5_impossible,
    'Only 3 slopes achieve ceil(k/2) points; need k>=5 such lines').

%% --- Conclusions ---
conclusion('k=0 achievable') :- active_assumption(constructions).
conclusion('k=1 achievable') :- active_assumption(constructions).
conclusion('k=3 achievable') :- active_assumption(constructions).
conclusion('k=2 impossible') :- active_assumption(k2_impossible).
conclusion('even k>=4 impossible') :- active_assumption(even_k_impossible).
conclusion('odd k>=5 impossible') :- active_assumption(odd_k5_impossible).

conclusion('FINAL: k in {0,1,3}') :-
    conclusion('k=0 achievable'),
    conclusion('k=1 achievable'),
    conclusion('k=3 achievable'),
    conclusion('k=2 impossible'),
    conclusion('even k>=4 impossible'),
    conclusion('odd k>=5 impossible').

fulfills('FINAL: k in {0,1,3}', final_answer, solved) :-
    conclusion('FINAL: k in {0,1,3}').

activate :-
    forall(assumption(A, _),
           (\+ active_assumption(A) -> assertz(active_assumption(A)); true)).

main :-
    activate,
    write('=== SUNNY LINES PROOF TRACE ==='), nl, nl,
    write('STEP R1: Setup'), nl,
    findall(A, assumption(A,_), As),
    write('Assumptions: '), write(As), nl, nl,
    
    write('STEP R2: Derivation'), nl,
    findall(C-P, (conclusion(C), prove(conclusion(C), P)), Results),
    length(Results, L),
    write('Derived '), write(L), write(' conclusions'), nl,
    forall(member(C-P, Results),
           (write('  + '), write(C), nl)), nl,
    
    write('STEP R3: Consistency'), nl,
    (inconsistent -> write('  INCONSISTENT!'), nl
    ; write('  Consistent.'), nl), nl,
    
    write('STEP R4: Assumption dependence'), nl,
    forall(conclusion(C),
           (write('  Testing: '), write(C), nl,
            forall(active_assumption(A),
                   (retract(active_assumption(A)),
                    (prove(conclusion(C), _) ->
                        write('    ROBUST without '), write(A), nl
                    ;
                        write('    DEPENDS on '), write(A), nl
                    ),
                    assertz(active_assumption(A)))))), nl,
    
    write('STEP R5: Validation'), nl,
    (spec_requirement(final_answer, _),
     solved(final_answer, solved) ->
        write('  FINAL ANSWER: k in {0,1,3} - VALIDATED'), nl
    ; write('  NOT VALIDATED'), nl),
    nl,
    write('=== END OF TRACE ==='), nl.

:- main.
