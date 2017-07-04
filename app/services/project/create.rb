class Project
  class Create
    # TODO: Implement
    def initialize(params = {}, user)
      @name = params[:name]
      @user_id = user.id
    end

    def call
      if project_attributes[:name].empty?
        @project = Project.create(project_attributes)
        @project.user_id = nil
      else
        Project.create(project_attributes)
      end
    end

    private

    attr_reader :name, :user_id

    def project_attributes
      {
        name: name,
        user_id: user_id
      }
    end
  end
end
