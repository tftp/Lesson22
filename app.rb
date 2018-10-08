#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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
	
	hh.each do |key,value|
		if params[key] == ''
			@error = hh[key]
			return erb :zakaz
		end
	end
	
	to_file :file_name=>"./public/users.txt", :name=>params["username"], :adres=>params["adres"], :email_name=>params["email_name"]
	erb "Спасибо за Ваш заказ, мы свяжемся с Вами в ближайшее время."
end

post '/contacts' do
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
