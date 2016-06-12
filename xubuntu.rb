module Xubuntu
    class AudioRecorder
        def howInstall
            #sudo apt-add-repository ppa:osmoma/audio-recorder
            #sudo apt-get update
            #sudo apt-get install audio-recorder
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
    end
    
    class FlashPlayer
		def inslall
			sudo dpkg --add-architecture i386
			sudo apt-get update
			sudo apt-get install xvfb libcurl3:i386 libglib2.0-0:i386 libx11-6:i386 libxext6:i386 libxt6:i386 libxcursor1:i386 libnss3:i386 libgtk2.0-0:i386
			download from adobe flashplayer
		end
    end
end
