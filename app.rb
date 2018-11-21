#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:school.db"

class Users < ActiveRecord::Base
end

class Messages < ActiveRecord::Base
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
	c=Users.new params[:zakaz]
	c.save
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
	
	Messages.create :email=>@email_name, :message=>@message	
	
	erb "Сообщение отправлено. Спасибо."
end

get '/showusers' do
	@res_db = Users.all
	erb :showusers
end

get '/showmess' do
	@res_db = Messages.all
	erb :showmess
end


