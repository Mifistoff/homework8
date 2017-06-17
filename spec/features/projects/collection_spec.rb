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
      3.times { user.projects << create(:project, user: user) }
      visit '/projects'
    end

    it { expect(page).to_not have_link 'New Project' }
    it { expect(page).to have_content 'Your free plan is over limited. Please increase it for creating more projects' }
  end

  context 'over business plan' do
    before do
      user.business!
      user.reload
      10.times { user.projects << create(:project, user: user) }
      visit '/projects'
    end

    it { expect(page).to_not have_link 'New Project' }
    it { expect(page).to have_content 'Your business plan is over limited. Please increase it for creating more projects' }
  end

  context 'over premium plan' do
    before do
      user.premium!
      user.reload
      100.times { user.projects << create(:project, user: user) }
      visit '/projects'
    end

    it { expect(page).to_not have_link 'New Project' }
    it { expect(page).to have_content 'Your premium plan is over limited. Please increase it for creating more projects' }
  end

  context 'custom plan' do
    before do
      user.custom!
      user.reload
      101.times { user.projects << create(:project, user: user) }
      visit '/projects'
    end

    it { expect(page).to have_link 'New Project' }
  end
end
