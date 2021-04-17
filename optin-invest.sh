export INVESTOR_ADDR="INVESTORADDRESSACCOUNT"

goal app optin  --app-id $APP_ID \
                --from $INVESTOR_ADDR

goal app call --app-id $APP_ID \
              --app-arg "str:invest" \
              --from=$INVESTOR_ADDR \
              --out=unsignedtransaction1.tx \
              -d ~/node/data

goal clerk send --from=$INVESTOR_ADDR \
                --to=$ESCROW_ADDR \
                --amount=500000 \
                --out=unsignedtransaction2.tx \
                -d ~/node/data

cat unsignedtransaction1.tx unsignedtransaction2.tx > combinedtransactions.tx

goal clerk group -i combinedtransactions.tx -o groupedtransactions.tx 
goal clerk sign -i groupedtransactions.tx -o signout.tx
goal clerk rawsend -f signout.tx