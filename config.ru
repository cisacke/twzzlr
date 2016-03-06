require 'rubygems'
require 'bundler'
require 'rack/protection'
require 'rack/csrf'
# use Rack::Protection
# use Rack::Csrf, :raise => true
Bundler.require

# Controllers
require './twzzlr/app'

# Models
require './twzzlr/models/image.rb'
require './twzzlr/models/unwrap.rb'
require './twzzlr/models/user.rb'
# require './models/video' ** this is probably where you should require models etc **

use Rack::Session::Cookie
use Rack::Csrf
use Rack::MethodOverride
run Twzzlr