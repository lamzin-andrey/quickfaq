#nil is "object"
#nil == nil #true
#reciever - object, his method was called
#obj.method!  - "bang" or "mutator" method
module People
	class TheMan					#example child class see MyException
		attr_accessor:name	#getter / setter (attr_writer|attr_reader)
		#default public methods
		def initialize(name)
			@name = name			#@name - private var
		end
		#private						#make all next definions is private, while not meet protected or public declare
		def say(str)
			puts "#{str}, #{@name}"
		end
		def self.static(s)	#make static method
			puts 'Ya static, and I say ' + s
		end
		def arrayDemo
			string_list = %w(0 1 2 )    #array of string
			string_list[1] += '2'			   # += 2 throw error
			arr.each {|item|puts item}	 #example out array, ruby style!
			arr.delete_at(index)
			#if arr array of objects
			arr.delete_if {|i| i.anyKey == 555}
			arr.find {|i|i.anyKey == 555}
			#push
			arr.push 999
		end
		def assocArrayDemo
			hash = {:bi =>'струнный инструмент', :skr => 'не барабань', :abc => 'trololo'}
			hash.each {|i,v|puts "#{i} => #{v}" }
			#sort by key (return array)
			
			hash = {5 => 1, 3 => 2}
			arr = hash.sort_by {|k,val|k}
			arr.each{|ky,v|puts "#{ky} => #{v}"}
			
			#sort by value (return array)
			hash = {5 => 2, 8 => 1}
			arr = hash.sort_by {|key,ve|ve} 
			arr.each{|key,val|puts "#{key} => #{val}"}
			
			##also
			#min[_by]
			#max[_by]
			#keys
			#values
			#sort
		end
		def constructor
			#see initialize #Init and Alize (goes to swim in the sea.)
		end
		def filesDemo
			ls = Dir.glob("*")
			ls.each {|f| puts f}
		end
		def typecastDemo
			n = 10
			s = n.to_s
			n = s.to_i
		end
		def regExpDemo
			re = %r(\d)			#first var define
			if re =~ 'dsd'  #JS.RegExp.test
				puts 'aga'
			else
				puts 'nea'
			end
			re = /\D/				#second var define
			if re =~ 'dsd'  #JS.RegExp.test
				puts 'aga'
			else
				puts 'nea'
			end
											#JS.String.match(re)
			s = 'mishka siela koshky, podojjdala nemnojjko i snova siela kochky. Vot str'
			re = /siela ko[\w]+ky/
			arr = s.scan(re)	#arr.length == 2
			puts arr[0]				
			puts arr[1]
												#JS.String.replace(re)
			s = s.gsub(re, 'AGA'); #gsub - as JS /*/g,
			puts s
			##also 
			#sub
		end
		def hashDemo
			#see assocArrayDemo
		end
		def exceptionDemo		#work with Exception
			begin             #try
				throwMethod			#... or dsasdsdarr.splidsadsad
				rescue Exception => exc  #catch
					puts "Error: #{exc.message}"
			end
		end
		def throwMethod
			#raise "My custom Exception"	#simple
			raise MyException.new					#special class of exception
			#arr.sub
		end
		def timeDemo
			puts Time.now
		end
		def bangDemo
			a = [5,2,6]
			b = a.sort
			puts '=====NoBang - arr a ======';
			a.each {|i| puts i}
			puts '============';
			b.each {|i| puts i}
			
			a = [5,2,6]
			b = a.sort!
			puts '=====Bang - arr a ======';
			a.each {|i| puts i}
			puts '============';
			b.each {|i| puts i}
		end
		def mutatorDemo
			#see bangDemo
		end
		def stringDemo
			#strtolower
			downcase
			upcase
			#str_replace
			sub
		end
	end
	
	class MyException < Exception
		attr_reader:message						#attr_reader - optima
		def initialize
			@message = 'This is message from subclass Exception'
		end
	end
	
	
	#bill = TheMan.new('William')
	#bill.say('Hello')
	#jo.name = 'Willi'
	#jo.say('Hello')

	#puts jo.name
end
jo = People::TheMan.new('George') #- access to public class of module
jo.regExpDemo
#jo.stat('')
