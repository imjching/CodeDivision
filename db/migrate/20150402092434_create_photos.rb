class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_path
      t.string :caption
      t.references :album
      t.timestamps null: false
    end
  end
end
#TODO: unique id SecureRandom.uuid for unique id instead of photo_id