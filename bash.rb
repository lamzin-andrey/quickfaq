module FileSystem
	class DirectorySize
		du -hs /path/to/dir
	end
end

module ssh
	class screen
		#~ На примере переноса данных с лжного хоста на другой.
		#~ screen -S move_api_data_2024-09
		#~ Выйти:
		#~ Вы можете легко выйти из screen - сессии набрав:
		#~ Ctrl+a и d

		#~ Вернуться
		#~ screen -r

		#~ Если у вас запущено больше чем одна screen - сессия, то после ключа r нужно указать ее ID. Узнать его просто с помощью команды:

		#~ screen -ls
		#~ There are screens on:
				#~ 32328.move_api_data_2024-05  (Detached)
				#~ 32482.wiki.merionet.ru_is_one_love      (Detached)
		#~ 2 Sockets in /var/run/screen/S-root.

		#~ screen -r 32328
		
		# Kill screen
		# screen -X -S [session # you want to kill] quit
	end
end

