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

get "/contact" do
    erb :contact, layout: :layout
end



post "/contact" do
    puts "params are "+params.inspect
    @yname = params[:yname]
    @message = params[:message]
    # @email = params[:email]

 

    # from = SendGrid::Email.new(email: 'bryan.king@nycda.com')
    # to = SendGrid::Email.new(email: 'dmulvihill3@gmail.com')
    # subject = 'Thank you for purchasing from Bridges, Inc.'
    # content = SendGrid::Content.new(type: 'text/plain', value: "Our Sales representative will get back to you soon.")
    # mail = SendGrid::Mail.new(from, subject, to, content)

    # sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    # response = sg.client.mail._('send').post(request_body: mail.to_json)
    # puts response.status_code
    # puts response.body
    # puts response.parsed_body
    # puts response.headers

    erb :contact, layout: :layout
end

get "/deals" do
    erb :deals, layout: :layout
end

get "/about" do
    erb :about, layout: :layout
end