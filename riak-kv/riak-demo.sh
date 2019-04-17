#!/bin/bash

RIAK_PORT=8098
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


waitForConfirmBeforeExecuting "curl -I http://localhost:$RIAK_PORT/riak/${RED}no_bucket/no_key${NC}"

waitForConfirmBeforeExecuting "curl -v -X ${RED}PUT${NC} http://localhost:$RIAK_PORT/riak/${RED}animals/ace${NC} -H \"Content-Type: application/json\" ${RED}-d '{\"nickname\" : \"The Wonder Dog\", \"breed\" : \"German Shepherd\"}'${NC}"

waitForConfirmBeforeExecuting "curl -X GET http://localhost:${RIAK_PORT}/${RED}riak?buckets=true${NC}"

waitForConfirmBeforeExecuting "curl -v -X PUT http://localhost:$RIAK_PORT/riak/animals/ace${RED}?returnbody=true${NC} -H \"Content-Type: application/json\" -d '{\"nickname\" : \"The Wonder Dog\", \"breed\" : \"German Shepherd\"}'"

waitForConfirmBeforeExecuting "curl -X PUT http://localhost:$RIAK_PORT/riak/photos/polly.jpg -H \"Content-type: image/jpeg\" --data-binary @polly_image.jpg"

waitForConfirmBeforeExecuting "xdg-open http://localhost:$RIAK_PORT/riak/photos/polly.jpg"