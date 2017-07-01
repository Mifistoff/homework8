require 'rails_helper'

RSpec.describe Project::CreatePolicy do
  let(:policy) { described_class.new(user) }

  context 'allowed' do
    let(:user) { instance_double User, free?: true }

    before do
      allow(user).to receive_message_chain(:projects, :count) { 1 }
    end

    it { expect(policy).to be_allowed }
  end

  context 'not allowed' do
    let(:user) do
      instance_double User, free?: true, business?: true, premium?: false, custom?: false
    end

    before do
      allow(user).to receive_message_chain(:projects, :count) { 10 }
    end

    it { expect(policy).not_to be_allowed }
  end
end
