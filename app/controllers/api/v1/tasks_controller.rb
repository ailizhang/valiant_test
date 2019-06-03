class Api::V1::TasksController < Api::V1::BaseController
  def show
    task = Task.find_by_id(params[:id])

    if task.present?
      render json: { success: true, task: format_json(task) }
    else
      render_bad_request('Task not found')
    end
  end

  def create
    task = Task.new task_params

    if task.save
      render json: { success: true, task: format_json(task) }
    else
      render_bad_request(task.errors)
    end
  end

  def update
    task = Task.find_by_id(params[:id])

    if task.update task_params
      render json: { success: true, task: format_json(task) }
    else
      render_bad_request(task.errors)
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :completed, :completed_at)
  end

  def format_json(task)
    {
      id: task.id,
      description: task.description,
      completed: task.completed,
      completed_at: task.completed_at.try(:strftime, '%d/%m/%Y %I:%M%p'),
      created_at: task.created_at.strftime('%d/%m/%Y %I:%M%p'),
      updated_at: task.updated_at.strftime('%d/%m/%Y %I:%M%p')
    }
  end
end
