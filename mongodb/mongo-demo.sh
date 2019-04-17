#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

function waitForConfirmBeforeExecuting() {
	[[ $1 ]]    || { echo "Missing operand" >&2; return 1; };
  echo ""
  echo -n "$ ";
  read;
  echo -ne "$ $1";
  read;
  commandWithoutColourEscapes=$(sed -r "s/\\\033\[0;31m//g" <<< $1);
  commandWithoutNoColourEscapes=$(sed -r "s/\\\033\[0m//g" <<< $commandWithoutColourEscapes);
  bash -c "$commandWithoutNoColourEscapes";
}

CMD=$(cat << EOF
mongo --username root --password root --eval "${RED}db.towns.insert${NC}({
  name: \"New York\",
  population: 22200000,
  lastCensus: ISODate(\"2016-07-01\"),
  famousFor: [ \"the MOMA\", \"food\", \"Derek Jeter\" ],
  mayor : {
    name : \"Bill de Blasio\",
    party : \"D\"
  }
});"
EOF
)

waitForConfirmBeforeExecuting "$CMD"

waitForConfirmBeforeExecuting "mongo --username root --password root --eval \"${RED}db.getCollectionNames()${NC}\" "

waitForConfirmBeforeExecuting "mongo --username root --password root --eval \"db.towns.${RED}find()${NC}\" "

waitForConfirmBeforeExecuting "mongo --username root --password root --eval \"db.${RED}help()${NC}\" "

waitForConfirmBeforeExecuting "mongo --username root --password root --eval \"db.towns.${RED}help()${NC}\" "

waitForConfirmBeforeExecuting "mongo --username root --password root ${RED}load-data.js${NC} "

waitForConfirmBeforeExecuting "mongo --username root --password root --eval \"db.towns.${RED}find()${NC}\" "

waitForConfirmBeforeExecuting "mongo --username root --password root --eval \"db.towns.find(
  { name : ${RED}/^P/${NC} },
  { name : 1, population : 1 }
)\""

waitForConfirmBeforeExecuting "mongo --username root --password root --eval \"db.towns.find(
  { famousFor: 'food' },
  { _id: 0, name: 1, famousFor: 1 }
)\""