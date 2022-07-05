jogo(1,sporting,porto,1-2).
jogo(1,maritimo,benfica,2-0).
jogo(2,sporting,benfica,0-2).
jogo(2,porto,maritimo,1-0).
jogo(3,maritimo,sporting,1-1).
jogo(3,benfica,porto,0-2).

treinadores(porto,[[1-3]-sergio_conceicao]).
treinadores(sporting,[[1-2]-silas, [3-3]-ruben_amorim]).
treinadores(benfica,[[1-3]-bruno_lage]).
treinadores(maritimo,[[1-3]-jose_gomes]).

/* ex1 */
n_treinadores(Equipa, Num):-
    treinadores(Equipa, Lista),
    length(Lista, Num).

/* ex2 */
n_jornadas_treinador(Treinador, Num):-
    treinadores(_Equipa, [[X-Y]-Treinador|_Lista]),
    Aux is Y - X,
    Num is Aux + 1.
n_jornadas_treinador(Treinador, Num):-
    treinadores(_Equipa, [_|[[X-Y]-Treinador|_Lista]]),
    Aux is Y - X,
    Num is Aux + 1.


/* ex3 */
ganhou(Jorn, E1, E2):-
    jogo(Jorn, E1, E2, X-Y),
    X > Y,
    !.
ganhou(Jorn, E2, E1):-
    jogo(Jorn, E1, E2, X-Y),
    Y > X.
    
/* ex4 */
%c

/* ex5 */
%e

/* ex 6 */
% o X:- treinadores(X, _).
% o X venceu o Y :- ganhou(_, X, Y).

/* ex7 */
predX(N,N,_).
predX(N,A,B):-
    !,
    A \= B,
    A1 is A + sign(B- A),
    predX(N,A1,B).

/* ex7 a */
%enviando um N verifica se este se encontra entre A e B senão obtem todos os valores de A até B começando em A.

/* ex7 b */
%e um cut verde, não altera soluções, apenas evita backtracking desnecessario.

/* ex8 */
treinador_bom(Treinador):-
    treinadores(Equipa, [[Ini-Fim]-Treinador|_Lista]),
    n_jornadas_treinador(Treinador, Num),
    Cont is Num,
    invicto(Equipa, Ini, Fim, Acc, Cont),
    Acc = Num.
treinador_bom(Treinador):-
    treinadores(Equipa, [_|[[Ini-Fim]-Treinador|_Lista]]),
    n_jornadas_treinador(Treinador, Num),
    Cont is Num,
    invicto(Equipa, Ini, Fim, Acc, Cont),
    Acc = Num.

invicto(_E1, _J, _Fim, 0, 0).
invicto(E1, J, Fim, Acc, C):-
    nao_perdeu(J, E1, _E2),
    J =< Fim,
    !,
    C1 is C - 1,
    J1 is J + 1,
    invicto(E1, J1, Fim, Acc1, C1),
    Acc is Acc1 + 1.
invicto(E1, J, Fim, Acc, C):-
    J =< Fim,
    J1 is J + 1,
    C1 is C - 1,
    invicto(E1, J1, Fim, Acc, C1).

nao_perdeu(Jorn, E1, E2):-
    jogo(Jorn, E1, E2, X-Y),
    Res is X - Y,
    Res >= 0,
    !.
nao_perdeu(Jorn, E2, E1):-
    jogo(Jorn, E1, E2, X-Y),
    Res is X - Y,
    Res =< 0.

/* ex9 */

imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').
imprime_texto(X,'vitoria da casa'):-
    X = 1.
imprime_texto(X,'empate'):-
    X = 0.
imprime_texto(X,'derrota da casa'):-
    X = -1.

ganhou2(J, E1, E2, N):-
    ganhou(J, E1, E2),
    N = 1,
    !.
ganhou2(J, E1, E2, N):-
    ganhou(J, E2, E1),
    N = -1,
    !.
ganhou2(_J, _E1, _E2, 0).

imprime_jogos(F):-
    jogo(J, E1, E2, _),
    format('Jornada ~d: ~s x ~s - ',[J, E1, E2]),
    ganhou2(J, E1, E2, Res),
    X =.. [F, Res, P],
    X,
    write(P),
    nl,
    fail.
imprime_jogos(_).


/* ex10 */
%e

/* ex11 */
%e

/* ex12 */
is_treinador(Tr):-
    treinadores(_Equipa, [_L1|[[_Res]-Tr|_L2]]).
is_treinador(Tr):-
    treinadores(_Equipa, [[_Res]-Tr|_L]).

lista_treinadores(L):-
    findall(Tr, is_treinador(Tr),L).

/* ex13 */
:- use_module(library(lists)).
duracao_treinadores(L):-
    setof(T-Tr, (n_jornadas_treinador(Tr,T), is_treinador(Tr)), L1),
    reverse(L1, L).

/* ex14 */


