#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
#require 'rake'
#set :database, "sqlite3:pizzashop.db"
set :database, {adapter:"sqlite3", database:"pizzashop.sqlite"}

class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
  validates :name, presence: true, length:{ minimum: 3}
  validates :phone, presence: true, length:{ minimum: 3}
  validates :address, presence: true
end

get '/' do
  @products = Product.all
	erb :index			
end

get '/about' do
    erb :about
end

post '/place_order' do
  @order = Order.create params[:order]
  erb :order_placed
end

post '/cart' do

  # получаем список параметров и разбираем (parse) их

  @orders_input = params[:orders]
  @items = parse_orders_input @orders_input

  # выводим смс, что корзина пуста

  if @items.size == 0 
    return erb :cart_is_empty
  end  

  # выводим список продуктов в корзине

  @items.each do |item|
     # id, cnt
     item[0] = Product.find(item[0])  
  end

  # возвращаем представление по-умолчанию

  erb :cart
end

get '/contacts' do 
  erb :contacts
end



def parse_orders_input orders_input
  s1 = orders_input.split(/,/)

  arr = []

  s1.each do |x|
    s2 = x.split(/=/)

    s3 = s2[0].split(/_/)

    id = s3[1]
    cnt = s2[1]

    arr2 = [id, cnt]

    arr.push arr2 
  end
  
    return arr  
end
    