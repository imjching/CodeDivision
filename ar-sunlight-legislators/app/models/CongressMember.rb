require_relative '../../db/config'

class CongressMember < ActiveRecord::Base
    has_many :tweets
end