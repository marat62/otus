# Файловые системы и LVM

#Уменьшить том под / до 8G
#Диски по умолчанию 
<img width="624" height="325" alt="image" src="https://github.com/user-attachments/assets/772410fb-1066-4355-a092-5aa7691d2303" />

Подготовка временного раздела и создание файловой системы
<img width="624" height="307" alt="image" src="https://github.com/user-attachments/assets/4c4ae80a-1a9a-4434-aa8d-1c1fe8fa3fa2" />

 Данные скопированы на временный раздел
<img width="624" height="75" alt="image" src="https://github.com/user-attachments/assets/b7b0e594-ab09-465e-a680-b8de753bfec0" />

Конфигурируем grub для того, чтобы при старте перейти в новый /.
Сымитируем текущий root, сделаем в него chroot и обновим grub:
<img width="624" height="324" alt="image" src="https://github.com/user-attachments/assets/37e562c5-8220-4c68-a044-f94efa1fd2aa" />

Состояние дисков после перезагрузки 
<img width="624" height="344" alt="image" src="https://github.com/user-attachments/assets/1c42ca55-f2a3-4a77-8855-50fad35e8f1d" />

Уменьшил раздел и вернул загрузку на прежний раздел 
<img width="624" height="498" alt="image" src="https://github.com/user-attachments/assets/92d873cb-9955-410c-b646-0a5a5fa8e81f" />

# Выделить том под /var в зеркало
<img width="624" height="548" alt="image" src="https://github.com/user-attachments/assets/aaf2ad6b-6e75-4997-ba02-9a3d6e4d0b01" />

<img width="624" height="332" alt="image" src="https://github.com/user-attachments/assets/bb9c54c4-7b7b-42b6-94e8-26b1906a6bae" />

#Выделяем том под home
<img width="624" height="384" alt="image" src="https://github.com/user-attachments/assets/a817f6bf-017d-416f-b5aa-5e07c0a755c1" />

#Снапшоп
<img width="624" height="482" alt="image" src="https://github.com/user-attachments/assets/9224bcb6-8314-4f4d-b326-ce10996e331a" />
