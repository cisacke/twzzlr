class CreateTwzzlzTable < ActiveRecord::Migration
  def change
      create_table :images do |t|
         t.string :image
         
         t.timestamps 
      end
  end
end
