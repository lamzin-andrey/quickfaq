module SiteSelfSignedSslTls
    # sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048\
    # -keyout /etc/ssl/private/apache-selfsigned.key\
    # -out /etc/ssl/certs/apache-selfsigned.crt
    
    # Если в форме CPanel Vista три поля,
    
    # Private key
    # CSR
    # Certificate
    
    # Кнопку Generate KEy CSR не трогаем. (Можно тронуть и посмотреть, не сгенерит ли серификат, но пока не удалось)
    # Вместо этого открываем /etc/ssl/private/apache-selfsigned.key
    # Вставляем в первое поле (Private key)
    # Жмём Upload Key
    
    #~ После обновления страницы
    #~ (поле Private key вроде бы оставалось без изменений, но если это не так снова вставить в него контент из)
    #~ /etc/ssl/private/apache-selfsigned.key
    
    #~ CSR - оставляем пустым
    #~ Certificate - вставляем контент  /etc/ssl/certs/apache-selfsigned.crt
    
    #~ Браузер всё равно пишет, что соединение не защищено, но первый шаг сделан
    
end
