:-dynamic navigation/2,
	  navPoint/3,
	  self/3,
	  pickup/3,
	  orientation/3,
	  status/4,
	  currentWeapon/2,
	  item/4,
	  respawn/0,
	  deployable/1,
	  deploy/0,
	  needArmor/0,
	  isArmorPack/1,
	  unreachable/1,
	  weapon/3,
	  slowVolume/1,
	  powerup/2,
	  pickUpHp/0,
	  pickUpArmor/0,
	  pickUpWeapon/0,
	  navigateRandom/0,
	  bot/6,
	  shootEnemy/0.

% We are at a certain location if the IDs match, or ...
at(UnrealID) :- navigation(reached,UnrealID).
% ... if the coordinates are approximately equal.
at(location(X,Y,Z)) :- navigation(reached,location(X1,Y1,Z1)), 
	round(X) =:= round(X1), round(Y) =:= round(Y1), round(Z) =:= round(Z1).
	
% Checks if the current HP is less than 80, if so, needHealth returns true.
needHealth :- status(HP,_,_,_), HP < 80.
% Checks if the given ID is an UnrealID of a health pickup.
isHealthPack(ID) :- pickup(ID, health, _).

% Same as health pack, checks if the given ID is an UnrealID of an armor pickup
isArmorPack(ID) :- pickup(ID, armor, _).
% seeArmor is true iff we can see an item that is an armor pack
seeArmor :- item(_,_,_,Pos), isArmorPack(Pos).
% Do we need armor? This is true if the current Armor status is less than 100 (So only false when we have full armor)
needArmor :- status(_,AP,_,_), AP < 100.

% This checks if we have the current weapon in our inventory (based on UnrealID).
needThisWeapon(ID) :- not(weapon(ID,_,_)).
% Can we see a weapon that we also need?
seeWeapon :- item(_, weapon, Label, _), needThisWeapon(Label).

% Can we see another bot (Because it is DM, all bots are enemies, in a team based setup this has to be altered slightly)
seeEnemy :- bot(_,_,_,_,_,_).