module Date
    class date
        def numberDayOfWeek
            date('N'); #1 - Monday, 7 - Sunday
            date('w'); #0 - Sunday, 6 - Saturday
        end
    end
end

module File
	def pathinfo
		['extension' => 'png', 'basename' => '0.png', 'filename' => '0', 'dirname' => '/home/user']
	end
end
