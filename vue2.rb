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
