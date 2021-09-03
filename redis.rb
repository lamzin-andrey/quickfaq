module Redis
	class Console
		def setValueFromFile
			# file with json data /home/andrey/redis_content_example.json. Was save saveRedisValueToFile
			# redis-cli -h 127.0.0.1  -x set key_2021-09-03_0000  < /home/andrey/redis_content_example.json
		end
		
		def saveRedisValueToFile
			#redis-cli -h 127.0.0.1  get key_2021-09-03_53 > /home/andrey/redis_content_example.json
		end
	end
end
