export TEAL_ESCROW_PROG="fal-escrow.teal" 
export RECEIVER_ADDR="RECEIVERADDRESSACCOUNT"

goal app call --app-id $APP_ID \
              --app-arg "str:claim" \
              --from $RECEIVER_ADDR \
              --out=unsignedtransaction1.tx \
              -d ~/node/data

goal clerk send --to=$RECEIVER_ADDR \
                --close-to=$RECEIVER_ADDR \
                --from-program=$TEAL_ESCROW_PROG \
                --amount=0 \
                --out=unsignedtransaction2.tx \
                -d ~/node/data

cat unsignedtransaction1.tx unsignedtransaction2.tx > combinedtransactions.tx
goal clerk group -i combinedtransactions.tx -o groupedtransactions.tx 
goal clerk split -i groupedtransactions.tx -o split.tx 

goal clerk sign -i split-0.tx -o signout-0.tx
cat signout-0.tx split-1.tx > signout.tx
goal clerk rawsend -f signout.tx