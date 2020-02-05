module VirtualBox
	class Xubuntu
		def offSyncTime
			VBoxManage setextradata "xtr2" VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled 1
		end
	end
end
