param nRows;
param cashierCount;
param cashierLength;
set ProductGroups;
param space{ProductGroups};

var assign{1..nRows,ProductGroups} binary;
var cashAssign{1..nRows,1..cashierCount} binary;

var BuildingLength;

s.t. setMaxLength{r in 1..nRows}:
	BuildingLength >= sum{p in ProductGroups} assign[r,p]*space[p] + sum{c in 1..cashierCount}cashAssign[r,c]*cashierLength; 
s.t. assignEveryPG{p in ProductGroups}:
	1 = sum{r in 1..nRows} assign[r,p];
s.t. assignEveryCashier{p in 1..cashierCount}:
	1 = sum{r in 1..nRows} cashAssign[r,p];

minimize Len: BuildingLength;

solve;
printf "%f\n",BuildingLength;

