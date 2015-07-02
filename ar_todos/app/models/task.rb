class Task < ActiveRecord::Base

    before_save :default_values

    def status_to_s
        self.status == 1 ? "[X]" : "[]"
    end

    def completed?
        self.status == 1
    end

    def complete
        self.status = 1
        self.save
    end

    private
    def default_values
        self.status ||= 0
    end
end