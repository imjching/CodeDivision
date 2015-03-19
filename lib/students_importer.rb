require_relative '../app/models/student'
require_relative '../app/models/teacher'
require_relative '../app/models/students_teacher'

module StudentsImporter
    def self.import(filename=File.dirname(__FILE__) + "/../db/data/students.csv")
        field_names = nil
        Student.transaction do
            File.open(filename).each do |line|
                line.gsub!(",male,", ",1,")
                line.gsub!(",female,", ",0,")
                data = line.chomp.split(',')
                if field_names.nil?
                    field_names = data
                else
                    attribute_hash = Hash[field_names.zip(data)]
                    student = Student.create!(attribute_hash)
                end
            end
        end
    end

    def self.link_teachers
        Student.all.each do |student|
            number_of_teachers = rand(10)
            number_of_teachers.times do
                begin
                    student.teachers << Teacher.find(rand(Teacher.count) + 1)
                    student.save
                rescue
                    # do nothing
                end
            end
        end
    end
end
