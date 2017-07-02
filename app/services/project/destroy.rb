class Project
  class Destroy
    def initialize(project)
      @project = project
    end

    def call
      if @project.tasks.blank?
        @project.destroy
        true
      else
        false
      end
    end
  end
end
