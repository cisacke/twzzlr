require 'rubygems'
require 'bundler'
require 'rack/protection'
require 'rack/csrf'
# use Rack::Protection
# use Rack::Csrf, :raise => true
Bundler.require

# Controllers
require './app'

# Models
# require './models/video'
use Rack::Session::Cookie
use Rack::Csrf
use Rack::MethodOverride
run Twzzlr