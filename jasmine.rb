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
    def beforeEach(callback)
      #в решении может быть несколько it и может понадобиться, 
      #чтобы перед вызовом каждого из них какие-то переменные имели какие-то
      #значения.
      #эту инициализацию можно вынести в callback beforeEach
      #callback afterEach можно использовать для сброса значений
      
      describe('Разбираемся с before / after Each',
		function () {
		  var x = 0;
		  beforeEach(function(){
		    x++;
		  });
		  
		  afterEach(function(){
		    x = 0;
		  });
		  it ('ждем что икс равен 1', function(){
		    expect(x).toBe(1);
		  });
		  
		  it ('снова ждем что икс равен 1', function(){
		    expect(x).toBe(1);
		  });
		}
      );
    end
    def afterEach
	  @see beforeEach
    end
  end
end
