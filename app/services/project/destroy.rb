class Project
  class Destroy
    def initialize(project)
      @project = project
    end

    def call
      @project.destroy if @project.tasks.blank?
    end
  end
end
