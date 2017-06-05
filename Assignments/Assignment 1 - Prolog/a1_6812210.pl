% Assignment 1 CSI2120 A
% Prolog
% Student name: Alexandre Billard
% Student number: 6812210

% Question 1a
% Please find the attacked pdf holding the drawing.

% Question 1b
p1(X,Y):-p3(X),p2(Y,X).
p2(X,Y):-p3(X),p4(Y),X\=Y,!.
p3(a).
p3(b).
p3(c).
p3(d).
p4(c).
p4(a).
p4(b).

% Question 2a
cubeLess( X, B, R ) :-
    C is X * X * X,
    C < B,
    R is B - C.

% Question 2b
smallerCube( 1,B ) :-
    !, cubeLess(1,B,R),
    write(1),
    write(' rest '),
    writeln(R),
    R > 0,
    smallerCube( 2, B ).


smallerCube( X, B ) :-
    cubeLess(X,B,R),
    write(X),
    write(' rest '),
    writeln(R),
    R > 0,
    XN is X + 1,
    smallerCube( XN, B ).

% Question 2c
restSum(B,RS) :-
    restSum(1,B,0,RS).

restSum(X,B,S,RS) :-
    cubeLess(X,B,R),
    R > 0,!,
    SN is R + S,
    XN is X + 1,
    restSum(XN,B,SN,RS).

restSum(_,_,S,RS) :-
    RS is S.

% Question 2d
showAllRestSum(H,H) :- !.

showAllRestSum(L,H) :-
    L<H,
    restSum(L,S),
    SR is S mod 3,
    SR =:= 0,
    write(L), write(' rest '), writeln(S),
    LN is L + 1,!,
    showAllRestSum(LN,H).

showAllRestSum(L,H) :-
    L<H,
    restSum(L,_),
    LN is L + 1,!,
    showAllRestSum(LN,H).

% Question 3a
% tents(tname, sleepNum, tweight, tcost).
tents('Dreamer', 2, 4.5, 199).
tents('Hermite', 1, 2, 159).
tents('Family', 5, 5 , 349).
tents('Expedition', 8, 8.5, 699).

% slpBags(sbname, tempRes, style, sbweight, spcost).
slpBags('Mountain', -15, 'mummy', 1.5, 350).
slpBags('Cabin', 5, 'double-bag', 5, 250).
slpBags('Square', -3, 'rectangular', 2.5, 150).

% slpPads(spname, thickness, spweight spcost).
slpPads('Rock', 2, 0.2, 100).
slpPads('Pfft', 3, 0.8, 10).
slpPads('Heaven', 10, 0.4, 80).
slpPads('Moon', 5, 0.4, 80).

% backpacks(bname, bweight, bcost).
backpacks('Trapper', 20, 250).
backpacks('Prospector', 25, 220).
backpacks('Air', 10, 150).
backpacks('Comfort', 15, 200).

% Question 3b
paul( T, SB, SP, BP, TP ) :-
    tent(T,_,_,P1),
    sleepingBag(SB,TEMP,_,_,P2),
    TEMP =< 0,
    sleepingPad(SP,THICK,_,P3),
    THICK >= 5,
    backPack(BP,_,P4),
    TP is P1 + P2 + P3 + P4.


% Question 3c
tripFor4(PW,mary(MB,MP),sean(SB,SP),
	 paula(PTB,PP),thomas(PTB,TP), tents( T1, T2),
	 backpacks(B1,B2)) :-
    sleepingBag(MB,_,_,WMB,_),
    sleepingBag(SB,_,_,WSB,_),
    sleepingBag(PTB,_,_,WPTB,_),
    sleepingBag(PTB,_,_,WPTB,_), % Not Needed
    sleepingPad(MP,_,WMP,_),
    sleepingPad(SP,_,WSP,_),
    sleepingPad(PP,_,WPP,_),
    sleepingPad(TP,_,WTP,_),
    tent(T1,P1,WT1,_),
    tent(T2,P2,WT2,_),
    P1 + P2 >= 4,
    backPack(B1,WB1,_),
    backPack(B2,WB2,_),
    0 =< WB1+WB2-WMB-WSB-WPTB-WMP-WSP-WPP-WTP-WT1-WT2-4*PW.

% Question 3d
% 3d
% special format is tent,sleeping bag, sleeping pad, backpack, weight of
% personal belongings each, no. persons, price
special(basic,dreamer,cabin,pfft,trapper,W,2,600) :-
    tent(dreamer,_,WT,_),
    sleepingBag(cabin,_,_,WSB,_),
    sleepingPad(pfft,_,WSP,_),
    backPack(trapper,WBP,_),
    WBP =< 2*W + WT + WSB + WSP + WSP.

special(extra,hermite,mountain,rock,air,W,1,650) :-
    tent(hermite,_,WT,_),
    sleepingBag(maountain,_,_,WSB,_),
    sleepingPad(rock,_,WSP,_),
    backPack(air,WBP,_),
    WBP >= W + WT + WSB + WSP.

% Either take the cabin sleeping bag for 2 or two sleeping bags
sleepFor2(SB,SB,W,P) :-
    SB = cabin,
    sleepingBag(SB,_,_,W,P).

sleepFor2(SB1,SB2,W,P) :-
    sleepingBag(SB1,_,_,W1,P1),
    sleepingBag(SB2,_,_,W2,P2),
    W is W1+W2,
    P is P1+P2.

% Either take a special for 2 or individual sets
setFor2( PW, T, SB, SP, SB, SP, BP, P ) :-
    special(_,T,SB,SP,BP,PW,NP,PP),
    NP >= 2,
    PP =< P.

setFor2( PW, T, SB1, SP1, SB2, SP2, BP, P ) :-
    tent(T,TP,WT,PT),
    TP >= 2,
    sleepFor2(SB1,SB2,WSB,PSB),
    sleepingPad(SP1,_,W1,PSP1),
    sleepingPad(SP2,_,W2,PSP2),
    backPack(BP,BPW,PBP),
    BPW >= PW+PW+WSB+WT+W1+W2,
    P >= PT+PSB+PSP1+PSP2+PBP.

% Other combinations for setFor2 are possible but will not produce a solution

% Solution will not show if two sleeping bags for two or only one were selected
equipment2(PW,jill(JB,JP),kyle(KB,KP),tents(T),
	   backpacks(BP),P) :-
    setFor2( PW, T, JB, JP, KB, KP, BP, P ).


% recursive
tentFor(N,W) :- tentFor(N,0,W).

tentFor(N,TW,W) :-
    N =< 0,
    W is TW.

tentFor(N,TW,W) :-
    N > 0,
    tent(_,NP,WT,_),
    NN is N - NP,
    NTW is TW + WT,
    tentFor(NN,NTW,W).

% Question 3e
comfort(GW,guide(GB,GP),backpacks(GBP),N) :-
    sleepingPad(heaven,_,WC,_),
    sleepingBag(GB,_,_,WGB,_),
    sleepingPad(GP,_,WGP,_),
    NN is N+1,
    tentFor(NN,WT),
    backPack(GBP,WBP,_),
    N*WC+WT+WGB+WGP+GW < WBP.
