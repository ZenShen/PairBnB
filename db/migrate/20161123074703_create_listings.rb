class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
    	t.string :country
    	t.string :city_town
    	t.string :home_type
    	t.integer :guest
    	t.text :description
    	t.string :price
    	t.integer :user_id
    	t.string :property_name

    	t.timestamps null: false
    end
  end
end
