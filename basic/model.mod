set ProductGroups;

param nRows;
set Rows := 1..nRows;
param cashierCount;
param cashierLength;
param space{ProductGroups};

var lengthOfRows{Rows} >= 0;
var BuildingLength >= 0;
var cashierInRow{Rows} binary;
var productInRow{Rows, ProductGroups} binary;

s.t. LegthCount{r in Rows}:
	cashierInRow[r]*cashierLength + sum{p in ProductGroups}productInRow[r, p]*space[p] = lengthOfRows[r];

s.t. OneProductInOneRow{p in ProductGroups}:
	sum{r in Rows}productInRow[r, p] = 1;

s.t. LongestRowDefined{r in Rows}:
	BuildingLength >= lengthOfRows[r];

s.t. CountCashiers:
	sum{r in Rows}cashierInRow[r] = cashierCount;

minimize LengthOfTheShop:
	BuildingLength;
solve;
printf "%f\n",BuildingLength;
end;
