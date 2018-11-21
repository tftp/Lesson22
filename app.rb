#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:school.db"

class Users < ActiveRecord::Base
	validates :username, presence: true, length: {minimum: 3}
	validates :adres, presence: true
	validates :email, presence: true
end

class Messages < ActiveRecord::Base
	validates :email, presence: true
	validates :message, presence: true
end


get '/' do
	erb :welcome		
end

get '/zakaz' do
	@c=Users.new
	erb :zakaz
end

get '/chating' do
	@error='Страница в процессе разработки.'
	erb :chating
end


post '/zakaz' do
	@c=Users.new params[:zakaz]
	if @c.save
		erb "Спасибо за Ваш заказ, мы свяжемся с Вами в ближайшее время."
	else
		@error=@c.errors.full_messages.first
		erb :zakaz
	end
end

get '/contacts' do
	@c=Messages.new
	erb :contacts
end

post '/contacts' do
	@c=Messages.new params[:mess]
	if @c.save
		erb "Сообщение отправлено. Спасибо."
	else
		@error=@c.errors.full_messages.first
		erb :contacts
	end
end

get '/showusers' do
	@res_db = Users.all
	erb :showusers
end

get '/showmess' do
	@res_db = Messages.all
	erb :showmess
end


