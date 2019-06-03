class Api::V1::TasksController < Api::V1::BaseController
  def create
    task = Task.new task_params

    if task.save
      render json: {
                    success: true,
                    task: {
                      id: task.id,
                      description: task.description,
                      completed: task.completed,
                      completed_at: task.completed_at.strftime('%d/%m/%Y %I:%M%p'),
                      created_at: task.created_at.strftime('%d/%m/%Y %I:%M%p'),
                      updated_at: task.updated_at.strftime('%d/%m/%Y %I:%M%p')
                    }
                  }
    else
      render_bad_request(task.errors)
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :completed, :completed_at)
  end
end
