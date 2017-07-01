class Project
  class Create
    # TODO: Implement
    def initialize(params = {}, user)
      @name = params[:name]
      @user_id = user.id
    end

    def call
      Project.new(project_attributes)
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
