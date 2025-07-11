# Работа с mdadm
# Задание
• Добавить в виртуальную машину несколько дисков
• Собрать RAID-0/1/5/10 на выбор
• Сломать и починить RAID
• Создать GPT таблицу, пять разделов и смонтировать их в системе.
# Основные команды
- fdisk -l просмотр подключенных дисков
- mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f} создание RAID массива
- parted -s /dev/md0 mklabel gpt создание gpt раздела
# Собранный RAID
<img width="824" height="542" alt="image" src="https://github.com/user-attachments/assets/ac547e97-55f8-44f9-8a68-f9ffe1935d63" />
# Сломанный RAID 

<img width="824" height="144" alt="image" src="https://github.com/user-attachments/assets/e262b604-7670-41db-8874-4eee93e95bcd" />

# Удаление сломанного диска и добавление нового 

<img width="824" height="144" alt="image" src="https://github.com/user-attachments/assets/bf1a6fc9-5920-4037-8e92-50014272333e" />
<img width="921" height="287" alt="image" src="https://github.com/user-attachments/assets/16583148-4f4d-484d-877e-3c9ebffb903e" />
