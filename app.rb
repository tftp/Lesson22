#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:school.db"

class Users < ActiveRecord::Base
	validates :username, presence: true
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
	c=Messages.new params[:mess]
	c.save
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


