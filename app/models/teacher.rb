require_relative '../../db/config'

class Teacher < ActiveRecord::Base
    validates_uniqueness_of :name
    validates_uniqueness_of :email
    has_many :students_teachers
    has_many :students, through: :students_teachers
end