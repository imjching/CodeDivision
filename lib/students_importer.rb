require_relative '../app/models/student'
require_relative '../app/models/teacher'

module StudentsImporter
    def self.import(filename=File.dirname(__FILE__) + "/../db/data/students.csv")
        field_names = nil
        Student.transaction do
            File.open(filename).each do |line|
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

    def self.link_teacher
        Student.all.each do |student|
            student.teacher = Teacher.find(rand(Teacher.count) + 1)
            student.save
        end
    end
end
