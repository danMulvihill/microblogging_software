require "sinatra"
require 'sinatra/activerecord'
require 'bundler/setup' 
require 'sinatra/flash' 
require './models/user.rb'
require './models/post.rb'
require './models/blogger.rb'

 enable :sessions

def current_user
    if session[:user_id]
        User.find(session[:user_id])
    end
end

def sign_out
    session[:user_id] = nil
end

configure( :development){set :database, "sqlite3:test_database.sqlite3"}

# set :database, "sqlite3:test_database.sqlite3"

get "/" do 
    erb :home
end

get "/register" do
    erb :register
end

post "/create" do
    puts "PARAMS are "+params.inspect
    
    if params[:fname]!="" && params[:lname] !="" && params[:email] !="" && params[:password] !=""
        puts "params are "+params.inspect
        User.create(fname: params[:fname], lname: params[:lname], username: params[:email], password: params[:password])
        redirect '/signin'
    else 
        flash[:error] = "All fields are required"
        redirect '/register'
    end
end

get "/signin" do
    erb :signin
 end   
    
post "/signin" do
    
    @user = User.where(username: params[:username]).first
    puts @user

    if current_user
        flash[:notice] = 'Logged Out'
        session[:user_id] = nil
        redirect '/signin'
    else

        if params[:username] != "" && params[:password] != "" && (@user.password == params[:password])
            session[:user_id] = @user.id
            flash[:success] = "#{@user.fname} logged In"
            redirect '/blog'
        else
            # "<h2 class=\"error\">Log-in failed</h2>"
            flash[:error] = "Failed to log in"
            redirect '/signin'

        end
    end
end



get "/blog" do
    erb :blog
end



post "/blog" do
    erb :blog
    puts "params are "+params.inspect
    # puts "USER ID =========="+user.id
    @user = params[:user]
    @message = params[:message]
    @email = params[:email]
    user = current_user
    if @message != ""
        Post.create(content: params[:message], user_id: user.id)
        redirect '/blog'
    else
        flash[:notice] = "You can't say nothing!"
        redirect '/blog'
    end
    
end

post "/delete" do
    puts session[:user_id]
    puts params[:uid]
    puts "params="+params.inspect
    puts params[:pid].to_i
    if session[:user_id].to_i == params[:uid].to_i
        @postfind = Post.find(params[:pid].to_i)
        puts @postfind
        @postfind.delete
        flash[:notice] = "Record Deleted"
        redirect '/blog'
    else
        flash[:error] = "You can't delete someone's post"
        redirect '/blog'

    end



end


