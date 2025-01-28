module Examples
    class Component
        def Object
            ### start example
            #Power:
              #type: object
              #description: Описание объекта
              #properties:
                #id:# Имя свойства (здесь пусто после двоеточия)
                  #type: integer
                  #description: id сущности
                #name:# Имя свойства (здесь пусто после двоеточия)
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
        
        def responseWithFile
            responses:
                '200':
                  description: Pdf файл
                  content:
                    application/pdf:
                      schema:
                        type: string
                        format: binary
                #multihead
                '200':
                  description: "Pdf или png файл или zip архив с целевым файлом и другими документами (чек, приложения, заявления, подпись, протокол, отпечатки пальцев. Конкретный состав может зависить от чего угодно, например от статьи). В случае типа png вернёт изображение полиса ОСАГО. Content-Type соответственно может меняться на application/zip или application/png"
                  content:
                    application/pdf:
                      schema:
                        type: string
                        format: binary
                    application/zip:
                      schema:
                        type: string
                        format: binary
                    application/png:
                      schema:
                        type: string
                        format: binary
        end
        
        def response302
            '302':
              description: Редирект на successUrl или failUrl
              content:
                text/html:
                  schema:
                    type: string
                    format: text
        end
    end
end

module Refs
    class parameterByRef
        def linkParameterByRef
            #/catalog/product/{productId}:
            #get:
              #summary: Метод возвращает список продуктов
              #parameters:
                #- $ref: '#/components/parameters/ProductId'
        end
        
        def PathParameterAsComponent
            ### See linkParameterByRef
            #components:
              #parameters:
                ParameterName:
                  name: parameterName
                    in: path
                    required: true
                    schema:
                      type: integer
                      description: Описание
                      example: 1234
        end
    end
end
