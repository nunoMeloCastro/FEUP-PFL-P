/*
ex1a
*/
male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(cameron).
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

parent(grace, phil).
parent(frank, phil).
parent(dede, claire).
parent(jay, claire).
parent(jay, mitchell).
parent(dede, mitchell).
parent(jay, joe).
parent(gloria, joe).
parent(gloria, manny).
parent(javier, manny).
parent(barb, cameron).
parent(merle, cameron).
parent(merle, pameron).
parent(barb, pameron).
parent(phil, haley).
parent(claire, haley).
parent(phil, alex).
parent(claire, alex).
parent(phil, luke).
parent(claire, luke).
parent(mitchell, lily).
parent(cameron, lily).
parent(mitchell, rexford).
parent(cameron, rexford).
parent(pameron, calhoun).
parent(bo, calhoun).
parent(dylan, george).
parent(haley, george).
parent(dylan, poppy).
parent(haley, poppy).

/* 
ex1b 
/* i 
female(haley).
/* ii 
male(Gil).
/* iii 
parent(frank, phil).
/* iv 
parent(F, claire).
/* v
parent(gloria, C).
/* vi
parent(jay, _C), parent(_C, G).
/* vii
parent(_P, lily), parent(G, _P).
/* viii
parent(alex, _).
/* ix
parent(jay, _C), parent(_C, G).
*/

/*
ex1c
*/
father(frank, phil).
father(jay, claire).
father(jay, mitchell).
father(jay, joe).
father(javier, manny).
father(merle, cameron).
father(merle, pameron).
father(phil, haley).
father(phil, alex).
father(phil, luke).
father(mitchell, lily).
father(mitchell, rexford).
father(cameron, lily).
father(cameron, rexford).
father(bo, calhoun).
father(dylan, george).
father(dylan, poppy).

grandparent(grace, haley).
grandparent(grace, alex).
grandparent(grace, luke).

grandparent(frank, haley).
grandparent(frank, alex).
grandparent(frank, luke).

grandparent(dede, haley).
grandparent(dede, alex).
grandparent(dede, luke).
grandparent(dede, lily).
grandparent(dede, rexford).

grandparent(jay, haley).
grandparent(jay, alex).
grandparent(jay, luke).
grandparent(jay, lily).
grandparent(jay, rexford).

grandparent(barb, lily).
grandparent(barb, rexford).
grandparent(barb, calhoun).

grandparent(merle, lily).
grandparent(merle, rexford).
grandparent(merle, calhoun).

grandparent(phil, george).
grandparent(phil, poppy).

grandparent(claire, george).
grandparent(claire, poppy).

grandmother(grace, haley).
grandmother(grace, alex).
grandmother(grace, luke).

grandmother(dede, haley).
grandmother(dede, alex).
grandmother(dede, luke).
grandmother(dede, lily).
grandmother(dede, rexford).

grandmother(barb, lily).
grandmother(barb, rexford).
grandmother(barb, calhoun).

grandmother(claire, george).
grandmother(claire, poppy).

siblings(claire, mitchell).
siblings(mitchell, claire).

siblings(cameron, pameron).
siblings(pameron, cameron).

siblings(haley, alex).
siblings(haley, luke).
siblings(alex, luke).
siblings(alex, haley).
siblings(luke, haley).
siblings(luke, alex).

siblings(lily, rexford).
siblings(rexford, lily).

siblings(george, poppy).
siblings(poppy, george).

halfSiblings(claire, joe).
halfSiblings(claire, manny).

halfSiblings(mitchell, joe).
halfSiblings(mitchell, manny).

halfSiblings(joe, claire).
halfSiblings(joe, mitchell).
halfSiblings(joe, manny).

halfSiblings(manny, claire).
halfSiblings(manny, mitchell).
halfSiblings(manny, joe).

cousins(haley, lily).
cousins(haley, rexford).

cousins(alex, lily).
cousins(alex, rexford).

cousins(luke, lily).
cousins(luke, rexford).

cousins(lily, luke).
cousins(lily, alex).
cousins(lily, haley).
cousins(lily, calhoun).

cousins(rexford, luke).
cousins(rexford, alex).
cousins(rexford, haley).
cousins(rexford, calhoun).

cousins(calhoun, lily).
cousins(calhoun, rexford).

uncle(mitchell, luke).
uncle(mitchell, alex).
uncle(mitchell, haley).
uncle(mitchell, calhoun).

uncle(cameron, luke).
uncle(cameron, alex).
uncle(cameron, haley).
uncle(cameron, calhoun).

uncle(bo, lily).
uncle(bo, rexford).

uncle(phil, lily).
uncle(phil, rexford).

uncle(luke, george).
uncle(luke, poppy).

/* 
ex1d
/* i
cousins(haley, lily).
/* ii
father(F, luke).
/* iii
uncle(U, lily).
/* iv 
grandmother(G, _).