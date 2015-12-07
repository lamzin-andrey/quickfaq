#пример ключевых слов
module jasmine
  def example
    #describe('Simple test for simple app', function() {
		#it('should create uObject.n equal 3', function() {
		# //code, creating uObject.n == 3 or != 3
		#  expect(window.uObject.n).toBe(3);
		#});
	#});
  end
  class keywords
    def describe
	  # //callback is function(){ it('phrase', callback2) }
      #describe(phrase, callback)
    end
    def it
	  # //callback is function(){ expect(realyValue).toBe(expectedValue) }
      #it(phrase, callback)
    end
    def expect(realyValue)
      #expect(phrase, callback)
    end
    def toBe(expectedValue)
      #it(phrase, callback)
    end
  end
end
