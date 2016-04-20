:-dynamic navigation/2,
	  navPoint/1,
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
	  isArmorPack/1.

% We are at a certain location if the IDs match, or ...
at(UnrealID) :- navigation(reached,UnrealID).
% ... if the coordinates are approximately equal.
at(location(X,Y,Z)) :- navigation(reached,location(X1,Y1,Z1)), 
	round(X) =:= round(X1), round(Y) =:= round(Y1), round(Z) =:= round(Z1).
	
needHealth :- status(HP,_,_,_), HP < 100.
isHealthPack(ID) :- pickup(ID, 'health', _).

needArmor :- status(_,AP,_,_), AP < 100.
isArmorPack(ID) :- pickup(ID, 'armor', _).