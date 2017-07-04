class Project
  class UpdateForm
    # TODO :Implement
    include ActiveModel::Model
    include Virtus.model

    attribute :name, String
    attribute :user_id, Integer

    validates :name, presence: true

    def validate?
      name != ''
    end
  end
end
