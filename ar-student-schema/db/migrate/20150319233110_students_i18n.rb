require_relative '../config'

class StudentsI18n < ActiveRecord::Migration
    def change
        add_column :students, :name, :string, limit: 64
        add_column :students, :address, :string

        reversible do |dir|
            dir.up do
                Student.all.each do |student|
                    student.name = "#{student.first_name} #{student.last_name}"
                    student.save
                end
            end
            dir.down do
                Student.all.each do |student|
                    name = student.name.split(" ")
                    student.first_name = name[0]
                    student.last_name = name[1]
                    student.save
                end
            end
        end

        remove_column :students, :first_name, :string, limit: 32
        remove_column :students, :last_name, :string, limit: 32
    end
end