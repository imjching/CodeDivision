require_relative '../../db/config'

class Student < ActiveRecord::Base
    has_many :students_teachers
    has_many :teachers, through: :students_teachers

    validates :email, uniqueness: true,
                      format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ }
    validates :age, numericality: { greater_than_or_equal_to: 5 }
    validate :valid_phone?

    def valid_phone?
        if self.phone.scan(/\d+/).join.length < 10
            errors.add(:phone, "must contain at least 10 digits, excluding non-numeric characters")
        end
    end

    def age
        now = Date.today
        age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
    end
end