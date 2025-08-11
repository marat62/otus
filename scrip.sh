#!/bin/bash


SCRIPT1="my_first_script.sh"
SCRIPT2="my_second_script.sh"


NICE_LEVEL1=-10  # Более высокий приоритет
NICE_LEVEL2=10   # Низкий приоритет


LOG_FILE="execution_times.log"


rm -f "$LOG_FILE"

echo "Начало тестирования..." > "$LOG_FILE"


echo "Запускаем первый скрипт с уровнем приоритета $NICE_LEVEL1..."
nice -n $NICE_LEVEL1 /usr/bin/time -o first_time.log sh "$SCRIPT1" &>> "$LOG_FILE"


FIRST_TIME=$(<first_time.log tail -n1 | awk '{print $1}')

echo "Запускаем второй скрипт с уровнем приоритета $NICE_LEVEL2..."
nice -n $NICE_LEVEL2 /usr/bin/time -o second_time.log sh "$SCRIPT2" &>> "$LOG_FILE"


SECOND_TIME=$(<second_time.log tail -n1 | awk '{print $1}')

echo "" >> "$LOG_FILE"
echo "Итоги:" >> "$LOG_FILE"
echo "Время выполнения первого скрипта: $FIRST_TIME сек." >> "$LOG_FILE"
echo "Время выполнения второго скрипта: $SECOND_TIME сек." >> "$LOG_FILE"

echo "Тестирование завершено. Результаты сохранены в $LOG_FILE."
