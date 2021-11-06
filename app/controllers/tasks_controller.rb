class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  PER = 8
  # GET /tasks or /tasks.json
  def index
    # @tasks = current_user.tasks.all
    @tasks = current_user.tasks.page(params[:page]).per(PER)

    if params[:title].present? && params[:status].present? && params[:label_id].present?
      @tasks = @tasks.search_title(params[:title]).search_status(params[:status]).joins(:labels).where(labels: { id: params[:label_id] })

    elsif params[:title].present? && params[:status].present?
      @tasks = @tasks.search_title(params[:title]).search_status(params[:status])

    elsif params[:title].present? && params[:label_id].present?
      @tasks = @tasks.search_title(params[:title]).joins(:labels).where(labels: { id: params[:label_id] })

    elsif params[:status].present? && params[:label_id].present?
      @tasks = @tasks.search_status(params[:status]).joins(:labels).where(labels: { id: params[:label_id] })

    elsif params[:title].present?
      @tasks = @tasks.search_title(params[:title])

    elsif params[:status].present?
      @tasks = @tasks.search_status(params[:status])

    elsif params[:label_id].present?
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
    end

    if params[:sort_deadline]
      @tasks = @tasks.order(deadline:"DESC")
    elsif params[:sort_priority]
      @tasks = @tasks.order(priority:"DESC")
    else
      @tasks=@tasks.order(created_at:"DESC")
    end

  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :status, :deadline, :priority, { label_ids: [] })
    end
end
