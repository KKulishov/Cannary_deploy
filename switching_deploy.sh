#!/bin/bash 

currentSlot=`helm get values --all test | grep -Po 'productionSlot: \K.*'`

if [ "$currentSlot" == "blue" ]; then
    newSlot="green"
    echo -e "Текуший деплой $currentSlot \n"
    echo -e "Какой планируем развернуть cannary green \n"
    echo -e "Укажи --set productionSlot=green \n"
    echo 'Изменяем image образ в green deploumet --set на новый собранный образ'
else
    newSlot="blue"
    echo -e "Текуший деплой $currentSlot \n"
    echo -e "Какой планируем развернуть cannary blue \n"
    echo -e "Укажи --set productionSlot=blue \n"
    echo 'Изменяем image образ в blue deploumet --set на новый собранный образ'
fi

