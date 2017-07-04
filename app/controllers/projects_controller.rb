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
    if @project.save
      redirect_to @project, notice: I18n.t(:project_created)
    else
      render :new
    end

  rescue ProjectLimitError
    redirect_to projects_url,
    alert: I18n.t(:plan_over_limited, plan: current_user.plan)
  end

  def update
    # TODO: Refactor to form
    form = Project::UpdateForm.new(project_params)
    if form.validate?
      @project.update(project_params)
      redirect_to @project, notice: I18n.t(:project_updated)
    else
      render :edit
    end
  end

  def destroy
    if Project::Destroy.new(@project).call
      redirect_to projects_url, notice: I18n.t(:project_destroyed)
    else
      redirect_to projects_url,
      alert: I18n.t(:project_not_destroyed, name: @project.name)
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
