class CreateUnwrapTable < ActiveRecord::Migration
  def change
      create_table :unwraps do |t|
         t.string :session
         t.integer :image_id
         
         t.timestamps 
      end
  end
end
