#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sinatra/activerecord'


set :database, "sqlite3:school.db"

class Users < Activerecord::Base
end

def get_db 
	@db = SQLite3::Database.new 'school.db'
	@db.results_as_hash = true
end

before do
	get_db
end

configure do
	get_db
	@db.execute 'create table if not exists 
		"user" 
		(	"id" integer primary key autoincrement, 
			"username" text, 
			"adres" text, 
			"email" text
		) '
end


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
	@db.execute 'insert into user (username, adres, email) values (?, ?, ?)', [@username, @adres, @email_name]

	erb "Спасибо за Ваш заказ, мы свяжемся с Вами в ближайшее время."
end

get '/contacts' do
	erb :contacts
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
		

	erb "Сообщение отправлено. Спасибо."
end

get '/showusers' do
	@row=''
	@res_db = @db.execute 'select * from user'
	erb :showusers
end


