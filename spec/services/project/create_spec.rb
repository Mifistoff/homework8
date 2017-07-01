require 'rails_helper'

RSpec.describe Project::Create do
  let(:valid_params) { { name: 'My Params' } }
  let(:invalid_params) { { name: '' } }

  let(:user) { create(:user, email: 'create@test.com') }

  let(:success_result) { Project::Create.new(valid_params, user).call }
  let(:failure_result) { Project::Create.new(invalid_params, user).call }

  context 'valid_params' do
    it { expect(success_result.id).to be_truthy }
  end

  context 'invalid_params' do
    it { expect(failure_result.id).to be_falsey }
  end
end
