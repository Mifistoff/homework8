require 'rails_helper'

RSpec.describe 'Projects#collection' do
  let(:user) { create(:user, email: 'test@example.com') }

  before { assume_logged_in(user) }

  context 'no projects' do
    before { visit '/projects' }

    it { expect(page).to have_link 'New Project' }
  end

  context 'over free plan' do
    before do
      allow(user).to receive_message_chain(:projects, :count) { 3 }
      visit '/projects'
    end

    it do
      expect(page).to_not have_link 'New Project'
      expect(page).to have_content 'Your free plan is over limited. Please increase it for creating more projects'
    end
  end

  context 'over business plan' do
    before do
      user.business!
      allow(user).to receive_message_chain(:projects, :count) { 10 }
      visit '/projects'
    end

    it do
      expect(page).to_not have_link 'New Project'
      expect(page).to have_content 'Your business plan is over limited. Please increase it for creating more projects'
    end
  end

  context 'over premium plan' do
    before do
      user.premium!
      allow(user).to receive_message_chain(:projects, :count) { 100 }
      visit '/projects'
    end

    it do
      expect(page).to_not have_link 'New Project'
      expect(page).to have_content 'Your premium plan is over limited. Please increase it for creating more projects'
    end
  end

  context 'custom plan' do
    before do
      user.custom!
      allow(user).to receive_message_chain(:projects, :count) { 101 }
      visit '/projects'
    end

    it { expect(page).to have_link 'New Project' }
  end
end
