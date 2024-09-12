module Examples
	class Component
		def Object
			### start example
			#Power:
			  #type: object
			  #description: Описание объекта
			  #properties:
				#id:# Имя свойства
				  #type: integer
				  #description: id сущности
				#name:# Имя свойства
				  #type: integer
				  #example: 180
				  #description: Описание свойства
			### end example
		
			### adsress in tree (include first '#')
			#/components/schemas/Power
			
			### example
			Path.GetWithArray
			### end example
		
		end
	end
	
	class Path
		def GetWithArray
		  ### start example
		  #/catalog/product/{productId}:
			#get:
			  #summary: Метод возвращает список продуктов
			  #parameters:
				#- name: productId
				  #in: path
				  #required: true
				  #schema:
					#type: integer
			  #responses:
				#'200':
				  #description: массив продуктов с мощностями и их id
				  #content:
					#application/json:
					  #schema:
						#type: object
						#properties:
						  #items:
							#type: array
							#items:
							  #allOf:
								#- $ref: '#/components/schemas/Power'
				#'404':
				  #$ref: '#/components/responses/NotFoundErrorResponse'
			  #tags:
				#- Catalog
		  ### end example
		end
		end
		
		def getWithArgumentInPath
			Path.GetWithArray
		end
	end
	
end
