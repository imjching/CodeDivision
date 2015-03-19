require_relative '../config'

class CreateStudents < ActiveRecord::Migration
    def change
        create_table :students do |t|
            t.string :first_name, :limit => 32
            t.string :last_name, :limit => 32
            t.integer :gender, :limit => 1
            t.string :birthday, :limit => 10
            t.string :email, :limit => 100
            t.string :phone, :limit => 32
            t.timestamps null: false
        end
    end
end