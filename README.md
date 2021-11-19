## Описание тривиальной канарейки за основу взята статья [Blue/Green Deployments using Helm Charts](https://medium.com/harness-engineering/blue-green-deployments-using-helm-charts-93ec479c0282) 

### в файле cannary/values.yaml  , параметр меняем на свой:
```
ingress:
  hostname: prod.172.16.10.97.nip.io
```

деплоим, основной траффик идет на сервис с меткой blue

```
helm upgrade --install test  --set blue.enabled=true ./cannary
```
### Важный элемент в этой схеме  productionSlot, он и будет указателем куда направлять траффик основной


узнать кто сейчас productionSlot выызваем скрипт, так он еще зансет переменные в окружение  
```
. switching_deploy.sh
```


### Включаем green еще один деплой и подключаем к нему канареечный через ingress nginx

```
helm upgrade --install test --set productionSlot=$currentSlot --set blue.enabled=true --set green.enabled=true --set canary.enabled=true ./cannary
```


### проверка канарейки 

```
curl -H "cannary: on" http://prod.172.16.10.97.nip.io/test.txt
```

### переключение на blue и green 

в CI описать включние основного траффика на green и выключение cannary

```
helm upgrade --install test --set productionSlot=green --set blue.enabled=true --set green.enabled=true --set canary.enabled=false ./cannary
```

в CI описать включние основного траффика на blue и выключение cannary

```
helm upgrade --install test --set productionSlot=blue --set blue.enabled=true --set green.enabled=true --set canary.enabled=false ./cannary
```

### отключение старого релиза deployment можно только после того как пройдеи -n время или ждем время или отмашки 

Пример, отключения green deployment:

```
helm upgrade --install test --set productionSlot=blue --set blue.enabled=true --set green.enabled=false --set canary.enabled=false ./cannary
```


### Удалить проект
```
helm uninstall test
```