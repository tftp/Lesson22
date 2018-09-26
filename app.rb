#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/zakaz' do
	erb :zakaz
end

get '/chating' do
	erb :chating
end

get '/contacts' do
	erb :contacts
end

post '/zakaz' do
	to_file :name=>params["username"], :adres=>params["adres"], :email_name=>params["email_name"]
	erb "Спасибо за Ваш заказ, мы свяжемся с Вами в ближайшее время."
end

def to_file hh
	f = File.open("./public/users.txt", "a") 
	f.write(hh[:name]+"  ") if hh[:name]
	f.write(hh[:adres]+"  ") if hh[:adres]
	f.write(hh[:email_name]+" \n ") if hh[:email_name]
	f.close
end
