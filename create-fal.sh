export DATE=`date "+%Y%m%d-%H%M%S"`

# get timestamp in seconds for the startDate
export FALSD=$(DATE '+%s')

# we allow 30min for investors to place their bid 
invs=1800
invss=2500

# FAL endDate
export FALED=$(( $FALSD + $invs ))

# FAL closeDate
export FALCD=$(( $FALED + $invss ))

# FAL listingID https://algoexplorer.io/asset/71054280
export LISTINGID="71054280"

export ADDR_CREATOR="YOURACCOUNTIDENTIFIERGOESHERE"

export TEAL_APPROVAL_PROG="fal-approval_program.teal" 
export TEAL_CLEAR_PROG="fal-clear_state.teal"

export GLOBAL_BYTESLICES=3
export GLOBAL_INTS=6
export LOCAL_BYTESLICES=0
export LOCAL_INTS=1

goal app create --creator $ADDR_CREATOR \
                --approval-prog $TEAL_APPROVAL_PROG \
                --clear-prog $TEAL_CLEAR_PROG \
                --global-byteslices $GLOBAL_BYTESLICES \
                --global-ints $GLOBAL_INTS \
                --local-byteslices $LOCAL_BYTESLICES \
                --local-ints $LOCAL_INTS \
                --app-arg "int:$LISTINGID" \
                --app-arg "int:$FALSD" \
                --app-arg "int:$FALED" \
                --app-arg "int:1000000" \
                --app-arg "addr:$ADDR_CREATOR" \
                --app-arg "int:$FALCD" \
                -d ~/node/data