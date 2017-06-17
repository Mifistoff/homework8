class Project < ApplicationRecord
  belongs_to :user

  # TODO: Move validations to Project::CreateForm and Project::UpdateForm
  validates :name, presence: true

  # TODO: Remove callbacks
  before_save :check_plan

  def check_plan
    return if user.plan == 'custom'
    return if user.plan == 'free'     && user.projects.count < 3
    return if user.plan == 'business' && user.projects.count < 10
    return if user.plan == 'premium'  && user.projects.count < 100
    return if user.plan == 'custom'

    errors.add(:base, "Your #{user.plan} plan is over limited. Please increase it for creating more projects")
  end
end
