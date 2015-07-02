require_relative '../config'

class AddTeacherForeignKeyStudents < ActiveRecord::Migration
    def change
        add_reference :students, :teacher, index: true
    end
end