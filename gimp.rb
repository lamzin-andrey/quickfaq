module Gimp
	class Windows
		def howShowInstruments
			'Ctrl+B' # old versions
			
			KEYBRD.Tab
		end
		def howShowCutSizeInputFields
			'Double click on knife in instruments' # old version
		end
	end
	
	class Colors
		def howChangeColorOnPhoto
			Colors.Map.RotateColors
			# and rotate all arrows on coored rounds. It work.
		end
	end
end 
