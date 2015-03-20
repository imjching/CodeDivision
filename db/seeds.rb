require 'faker'
require_relative '../app/config/application'

Task.transaction do
    10.times do
        Task.create(description: Faker::Lorem.sentence)
    end
end