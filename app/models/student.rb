require_relative '../../db/config'

class Student < ActiveRecord::Base
    belongs_to :teacher
end