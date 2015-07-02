class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.references :user
      t.timestamps null: false
    end
  end
end
#TODO: slug for albums