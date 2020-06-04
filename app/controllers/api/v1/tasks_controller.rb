class Api::V1::TasksController < ApplicationController

  def index
    tasks = Task.all.order('created_at DESC')
    render json: tasks
  end

  def create
    task = Task.create!(task_params)
    render json: task
  end

  def update
    task = Task.find(params[:id]).toggle!(:is_done)
  end

  def destroy
    Task.find(params[:id]).destroy!
  end

  private
    def task_params
      params.require(:task).permit(:content, :is_done, :week, :notification_time, :user_id)
    end
end
