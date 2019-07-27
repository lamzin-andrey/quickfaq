module VirtualBox
	class Xubuntu
		def offSyncTime
			VBoxManage setextradata "safari" VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled 1
		end
	end
end
