#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'

get '/' do
	erb :welcome		
end

get '/zakaz' do
	erb :zakaz
end

get '/chating' do
	@error='Страница в процессе разработки.'
	erb :chating
end

get '/contacts' do
	erb :contacts
end

post '/zakaz' do
	@username = params["username"]
	@adres = params["adres"]
	@email_name = params["email_name"]
	
	hh={:username => 'Введите имя', 
		:adres => 'Введите адрес', 
		:email_name => 'Введите email'}
	
	@error = hh.select {|k,v| params[k] == ""}.values.join(", ")
	if @error != ''
		return erb :zakaz
	end
	

	to_file :file_name=>"./public/users.txt", :name=>params["username"], :adres=>params["adres"], :email_name=>params["email_name"]
	erb "Спасибо за Ваш заказ, мы свяжемся с Вами в ближайшее время."
end

post '/contacts' do
	@email_name = params[:email_name]
	@message = params[:message]
	
	hh={:message => 'Введите текст', 
		:email_name => 'Введите email'}

	@error = hh.select {|k,v| params[k] == ""}.values.join(", ")
	if @error != ''
		return erb :contacts
	end
		
#	Pony.mail({
#	  :from => params[:email_name],
#	  :body => params[:message],
#	  :to => 'lyceum-istra@inbox.ru',
#	  :subject => " Has contacted you",
#	  :via => :smtp,
#	  :via_options => { 
#		:address              => 'smtp.mail.ru', 
#		:port                 => '465', 
#		:user_name            => 'lyceum-istra@inbox.ru', 
#		:password             => 'c59D36', 
#		:domain               => 'localhost.localdomain'
#		}
#	})
		

		to_file :file_name=>"./public/messages.txt", :message=>params["message"], :email_name=>params["email_name"]
	erb "Сообщение отправлено. Спасибо."
end

def to_file hh
	f = File.open(hh[:file_name], "a") 
	f.write(hh[:name]+"  ") if hh[:name]
	f.write(hh[:email_name]+" \n ") if hh[:email_name]
	f.write(hh[:adres]+"\n\n") if hh[:adres]
	f.write(hh[:message].strip+"\n\n") if hh[:message]
	f.close
end
