#!/bin/bash 

currentSlot=`helm get values --all test | grep -Po 'productionSlot: \K.*'`

if [ "$currentSlot" == "blue" ]; then
    newSlot="green"
    echo "cannary green \n"
    echo 'Изменяем image образ в green deploumet --set на новый собранный образ'
else
    newSlot="blue"
    echo "cannary blue \n"
    echo 'Изменяем image образ в blue deploumet --set на новый собранный образ'
fi

