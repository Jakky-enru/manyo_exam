class TasksController < ApplicationController
  # before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(5)
    @tasks = Task.all.sort_deadline.page(params[:page]).per(5) if params[:sort_deadline]
    @tasks = Task.all.sort_priority.page(params[:page]).per(5) if params[:sort_priority]

    if params[:task].present?    
      if params[:task][:name].present? && params[:task][:status].present?  
        @tasks = Task.search_name(params[:task][:name]).page(params[:page]).per(5)
        @tasks = Task.search_status(params[:task][:status]).page(params[:page]).per(5)
      elsif params[:task][:name].present?                            
        @tasks = Task.search_name(params[:task][:name]).page(params[:page]).per(5)
      elsif params[:task][:status].present?                              
        @tasks = Task.search_status(params[:task][:status]).page(params[:page]).per(5)
      end
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end
  
  # POST /tasks
  def create
    @task = Task.new(task_params)
    
    if @task.save
      redirect_to task_path(@task.id), notice: 'タスクを作成しました'
    else
      render :new
    end
  end

  # GET /tasks/1
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # PATCH/PUT /tasks/1
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: 'タスクを編集しました'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :content, :deadline, :status, :priority)
  end
end
