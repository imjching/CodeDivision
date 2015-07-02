require_relative '../views/TasksView'

class TasksController

    def self.list_tasks
        TasksView.list_all_tasks(Task.all)
    end

    def self.add_task(args)
        TasksView.flash("Please enter a task description.", args[1].nil?)
        desc = args[1..args.length].join(" ")
        Task.create(description: desc)
        TasksView.flash("Appended \"#{desc}\" to your TODO list...")
    end

    def self.complete_task(task_id)
        TasksView.flash("Invalid task_id.", task_id.to_i < 1)
        task = Task.all[task_id.to_i - 1]
        TasksView.flash("Task not found.", task.nil?)
        TasksView.flash("Error: Task already completed...", task.completed?)
        task.complete
        TasksView.flash("Completed \"#{task.description}\" in your TODO list...")
    end

    def self.delete_task(task_id)
        TasksView.flash("Invalid task_id.", task_id.to_i < 1)
        task = Task.all[task_id.to_i - 1]
        TasksView.flash("Task not found.", task.nil?)
        deleted = task.destroy
        TasksView.flash("Deleted \"#{deleted.description}\" from your TODO list...")
    end
end