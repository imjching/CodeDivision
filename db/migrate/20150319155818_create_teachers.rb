require_relative '../config'

class CreateTeachers < ActiveRecord::Migration
    def change
        create_table :teachers do |t|
            t.string :name, limit: 32
            t.string :email, limit: 100
            t.string :phone_number, limit: 32
            t.timestamps null: false
        end
    end
end