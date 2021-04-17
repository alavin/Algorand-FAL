export TEAL_ESCROW_PROG="fal-escrow.teal" 

goal app call --app-id $APP_ID \
              --app-account=$ESCROW_ADDR \
              --app-arg "str:reclaim" \
              --from $INVESTOR_ADDR \
              --out=unsignedtransaction1.tx

# reclaim amount less the transaction fee
goal clerk send --to=$INVESTOR_ADDR \
                --close-to=$INVESTOR_ADDR \
                --from-program=$TEAL_ESCROW_PROG \
                --amount=499000 \
                --out=unsignedtransaction2.tx

cat unsignedtransaction1.tx unsignedtransaction2.tx > combinedtransactions.tx
goal clerk group -i combinedtransactions.tx -o groupedtransactions.tx 
goal clerk split -i groupedtransactions.tx -o split.tx 

goal clerk sign -i split-0.tx -o signout-0.tx
cat signout-0.tx split-1.tx > signout.tx
goal clerk rawsend -f signout.tx