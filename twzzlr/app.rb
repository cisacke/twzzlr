# Gems
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'dotenv'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'json'
require 'sinatra/backbone'
require 'sinatra/jstpages'

# Models
# require './models/user.rb'
# require './models/image.rb'

# Controllers
require './twzzlr/controllers/application_controller.rb'
register Sinatra::Sprockets

Dotenv.load

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['ACCESS_KEY'],
    :aws_secret_access_key  => ENV['SECRET_ACCESS_KEY'],
    :region                 => 'us-east-1'
  }
  config.fog_directory  = ENV['BUCKET_NAME']
  config.fog_public = true
end

class Twzzlr < Sinatra::Base
    # enable :sessions
    register Sinatra::Flash
    register Sinatra::JstPages
    serve_jst '/jst.js'
        
    get '/' do
        erb :'static_pages/root'
    end
    
    get '/users/new' do 
        erb :'users/new'
    end
    
    post '/time' do
        flash[:time] = "hello"
        redirect '/twzzlz'
    end
    
    post '/users/new' do
        @user = User.new(params[:user])
        if @user.save
            sign_in!(@user)
            redirect to('/twzzlz')
        else
            if @user.errors.messages[:password]
                flash.now[:password] = @user.errors.messages[:password]
            end
            if @user.errors.messages[:username]
                flash.now[:username] = @user.errors.messages[:username]
            end
            erb :'users/new'
        end
    end
    
    before '/session/new' do 
        @user = currently_signed_in
        if @user
            redirect to('/twzzlz')
        end
    end
    
    before '/users/new' do
        @user = currently_signed_in
        if @user
            redirect to('/twzzlz')
        end
    end
    
    get '/session/new' do
        erb :'sessions/new'
    end
    
    post '/session/new' do
        @user = User.find_by_credentials(params[:user][:username],
                                         params[:user][:password])
    
        if @user
            sign_in!(@user)
            redirect to('/twzzlz')
        else
            flash.now[:errors] = "Invalid username/password combination"
            erb :'sessions/new'
        end
    end
    
    delete '/session' do
        sign_out!
        redirect to('/twzzlz')
    end
    
    get '/' do
        erb :'static_pages/index'
    end
    
    get '/twzzlz' do
        content_type :json
        @twzzlz = Image.all.order(created_at: :desc)
        jbuilder :'twzzlz/index'
        # File.read('twzzlr/views/twzzlz/index.json.jbuilder')
        # session[:token] ||= SecureRandom::urlsafe_base64
        # puts session[:token].inspect
        # 
        # @user = currently_signed_in
        # erb :'twzzlz/index'
    end
    
    post '/' do
        twzzl = Image.new
        twzzl.image = params[:image]
        twzzl.user_id = currently_signed_in.id
        twzzl.save
        redirect to('/twzzlz')
    end
    
    delete '/twzzl/:id' do
        @twzzl = Image.find(params[:id])
        @twzzl.destroy
        redirect to('/twzzlz')
    end
    
    post '/twzzl/:id/unwrap' do
        puts params[:id]
        unwrap = Unwrap.where("image_id = :image_id", {image_id: params[:id], session: session[:token]})
        if unwrap.length != 0
            puts 'unwrap!'
            unwrap.destroy
        else
            puts 'no unwrap!'
            unwrap = Unwrap.new
            unwrap.image_id = params[:id]
            unwrap.session = session[:token]
            unwrap.save
        end
        redirect to('/')
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :password)
    end
    
end