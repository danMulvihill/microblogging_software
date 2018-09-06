require "sinatra"
require 'sinatra/activerecord'
require 'bundler/setup' 
require 'sinatra/flash' 
require './models/user.rb'
require './models/post.rb'
require './models/blogger.rb'

# enable :sessions

configure( :development){set :database, "sqlite3:test_database.sqlite3"}

# set :database, "sqlite3:test_database.sqlite3"

get "/" do 
    
    erb :home, layout: :layout
   
end

get "/register" do
    erb :register
end

post "/create" do
    puts "params are "+params.inspect
    User.create(username: params[:email], password: params[:password])
    redirect '/signin'
end

get "/signin" do
    erb :signin
 end   
    
post "/signin" do
    puts "params are "+params.inspect
    
    @user = User.where(username: params[:username]).first
    puts @user

    if @user.password == params[:password]
        flash[:success] = "Logged In"
        redirect '/blog'
    else
        "<h2 class=\"error\">Log-in failed</h2>"
        # flash[:error] = "Failed to log in"
        # redirect '/login-failed'

    end
end

get "/blog" do
    erb :blog, layout: :layout
end



post "/blog" do
    puts "params are "+params.inspect
    # puts "USER ID =========="+user.id
    @user = params[:user]
    @message = params[:message]
     @email = params[:email]
    Post.create(content: params[:message])
    erb :blog, layout: :layout
end


