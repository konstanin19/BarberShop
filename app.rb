require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
    db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS
	"Users"
	(
	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
	"username" TEXT,
	"Phone" TEXT,
	"datestamp" TEXT,
	"barber" TEXT,
	"color" TEXT
	)'
end	


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone     = params[:phone]
	@datetime = params[:datetime]
	@baber = params[:baber]
	@color = params[:color]

#	if @username ==''
#		@error = 'Введите имя'
#	end

#	if @phone ==''
#		@error = 'Введите номер телефона'
#	end
#	if @datetime ==''
#		@error = 'Введите дату и время визита'
#	end
#	if @error !=''
#		return erb :visit
#	end
hh = { :username => 'Введите имя',
       :phone => 'Введите номер телефона',
       :datetime => 'Введите дату и время визита' }
       @error = hh.select {|key,_| params[key] == ""}.values.join(",")
       #для каждой пары ключ-значение
    #   hh.each do |key, value|
       	#если параметр пуст
     #  	if  params[key] == ''
       		#переменной error присвоить значение value из хеша hh
       		#(а value из хеша hh это сообщение об ошибке)
       		#т.е. переменной error присвоить сообщение об ошибке
       		if @error != ''
       		    return erb :visit
       		end

       		db = get_db
            db.execute 'insert into
            Users
       		(
       		username,
       		phone,
       		datestamp,
       		barber,
       		color
       		)
       		values(?,?,?,?,?)',[@username,@phone,@datetime,@baber,@color]




		
	

	@title = 'Thank you!'
	@message = "Дорогой #{@username}, вы записались #{@datetime} к парикмахеру #{@baber},цвет краски: #{@color}"

	f = File.open 'users.txt', 'a'
	f.write "User: #{@username}, Phone: #{@phone}, Date and time: #{@datetime} ,Baber:#{@baber}, Color:#{@color}"
	f.close

	erb :message
end

def get_db
	return SQLite3::Database.new 'barbershop.db'
end	



get '/contacts' do
	erb :contacts
end