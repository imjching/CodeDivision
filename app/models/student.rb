require_relative '../../db/config'

class Student < ActiveRecord::Base
    has_many :students_teachers
    has_many :teachers, through: :students_teachers
end