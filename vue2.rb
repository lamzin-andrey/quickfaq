class Axios
	def postJSON
		#see post
	end
	
	def post
		Axios.post('/axios/test', [1,2,'troix']).then( (response) =>{
			console.log(response);
		} );
	end
	
	def postFormData
	end
end

class ConfigApp
	def setSquareBracketsInstead
		window.app = new Vue({
			delimiters : ['[[', ']]']
		});
	end
	
	def setTokens
		#see
		setSquareBracketsInstead
	end
	
end


module Errors
	class Chokodair
	 #echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
	end
	
	class ENOSPC
		#@see
		Chockodair
	end
end
