require 'rails_helper'

RSpec.describe Project::Destroy do
  let(:user) { create(:user, email: 'destroy@test.com') }

  let(:project) { create(:project, user: user) }

  let(:success_result) { Project::Destroy.new(project).call }
  let(:failure_result) { Project::Destroy.new(project).call }

  context 'without tasks' do
    it { expect(success_result).to be_truthy }
  end

  context 'with tasks' do
    before do
      project.tasks << create(:task, project: project)
    end
    it { expect(failure_result).to be_falsey }
  end
end
