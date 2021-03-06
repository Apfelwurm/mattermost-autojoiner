#!/bin/bash

while true
do


    if [ -z $MM_ACESS_TOKEN ]; then
        mmctl auth login $MM_INSTANCE --name $MM_SERVERNAME --username $MM_USERNAME --password $MM_PASSWORD

    else

        mmctl auth login $MM_INSTANCE --name $MM_SERVERNAME --access-token $MM_ACESS_TOKEN

    fi

    users=($(mmctl user list --all --format json | jq '.[].username' | sed 's|"||g'| sed 's|surveybot||g'))
    teams=($(mmctl team list --format json | jq '.[].name'| sed 's|"||g'))

    # printf '%s\n' "${users[@]}"

    echo "$(date) autojoin starting with $SLEEPTIMERSEC seconds command delay "
    for i in "${teams[@]}"
    do
    : 

    if [ ! -z $i ]; then
            echo "$(date) iterating team: $i"
            # echo $i
            channels=($(mmctl channel list $i --format json | jq '.[].name'| sed 's|"||g'))
            for u in "${users[@]}"
            do
                :
                if [ ! -z $u ]; then
                    echo "$(date) iterate user $u in team $i run command:"
                    echo "mmctl team users add $i $u"
                    mmctl team users add $i $u
                    sleep $SLEEPTIMERSEC
                fi
            done




            for c in "${channels[@]}"
            do
                : 

                if [ ! -z $c ]; then
                    echo "$(date) iterate channel $c in team $i"
                    for u in "${users[@]}"
                    do
                        :
                        if [ ! -z $u ]; then
                            echo "$(date) iterate user $u in channel $c run command:"
                            echo "mmctl channel users add $i:$c $u"
                            mmctl channel users add $i:$c $u
                            sleep $SLEEPTIMERSEC
                        fi

                    done
                fi

            done
        fi


    done
echo "$(date) autojoin finished, waiting $($RUNOVERSEC / 60) minutes / $RUNOVERSEC seconds ..."
sleep $RUNOVERSEC
done