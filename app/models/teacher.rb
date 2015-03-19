require_relative '../../db/config'

class Teacher < ActiveRecord::Base
    validates_uniqueness_of :name
    validates_uniqueness_of :email
end