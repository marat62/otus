#!/bin/bash


LOGFILE="/var/log/nginx/access.log"
MAILTO="admin@example.com"
TEMP_DIR="/tmp/webstats"
PIDFILE="${TEMP_DIR}/webstats.pid"
BLOCKFILE="${TEMP_DIR}/block.lock"
TMP_LOGFILE="${TEMP_DIR}/log.tmp"
LAST_TIMESTAMP="${TEMP_DIR}/timestamp.txt"


check_block() {
    if [[ -f "$BLOCKFILE" ]]; then
        echo "Скрипт уже запущен."
        exit 1
    fi
}


setup_temp_dir() {
    mkdir -p "${TEMP_DIR}"
    touch ${BLOCKFILE}
    trap cleanup EXIT INT TERM
}


cleanup() {
    rm -rf "${BLOCKFILE}" "${TMP_LOGFILE}"
}


trap_handler() {
    echo "Получен сигнал прерывания!"
    cleanup
    exit 1
}


collect_stats() {
    local timestamp=$(cat ${LAST_TIMESTAMP})
    grep -v '^$' ${LOGFILE} > ${TMP_LOGFILE}

    awk -F'$$|$$' '{print substr($2, 1, length($2)-6)}' ${TMP_LOGFILE} \
        | while IFS= read -r time_str; do
            current_time=$(date -d "$time_str" +%s)
            if ((current_time <= timestamp)); then
                continue
            else
                break
            fi
        done


    date +%s > ${LAST_TIMESTAMP}

  
    IP_STATS=$(awk '{print $1}' ${TMP_LOGFILE} | sort | uniq -c | sort -nr | head -n 10)
    URL_STATS=$(awk '{print $7}' ${TMP_LOGFILE} | sort | uniq -c | sort -nr | head -n 10)
    ERROR_CODES=$(grep '"[^"]*"' ${TMP_LOGFILE} | awk '$NF ~ /^4/' | cut -d'"' -f3)
    HTTP_STATUSES=$(awk '{print $9}' ${TMP_LOGFILE} | sort | uniq -c | sort -nr)


    cat <<EOF > ${TEMP_DIR}/report.html
<!DOCTYPE html>
<html lang="ru">
<head><title>Отчет по мониторингу</title></head>
<body>
    <h1>Отчет мониторинга ($(date))</h1>
    <h2>Топ IP-адресов по числу запросов:</h2>
    <pre>$IP_STATS</pre>
    <h2>Самые частозапрашиваемые URL:</h2>
    <pre>$URL_STATS</pre>
    <h2>Серверные ошибки (>= 400):</h2>
    <pre>$ERROR_CODES</pre>
    <h2>Коды HTTP ответов:</h2>
    <pre>$HTTP_STATUSES</pre>
</body>
</html>
EOF
}

send_mail() {
    mail -aContent-type:text/html;charset=utf-8 -s "Мониторинг $(hostname)" ${MAILTO} < ${TEMP_DIR}/report.html
}


main() {
    check_block
    setup_temp_dir
    collect_stats
    send_mail
    cleanup
}


trap trap_handler INT TERM


main
exit 0
