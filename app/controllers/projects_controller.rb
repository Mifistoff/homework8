class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  ProjectLimitError = Class.new(StandardError)

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
    raise ProjectLimitError unless policy.allowed?

    @project = Project::Create.new(project_params, current_user).call

    if @project.id
      redirect_to @project,
      notice: 'Project was successfully created.'
    else
      render :new
    end

  rescue ProjectLimitError
    redirect_to projects_path,
    alert: "Your #{current_user.plan} plan is over limited.
    Please increase it for creating more projects"
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
    if Project::Destroy.new(@project).call
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
    else
      redirect_to projects_url,
      alert: "The project: '#{@project.name}' has tasks"
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :user_id)
  end

  def policy
    Project::CreatePolicy.new(current_user)
  end
end
