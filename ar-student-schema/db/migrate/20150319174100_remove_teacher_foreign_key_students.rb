require_relative '../config'

class RemoveTeacherForeignKeyStudents < ActiveRecord::Migration
    def change
        remove_reference :students, :teacher
    end
end