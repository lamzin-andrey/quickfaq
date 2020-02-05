module RoRDoc
	class Routes
		#Здесь тупо примеры и много букв, так как проше не получается
		#Например, создали MyfrontpageController контроллер, который работает на главной странице (при запросе /, об этом ниже ), но не должен работать при его непосредственном запросе:
		%w(тогда, непосредственно в routes.rb добавляем)
		map.connect 'myfrontpage/*id', :controller=> :myfrontpage, :action => :err404
		%w(то есть мы написали, что все, что начинается с '/myfrontpage/' независимо от того, что идет позже обрабатывается нашим контроллером 
		в действии err404)
		#Интереснее, когда надо обрабатывать адреса вида '/слово/еще_слово'
		%w(причем заранее мы не знаем, что это будут за слова, но предполагаем
		Пусть первое слово представляет собой код страны, а второе обычно имеет вид all_hotels.php или allhotels.php или hotels.php.
		тогда можно использовать
		)
		map.connect ':word1/:word2.php', :controller=> :myfrontpage, :action => :request_processor, :requirements => {:word2 => /all_hotels|allhotels|hotels/, :word1=>/\w*{2-3}/}
	end
	class Validator
		validates_presence_of :title, :description, :image_url	#not empty
		validates_numericality_of :price												#number
		validates_uniqueness_of :title													#unique
		validates_format_of :image_url, :with => %r{\.(gif|jpg|jpeg|png)$}i,	#validate with regexp
												:message =>"URL must be GIF, JPG, GIF"						
		#custom method
		protected
		
		def validate
			errors.add(:price, "must be more than 0.01") if price.nil? || price < 0.01
		end
		#принадлежит одному из значений
		#пусть есть массив
		arrayVar = [
			['key1', 'value1'],
			['key2', 'valut2'],
			['key3', 'value3'],
		]
		#тогда, если :filed_name должно быть в равно value[1-3]
		validate_inclusion_of :field_name, :in => arrayVar.map {|one, two| two}
		#И по идее, (не проверено!), если arrayVar одномерный массив
		arrayVar - %w(value1, value2, value3)
		#должно работать так:
		validate_inclusion_of :field_name, :in => arrayVar.map {|one| one}
		# /(конец не проверено!)
		
		#специфичная приблуда для пароля (поле для повторного ввода)
		#и видимо необходимо
		attr_accessor :password_confirmation
		validates_confirmation_of :password #причем password - обычное поле модели
	end
	class MigrationExample
		#cd /path/to/dir/app
		## example migration created new column
		#ruby script/generate migration add_price
		## generic empty class with methods "up" and "down"
		##see Sql Methods for example execute Sql Queries from it.
		def SqlCreateTable
			create table :tableName do |t|
				t.column :columnName, :columnType
				t.column :entity_name, :string
				t.column :entity_desc, :text
				t.column :entity_price, :decimal, :precision => 8, :scale => 2, :default => 0
			end
		end
		def SqlAddColumn
			add_column :tableName, :entity_price, :decimal, :precision => 8, :scale => 2, :default => 0
		end
		def SqlDropColumn
			remove_column :tableName, :entity_price
		end
		def SqlDropTable
			drop_table :tableName 
			#rails 2.x
			remove_table :tableName 
		end
		def SqlSelect
			#select all
			ModelName.all
			#If table has field field1
			ModelName.find_all_by_field1
			ModelName.find_by_field1 #first record
		end
		def SqlInsert
			ModelName.create(:fieldName_1 => %{text}, :fieldName_2 => 500)
		end
		def SqlUpdate
			#one record
			ModelName.update(25, :name => 'Igor', :surname => 'Weiner')
			#many records
			data = {25 => {:name => 'Igor', :surname => 'Weiner'}, 29 => {:name => 'Sergo', :surname => 'Org-dze'} }
			ModelName.update(data.keys, data.values)
			#use condition
			#№ModelName.where('id = ?', 1).update_all(:surname => 'Пушкин') #!! jnefined where !!
			ModelName.update_all("surname = 'Пушкин'", 'id = 1')
		end
		def ConstraintExample
			#execute "SQL query"
			#каждый tourtypes может иметь много tours
			execute "ALTER TABLE tours ADD CONSTRAINT fk_tours_tourtypes FOREIGN KEY (tourtype_id) REFERENCES tourtypes(id)"
			#то есть если две таблицы относятся как одна ко многим, внешний ключ добавляем таблице, в которой "много" записей
			#Имя ключа задаем в виде (без скобок и пробелов)
			#fk_(имя таблицы, в которой "одна" запись)_(имя таблицы, в которой "много" записей)
			#после ВНЕШНИЙ КЛЮЧ в скобках имя поля таблицы в которой "много" записей, на которое вешаем ключ
			#после REFERENCES имя таблицы в которой "одна" запись и в скобках имя поля ее первичного ключа
		end
	end
	class ScaffoldExample
		#RoR 2.3.x
		## install scaffold guide https://github.com/activescaffold/active_scaffold/wiki/Getting-Started-Old
		#cd /path/to/dir/app
		
		## example generate scaffold for table products
		## "product" - will create "products" m/v/c
		%w(ruby script/generate scaffold product title:string description:text image_url:string price:double)
		##example for path admin/products (replace edit_product_path on edit_admin_product_path e.t.c)
		%w(ruby script/generate scaffold admin/product title:string description:text image_url:string price:double)
		#Не забудь отредактировать routes  (глаза разуй, увидишь)
		#Не забудь create update заменить params[:author] на params[:admin_author]
	end
	class LayoutFunctions
		def raw
			#off mode convert html <> to lt gt
		end
		def renderPartial
			#collection
			#Пусть в контроллере определена какая-то переменная - vfccbd @list
			#<%= TODO%>
			render :partial => "author", :collection => @list
			#:partial => "author" - обозначает что должен быть шаблон app/views/controller[layout?]name/_author.html.erb 
			#если файл существует, то в ем становится доступной переменная author полями как у элементов массива @list
		end
		def stylesheet_link_tag
			#in layout call stylesheet_link_tag 'style'
			# and will include file $project/public/stylesheets/style.css
		end
		def link_to(linkText, {:controller => controllerName, :action=>actionName, :id => ID})
			#also
			link_to image_tag(image_url, :class => 'my_custom'), :controller => controllerName, :action=>actionName, :id => ID
			#also POST
			link_to 'Delete', object, :confirm => 'A?', :method => :post
			#Пусть нет подходящего object, но вам надо, чтобы ссылка отправлялась POST'OM
			#Здесь можно при необходимости сделать такой вот хак:
			#В хелпере (реально это безобразие в контроллере) определяем 
			#class Tmp
			#	attr_accessor:id
			#	attr_accessor:action
			#	
			#	def path(action, id)
			#		@id = id
			#		@action = action
			#	end
			#end
			#Далее, в хелпере (на этот раз реально там)
			#def tmp_path(d)
			#	 p = 'store/' + d.action + '/' + d.id.to_s
			#	 return p
			#end
			#И, в шаблоне
			#<% @slf.path('add_to_cart', product.id) %><%=link_to(image_tag(product.image_url), @slf, :method => :post)%>
			#Таким орбразом, ссылка у нас будет отправлять данные POST  - ом
		end
	end
	class ViewFunction
	    #select tag
	    def selectHtml
	     f.select :xampp_version_id, Admin::XamppVersion.all.collect {|p| [ p.xampp_version, p.id ] }, { include_blank: true }
	    end
		#Определяет путь к папке изображений
		def asset_path(short_file_name)
		end
		# substring(str, 0, langth) + "..." 
		def truncate (str, length)
		end
		def cycle (val1, val2)
		# on css helpful... odd, even
		end
		def number_to_currency(value, :delimeter=> ',', :unit => '$', :separator => '.')
		end
		def tag_options(undefNowType)
			hash = {}
			hash['style'] = 'width:100%';
			str = tag_options(hash.stringify_keys)
			#str == 'style="width:100%"'
		end
	end
	class HttpHeader
		def NotFound404
			head :not_found #it all... -)
			#but we need message...
			render :status => 404, :layout =>"errorpage" #need /app/views/layouts/errorpage.html.erb (use scaffold AnyModule for generate example), and /app/views/ModuleName/ActionName.rhtml (in last file I wrote '404 not Found...' And you?)
		end
		def location
			redirect_to :action => :index, :controller => :any_your_controller
			redirect_to 'http://ulalala.la'
		end
	end
	class Session
		def storeSessionInDb
			#1. Create table in database for store session data. Execute migration
			#rake db:sessions:create
			#rake db:migrate
			#2. Configure
			#open file config/development[|production|test] and add str
			#config.action_controller.session_store = :active_record_store
			#
		end
		def SessionReadAndWrite
			#На самом примитивном уровне можно просто внутри контроллера
			#session[:keyName] = value
			#value = session[:keyName]
			#но сть способ круче
			#пусть есть класс - модель, в котором на этапе выполнения программы хранятся какие-то данные и я хочу сохранить его в сессии
			#тогда в контроллере определяем метод find_my_model
			#def find_my_model
			#	session[:key] ||= MyModel.new
			#end
			#И далее, что бы мы не делали с полученым этим методом объектом, эти данные будут тут же храниться в сессии и таблице!
		end
	end
	
	class Ajax
		#add to master template 
		#<%=javascript_include_tag :defaults %>
		#use code for view simple ajax form
		#<% form_remote_tag :url => {:action => :add_to_cart, :id => product} do %> #add_to_cart - realy exists method, product - defined variable in current visible area
		#<%= submit_tag 'Добавить в корзину' %>
		#<% end %>
		# and add add_to_cart.rjs template
	  page.replace_html ("ajax_cart", :partial => 'cart', :object => @cart) #ajax_cart - <div id="ajax_cart" 
	  #cart - html template _cart.html.erb. User variable cart into it for render details of object @cart
	  def ajaxScaffold
			####### 4.0.4
			#replace edit link
			#<%=form_tag({:action => :edit, :id=>list_item}, remote:true, method: :get) do%>
			#<%=submit_tag t(:edit), :class=>'ajax_sub' %>
			#<% end %>
	        ####### 2.3.14 ######
			#Record action (for example, edit)
			#replace str
			#<%= link_to 'Edit', edit_admin_author_path(author) %>
			#to
			#<% form_remote_tag :url=>{:action=>:edit, :id => author}, :method=>:get, :html=>{:method=>'get'} do%>
    	#<%=submit_tag 'Edit' %>
    	#<% end %>
    	
    	#Scaffold form
    	#replace <% form_for(@author) do |f| %>
    	# to <% form_remote_for(authorinfo) do |f| %>
	  end
	end
	class JsEffects
		#медленная подсветка элемента
		def animate_highlight
			page[:current_item].visual_effect :highlight, :startcolor => '#88ff88', :endcolor => '#114411'
			#<tag id="current_item"
		end
		def animate_appear
			page[:ajax_cart].visual_effect :blind_down if @cart.total_items == 1
			#<tag id="ajax_cart" ... условие @cart.total_items необязательно
		end
	end
	class Request
		def GET
			#в контроллере
			params[:varname]
		end
		def POST
			#пока see GET
		end
		def is_ajax
			request.xhr?
			#<?php if (!@$_POST["is_ajax"]) header('location: http://google.com'); die;
			redirect_to ('http://google.com') unless request.xhr?
		end
	end
	class FileUpload
	#<% form_for(@product, {:html => {:multipart=>true} } ) do |f| %>
	#<%= f.file_field :picture %>
	#tmp_file = params[:product][:image]
	#File.open(Rails.root.join('public/images', tmp_file.original_filename), 'wb') do |dest_file|
  #     dest_file.write(tmp_file.read)
  #end
	end
end
