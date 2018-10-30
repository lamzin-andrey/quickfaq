module Xubuntu
	class XfceMenu
		def setup
			#Диалог настроек системы
			#Внешний вид
			#Вкладка Настройки
			#Включить редактируемые комбинации клавиш
		end
	end
    class AudioRecorder
        def howInstall
            #sudo apt-add-repository ppa:osmoma/audio-recorder
            #sudo apt-get update
            #sudo apt-get install audio-recorder
        end
        
    end
    
    class Mc
		def freeSpaceInfo
			#Смотрим статистику в правом нижнем углу
			#2341/2794 85%
			#Копируем папку объёмом 37Гб
			#Смотрим статистику в правом нижнем углу
			#2304/2749 83%
			#то есть после копирования папки в 37G число c % уменьшилось. То есть mc отображает процент свободного места
		end
    end
    
    class FlashPlayer
		def inslallStandalone
			sudo dpkg --add-architecture i386
			sudo apt-get update
			sudo apt-get install xvfb libcurl3:i386 libglib2.0-0:i386 libx11-6:i386 libxext6:i386 libxt6:i386 libxcursor1:i386 libnss3:i386 libgtk2.0-0:i386
			download from adobe flashplayer
		end
    end
    
    class grub2
		def recoveryInstalledUbuntuAfterInstallWin
			#load from live cd
			
			sudo fdisk -l #look, where is your Linux?
			#let it on /dev/sda1
			
			sudo mount /dev/sda1 /mnt
			sudo grub-install --root-directory=/mnt /dev/sda
			sudo update-grub --output=/mnt/boot/grub/grub.cfg
			
			#!! if after actions windows 10 fail
			
			#load from hard ubuntu
			sudo update-grub
			
		end
    end
    
    class Network
		def NetCartToNetCartConnect
			#Создать новое ethernet соединение из gui интерфейса
			#Параметры ipv4 изменить:
			# Добавить адрес
			# Адрес 192.16.82.1
			# Маска 255.255.255.0
			# Шлюз  0.0.0.0
			# Сервер DNS 8.8.8.8
			# Check "Требовать адресацию ipv4..."
			#
			#На клиентской машине вставить кабель, обжатый крест накрест
			#XP 
			#Сетевые подключения
			#Найти значек своего соединения
			# Свойства  - tcp/ip в списке  - вкладка общие открыdшегося  диалога
			#Win 7
			#В windows 7 этот диалог можно найти выбрав "Центр управления сетями и общим доступом" 
			#    - в левом меню "Изменить параметры адаптера" , далее выбрать в ваших подключениях по локальной сети то,
			#      которое вам нужно (я для этого просто вынимал кабель, чтобы посмотреть какой станет недоступным) 
			#      и далее в контекстном меню значка Свойства - tcp/ip и вы увидите окно как на рисунке слева 
			#Win 10
			#В системном трее значка сети можно открыть окно, в котором будет "Изменить параметры адаптера"
			#но по сути все также
			#
			#Итак, в этом окне
			#"Использовать следующий IP..."
			#IP 192.168.2.2
			#Маска 255.255.255.0
			#Основной шлюз 192.168.2.1
			#Сервер DNS 8.8.8.8
			#
			#Проверяем на обоих машинах ping 192.168.2.1 192.168.2.2
			#
			#На сервере правим  /etc/network/interfaces
			#В итоге мой файл выглядит вот так:
			#
			#auto lo
			#iface lo inet loopback
			#post-up iptables-restore </etc/iptables.conf
			#
			#Правим (создаем)  /etc/iptables.conf
			## Generated by iptables-save v1.4.21 on Sun Dec 13 14:23:10 2015
			#*nat
			#:PREROUTING ACCEPT [0:0]
			#:INPUT ACCEPT [0:0]
			#:OUTPUT ACCEPT [1:73]
			#:POSTROUTING ACCEPT [0:0]
			#-A POSTROUTING -s 192.168.0.0/24 ! -d 192.168.0.0/24 -j MASQUERADE
			#-A POSTROUTING -s 192.168.2.0/24 ! -d 192.168.2.0/24 -j MASQUERADE
			##COMMIT
			# Completed on Sun Dec 13 14:23:10 2015
			#
			#Выполняем
			#sudo -s
			#echo 'net.ipv4.ip_forward = 1' >>/etc/sysctl.conf; sysctl -p
			#iptables -t nat -A POSTROUTING -s 192.168.0.0/24 ! -d 192.168.0.0/24 -j MASQUERADE
			#iptables -t mangle -A FORWARD -p tcp -m tcp --tcp-flags RST,SYN SYN -j TCPMSS --clamp-mss-to-pmtu
			#iptables-save < /etc/iptables.conf
			#
			#Reboot
			#Должно работать как для xampp сервера размещенного на машине с ксубунту, так и для сайтов в интернете
			#
			#С доступом у интернет сайтам в win старше XP возможно придется повозится, дать в настройках доступ сети к Интернет, но четкого понимания как я это сделал нет
			#
		end
		
		def consoleConnect 
			nmcli con up( || down) id '$name' &
			#где $name это имя соединения в меню коннектора
		end
		
		def editConnections
			#если пункт меню nm апплета стал недоступен а править надо
			#console> nm-connection-editor 
		end
    end
    
    def SleepModeOff
		# Thsi from /etc/systemd 
		# This file is part of systemd.
		#
		#  systemd is free software; you can redistribute it and/or modify it
		#  under the terms of the GNU Lesser General Public License as published by
		#  the Free Software Foundation; either version 2.1 of the License, or
		#  (at your option) any later version.
		#
		# See logind.conf(5) for details

		[Login]
		#NAutoVTs=6
		#ReserveVT=6
		#KillUserProcesses=no
		#KillOnlyUsers=
		#KillExcludeUsers=root
		Controllers=blkio cpu cpuacct cpuset devices freezer hugetlb memory perf_event net_cls net_prio
		ResetControllers=
		#InhibitDelayMaxSec=5
		#HandlePowerKey=poweroff
		#HandleSuspendKey=suspend
		#HandleHibernateKey=hibernate
		#HandleLidSwitch=suspend
		#PowerKeyIgnoreInhibited=no
		#SuspendKeyIgnoreInhibited=no
		#HibernateKeyIgnoreInhibited=no
		#LidSwitchIgnoreInhibited=yes
		#IdleAction=ignore
		#IdleActionSec=30min


		HandlePowerKey=ignore
		HandleSuspendKey=ignore
		HandleHibernateKey=ignore
		HandleLidSwitch=ignore

	end
	class Date
		def setMsk
			sudo dpkg-reconfigure tzdata
			#date --set='2017-03-19 12:12:12.0000'
		end
	end
	class AVconv
		def extractAudio
			#avconv -i input.mp4 -vn -c:a libmp3lame -q:a 2 output.mp3
		end
	end
end
