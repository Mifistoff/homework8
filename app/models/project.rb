class Project < ApplicationRecord
  belongs_to :user

  # TODO: Move validations to Project::CreateForm and Project::UpdateForm
  validates :name, presence: true
end
