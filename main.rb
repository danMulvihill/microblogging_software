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
    
    if current_user
        flash[:success] = 'Logged Out'
        session[:user_id] = nil
        redirect '/signin'
    else
        @user = User.where(username: params[:username]).first
        # puts @user
        if !@user
            flash[:error] = "Username not found"
            redirect '/signin'
        end

        if params[:username] != "" && params[:password] != "" && (@user.password == params[:password])
            session[:user_id] = @user.id
            flash[:notice] = "#{@user.fname} logged In"
            redirect '/blog'
        else
            flash[:error] = "Failed to log in"
            redirect '/signin'

        end
    end
end



get "/blog" do
    erb :blog
end



post "/blog" do
    puts "params are "+params.inspect
    @user = params[:user]
    @message = params[:message].strip!
    user = current_user
    if @message != "" 
        Post.create(content: params[:message], user_id: current_user.id)
        redirect '/blog'
    else
        flash[:error] = "You can't say nothing!"
        redirect '/blog'
    end
    
end

post "/delete" do
    if session[:user_id].to_i == params[:uid].to_i
        @post = Post.find(params[:pid].to_i)
        @post.delete
        flash[:success] = "Post Deleted"
        redirect '/blog'
    else
        flash[:error] = "You can't delete someone's post"
        redirect '/blog'
    end
end

post "/edit" do
    editid = params[:pid].to_i
    @post = Post.find(editid)
    flash[:notice] = "Edit Mode"
    redirect '/editform?content='+@post.content+"&editid="+editid.to_s
end

get "/editform" do
    puts "params: "+params.inspect
    flash[:success] = "Post edited"
    erb :editform 
end

post "/editform" do
    puts "params for post: "+params.inspect
    @postfind = Post.find(params[:eid].to_i)
    @postfind.update(content: params[:message])
    redirect '/blog'
end