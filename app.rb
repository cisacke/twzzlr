# Gems
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'dotenv'
require 'sinatra'
require 'sinatra/base'

# Models
require './models/user.rb'
require './models/image.rb'

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
    get '/' do 
        erb :'sessions/new'
    end
    
    post '/user' do
        @user = User.new
        @user.password = params[:user][:password]
        @user.username = params[:user][:username]
        puts @user.username
        puts @user.password
        if @user.save
            sign_in!(@user)
            redirect to('/twzzlz')
        else
            puts 'uh oh'
        end

    end
    
    get '/twzzlz' do
        session[:token] ||= SecureRandom::urlsafe_base64
        puts session[:token].inspect

        @twzzlz = Image.all
        erb :'twzzlz/index'
    end
    
    post '/' do
        twzzl = Image.new
        puts params[:image]
        twzzl.image = params[:image]
        twzzl.save
        redirect to('/')
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