export APP_ID="1111"
export ESCROW_ADDR="ESCROWADDRESSACCOUNT"

goal app update --app-id=$APP_ID \
                --from $ADDR_CREATOR \
                --approval-prog $TEAL_APPROVAL_PROG \
                --clear-prog $TEAL_CLEAR_PROG \
                --app-arg "addr:$ESCROW_ADDR"