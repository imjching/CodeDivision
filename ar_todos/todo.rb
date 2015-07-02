require_relative 'config/application'
require_relative 'app/controllers/TasksController'

class Todo
    def self.run(args)
        command = args[0]
        case command
        when "add" then TasksController.add_task(args)
        when "list" then TasksController.list_tasks
        when "delete" then TasksController.delete_task(args[1] || -1)
        when "complete" then TasksController.complete_task(args[1] || -1)
        else
            puts "Command not found!"
            puts "Options:"
            puts "--add <task_description>"
            puts "--list"
            puts "--delete <task_id>"
            puts "--complete <task_id>"
        end
    end
end

Todo.run(ARGV)