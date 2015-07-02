require_relative '../config'

class CreateStudentsTeachers < ActiveRecord::Migration
    def change
        create_table :students_teachers, index: false do |t|
            t.belongs_to :student, index: true
            t.belongs_to :teacher, index: true
        end
    end
end