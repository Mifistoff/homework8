class Project
  class CreatePolicy
    # TODO: Implement
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def allowed?
      free? || business? || premium? || custom?
    end

    private

    def free?
      user.free? && user.projects.count < 3
    end

    def business?
      user.business? && user.projects.count < 10
    end

    def premium?
      user.premium? && user.projects.count < 100
    end

    def custom?
      user.custom?
    end
  end
end
