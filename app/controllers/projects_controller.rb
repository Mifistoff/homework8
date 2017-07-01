class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # TODO: Refactor to query
    @projects = Project::AllForUser.new.call(Project.all, current_user)
  end

  def show
    # TODO: Refactor to policy
  end

  def new
    # TODO: Refactor to form
    @project = Project.new
  end

  def create
    # TODO: Refactor to form & policy
    @project = current_user.projects.new(project_params)

    save_project = -> {
      if @project.save
        redirect_to @project, notice: 'Project was successfully created.'
      else
        render :new
      end
    }

    if current_user.plan == 'free' && current_user.projects.count < 3
      save_project.call

    elsif current_user.plan == 'business' && current_user.projects.count < 10
      save_project.call

    elsif current_user.plan == 'premium' && current_user.projects.count < 100
      save_project.call

    elsif current_user.plan == 'custom'
      save_project.call

    else
      redirect_to projects_path, alert: "Your #{current_user.plan} plan is over limited. Please increase it for creating more projects"
    end
  end

  def update
    # TODO: Refactor to form
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :user_id)
  end
end
