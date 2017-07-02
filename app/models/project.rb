class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks

  # TODO: Move validations to Project::CreateForm and Project::UpdateForm
  validates :name, presence: true
end
