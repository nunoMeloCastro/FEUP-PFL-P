:- dynamic round/4.

% round(RoundNumber, DanceStyle, Minutes, [Dancer1-Dancer2 | DancerPairs])
% round/4 indica, para cada ronda, o estilo de dança, a sua duração, e os pares de dançarinos participantes.
round(1, waltz, 8, [eugene-fernanda]).
round(2, quickstep, 4, [asdrubal-bruna,cathy-dennis,eugene-fernanda]).
round(3, foxtrot, 6, [bruna-dennis,eugene-fernanda]).
round(4, samba, 4, [cathy-asdrubal,bruna-dennis,eugene-fernanda]).
round(5, rhumba, 5, [bruna-asdrubal,eugene-fernanda]).

% tempo(DanceStyle, Speed).
% tempo/2 indica a velocidade de cada estilo de dança.
tempo(waltz, slow).
tempo(quickstep, fast).
tempo(foxtrot, slow).
tempo(samba, fast).
tempo(rhumba, slow).

/* ex1 */
%%%style_round_number(?DanceStyle, ?RoundNumber)
style_round_number(Style, Round):-
    round(Round, Style, _Min, _Pair).

/* ex2 */
%%%n_dancers(?RoundNumber, -NDancers)
n_dancers(Round, NDancers):-
    round(Round, _Style, _Min, Pairs),
    length(Pairs, L),
    NDancers is L * 2.

/* ex3 */
%%%danced_in_round(?RoundNumber, ?Dancer)
danced_in_round(Round, Dancer):-
    round(Round, _Style, _Min, Pairs),
    member(Dancer-_Pair, Pairs).

danced_in_round(Round, Dancer):-
    round(Round, _Style, _Min, Pairs),
    member(_Pair-Dancer, Pairs).

/* ex4 */
%%%n_rounds(-NRounds)
n_rounds(N):-
    round(N, _Style, _Min, _Pairs),
    \+ (round(R, _, _, _), R > N).

/* ex5 */
%%%add_dancer_pair(+RoundNumber, +Dancer1, +Dancer2)
add_dancer_pair(Round, Dancer1, Dancer2):-
    \+ (danced_in_round(Round, Dancer1)),
    \+ (danced_in_round(Round, Dancer2)),
    retract(round(Round, Style, Min, Pairs)),
    assert(round(Round, Style, Min, [Dancer1-Dancer2|Pairs])).

/* ex6 */

%%%total_dance_time(+Dancer, -Time)~
total_dance_time(Dancer, Time):-
    n_rounds(N),
    danceTime(Dancer, Time, N).

danceTime(_D, 0, 0).
danceTime(D, T, R):-
    R >= 1,
    R1 is R - 1,
    danceTime(D, TAux, R1),
    round(R, _Style, Min, _Pairs),
    danced_in_round(R, D),
    !,
    T is TAux + Min.
danceTime(D, T, R):-
    R >= 1,
    R1 is R - 1,
    danceTime(D, T, R1).

/* ex7 */
print_program:-
    round(R, S, T, P),
    length(P, NP),
    format('~a (~d) - ~d',[S, T, NP]),
    nl,
    fail.
print_program.




    
    



    