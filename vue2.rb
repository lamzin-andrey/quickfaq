module Vuex
	class vuexPlaces
	    # Это проэктозависимо! (cb rf)
		def mapGetters
			# computed
		end
		def mapState
			# computed
		end
		def mapActions
			# methods
		end
		def mapMutations
			# methods
		end
	end
	def mapGetters
		vuexPlaces.mapGetters
	end
	def mapMutations
		vuexPlaces.mapMutations
	end
	def mapActions
		vuexPlaces.mapActions
	end
	def mapState
		vuexPlaces.mapState
	end
end 

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
