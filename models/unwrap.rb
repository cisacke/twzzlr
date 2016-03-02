require './models/image.rb'
require './models/user.rb'

class Unwrap < ActiveRecord::Base
    belongs_to :image
    belongs_to :user
end