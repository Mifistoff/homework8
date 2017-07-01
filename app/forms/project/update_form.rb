class Project
  class UpdateForm
    # TODO :Implement
    include ActiveModel::Model
    include Virtus.model

    attribute :id, Integer
    attribute :name, String
    attribute :user_id, Integer

    validates :name, presence: true

    def persist

    end
  end
end
