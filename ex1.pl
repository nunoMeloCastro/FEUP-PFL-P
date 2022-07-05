/*
PLOG - Ficha TP7 - Exercício 1
By: Gonçalo Leão
*/

%%% a
male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(cameron). % Example of a homosexual relationship. This affects how we define siblings!
male(joe).
male(manny).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(pameron).
female(haley).
female(alex).
female(lily).
female(poppy).

parent(grace,phil).
parent(frank,phil).

parent(dede,claire).
parent(jay,claire).
parent(dede,mitchell).
parent(jay,mitchell).

parent(jay,joe).
parent(gloria,joe).

parent(gloria,manny).
parent(javier,manny).

parent(barb,cameron).
parent(merle,cameron).
parent(barb,pameron).
parent(merle,pameron).

parent(phil,haley).
parent(claire,haley).
parent(phil,alex).
parent(claire,alex).
parent(phil,luke).
parent(claire,luke).

parent(mitchell,lily).
parent(cameron,lily).
parent(mitchell,rexford).
parent(cameron,rexford).

parent(pameron,calhoun).
parent(bo,calhoun).

parent(dylan,george).
parent(haley,george).
parent(dylan,poppy).
parent(haley,poppy).

% b
% i. A Haley é do sexo feminino?
% female(haley).
% ii. O Gil é do sexo masculino?
% male(gil).
% iii. O Frank é progenitor do Phil?
% parent(frank,phil).
% iv. Quem são os pais da Claire?
% parent(P,claire).
% v. Quem são os filhos da Gloria?
% parent(gloria,C).
% vi. Quem são os netos do Jay?
% parent(jay,_C), parent(_C,G).
% vii. Quem são os avós da Lily?
% parent(_P,lily), parent(G,_P).
% viii. A Alex tem filhos?
% parent(alex,_).
% ix. Quem é filho do Jay, mas não da Gloria?
% parent(jay,C), \+parent(gloria,C).

%%% c
% father(?Father,?Child).
father(P,C):- parent(P,C), male(P).

% grandparent(?Grandparent,?GrandChild).
grandparent(G,GChild):- parent(G,Parent), parent(Parent,GChild).
% The rule above is more efficient than the one below, if:
% 1 - grandparent/2 is often called with GChild uninstanciated.
% 2 - We assume noways people have less children than the previous generation
% which implies less matches for parent(G,Parent) than parent(Parent,GChild).
% grandparent(G,GChild):- parent(G,Parent), parent(Parent,GChild).

% grandmother(?Grandmother,?GrandChild).
grandmother(G,GChild):- mother(G,P), parent(P,GChild).
% grandmother/2 uses the auxiliary predicate mother/2.
% mother(?Mother,?Child).
mother(P,C):- parent(P,C), female(P).

% siblings(?OneSibling,?AnotherSibling).
siblings(A,B):- parent(P1,A), parent(P1,B), parent(P2,A), parent(P2,B), P1 @< P2, A \= B.

% Solution assuming all relations are heterosexual: 
siblings(A,B):- father(F,A), mother(M,A), father(F,B), mother(M,B), A \= B.

% halfsiblings(?OneHalfSibling,?AnotherHalfSibling).
halfsiblings(A,B):- parent(P,A), parent(P,B), A \= B, \+siblings(A,B).

% Solution assuming all relations are heterosexual:
% halfsiblings(A,B):- father(P,A), father(P,B), mother(M,A), \+mother(M,B), A \= B.
% halfsiblings(A,B):- mother(M,A), mother(M,B), father(P,A), \+father(P,B), A \= B.

% cousins(?OneCousin,?AnotherCousin).
cousins(A,B):- grandparent(G,A), grandparent(G,B), A \= B.

% uncle(?Uncle,?NephewNiece).
uncle(A,B):- siblings(A,P), male(A), parent(P,B).

% aunt(?Aunt,?NephewNiece).
aunt(A,B):- siblings(A,P), female(A), parent(P,B).

% More challenging predicates

% first_alphabetical_child(?P,?C): The child of P whose names comes first alphabetically is C.
first_alphabetical_child(P,C):- parent(P,C), \+((parent(P,C1), C1 @< C)).

% has_exactly_1_child(?P): P has exactly one child.
has_exactly_1_child(P):- parent(P,C), \+((parent(P,C1), C \= C1)).

% has_exactly_2_children(?P): P has exactly two children.
% This solution prevents duplicate answers.
has_exactly_2_children(P):- parent(P,C1), parent(P,C2), C1 @< C2, \+((parent(P,C3), C3 \= C1, C3 \= C2)).

% has_2plus_children(?P): P has at least two children.
% This solution prevents duplicate answers.
has_2plus_children(P):- parent(P,C1), parent(P,C2), C1 @< C2, \+((parent(P,C3), C3 \= C1, C3 @< C2)).

%%% d
% Haley e Lily são primas?
% cousins(haley,lily).
% Quem é o pai de Luke?
% father(Darth,luke).
% Quem é tio de Lily?
% uncle(U,lily).
% Quem é avó?
% grandmother(G,_C), \+((grandmother(G,C1), C1 @> _C)).
% A query acima remove soluções duplicatas usando o not (\+).
% Listar todos os pares de irmãos.
% siblings(A,B), A @< B.
% Listar todos os pares de irmãos ou meios-irmãos.
% (siblings(A,B);halfsiblings(A,B)), A @< B.
% Nota: usar o OR (;) não é boa prática. É melhor definir um predicado auxiliar.

%%% e
% married(Husband,Wife,Year).
married(jay,gloria,2008).
married(jay,dede,1968).

% divorced(Husband,Wife,Year).
divorced(jay,dede,2003).

% currently_married(?Husband,?Wife,+Year).
% The plus (+) on the third argument means that Year must always be instanciated.
% The question marks (?) denote that Husband and Wife can be instanciated or not.
currently_married(H,W,Y):-
    married(H,W,Y1),
    Y >= Y1,
    \+divorced(H,W,_). % underscore (_) means "don't care"
currently_married(H,W,Y):-
    married(H,W,Y1),
    Y >= Y1,
    divorced(H,W,Y2),
    Y =< Y2.
% Tip: always remember that the comparison operators have a sad face: =< and >= (<= is incorrect).