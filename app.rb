#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
#require 'rake'
#set :database, "sqlite3:pizzashop.db"
set :database, {adapter:"sqlite3", database:"pizzashop.db"}

class Product < ActiveRecord::Base
end

get '/' do
	erb :index			
end

get '/about' do
    erb :about
end

get '/menu' do
  erb :menu
end
