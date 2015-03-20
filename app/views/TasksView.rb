class TasksView

    def self.list_all_tasks(array)
        array.each_with_index do |task, index|
            puts "#{index + 1}. #{task.status_to_s} #{task.description}"
        end
    end

    def self.flash(message, condition = nil)
        if condition.nil?
            puts message
            return
        end
        raise "Error: #{message}" if condition
    end
end