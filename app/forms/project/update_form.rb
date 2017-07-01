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
      @record = id ? User.find(id) : User.new
      if @record.valid?
        @record.update!
        true
      else
        false
      end
  end
end
