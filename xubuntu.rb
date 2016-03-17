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
end
