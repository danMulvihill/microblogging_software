require "sinatra"
# require "sendgrid-ruby"
require 'sinatra/activerecord'
require './models/user.rb'
require 'bundler/setup' 
require 'sinatra/flash' # loads sinatra flash


configure( :dvelopment){set :database, "sqlite3:test_database.sqlite3"}

get "/" do 
    erb :home, layout: :layout
   
end

get "/register" do
    erb :register
end

get "/signin" do
    erb :signin
 end   
    
post "/signin" do
    puts "params are "+params.inspect
    
    @user = User.where(username: params[:username]).first
    puts @user

    if @user.password == params[:password]
        redirect '/'
    else
        "<h2 class=\"error\">Log-in failed</h2>"
        # redirect '/login-failed'
    end
end

get "/blog" do
    erb :blog, layout: :layout
end



post "/blog" do
    puts "params are "+params.inspect
    @yname = params[:yname]
    @message = params[:message]
    # @email = params[:email]

    erb :blog, layout: :layout
end


