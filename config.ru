require 'rubygems'
require 'bundler'
Bundler.require

# Controllers
require './app'

# Models
# require './models/video'

use Rack::MethodOverride
run Twzzlr