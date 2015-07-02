require 'faker'
require_relative '../app/models/teacher'

module TeachersSeeder
    def self.import
        9.times do
            Teacher.create!({
                :name => Faker::Name.name,
                :email => Faker::Internet.email,
                :phone_number => Faker::PhoneNumber.cell_phone
            })
        end
    end
end
