## Part 07.  Prometheus and Grafana
### 1. Установка и настройка Prometheus и Grafana

#### Установка Prometheus:
<p>    

    groupadd --system prometheus

    useradd -s /sbin/nologin --system -g prometheus prometheus

    apt install prometheus
    
</p>

#### Установка Grafana по туториалу:
<p>

[setup-grafana/installation/debian/](https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/)
</p>

### 2. Запуск веб интерфейсов

Порт prometheus - 9090
Порт grafana - 3000

### 5. Утилита stress
    
    apt install stress

    stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s
    


