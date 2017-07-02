class Project
  class CreateForm
    # TODO :Implement
    include ActiveModel::Model
    include Virtus.model

    attribute :id, Integer
    attribute :name, String
    attribute :user_id, Integer

    validates :name, presence: true

    def persist
      @record = Project.new
      if @record.valid?
        @record.save!
        true
      else
        false
      end
    end
  end
end
