## Часть 8. Готовая приборная панель

### Запускаем нагрузочный тест сети с помощью iperf3
Сервер:

    iperf3 -s -f K

Клиент:

    iperf3 -c 192.168.1.108 -f K