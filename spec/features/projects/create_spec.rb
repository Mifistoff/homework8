require 'rails_helper'

RSpec.describe 'Projects#create' do
  let(:user) { create(:user, email: 'test@example.com') }

  before do
    assume_logged_in(user)
    visit '/projects/new'
  end

  it 'creates new project' do
    fill_in 'Name', with: 'First Project'
    click_button 'Create Project'

    expect(page).to have_current_path "/projects/#{Project.last.id}"
    expect(page).to have_content 'First Project'
  end

  context 'over free plan' do
    before do
      3.times { user.projects << create(:project, user: user) }
    end

    it 'shows plan over limit message' do
      fill_in 'Name', with: 'Fourth Project'
      click_button 'Create Project'

      expect(page).to have_current_path '/projects'
      expect(page).to have_content 'Your free plan is over limited. Please increase it for creating more projects'
    end
  end

  context 'over business plan' do
    before do
      user.business!
      user.reload
      10.times { user.projects << create(:project, user: user) }
    end

    it 'shows plan over limit message' do
      fill_in 'Name', with: 'Eleventh Project'
      click_button 'Create Project'

      expect(page).to have_current_path '/projects'
      expect(page).to have_content 'Your business plan is over limited. Please increase it for creating more projects'
    end
  end

  context 'over premium plan' do
    before do
      user.premium!
      user.reload
      100.times { user.projects << create(:project, user: user) }
    end

    it 'shows plan over limit message' do
      fill_in 'Name', with: 'One hundred and first Project'
      click_button 'Create Project'

      expect(page).to have_current_path '/projects'
      expect(page).to have_content 'Your premium plan is over limited. Please increase it for creating more projects'
    end
  end

  context 'custom plan' do
    before do
      user.custom!
      user.reload
      101.times { user.projects << create(:project, user: user) }
    end

    it 'shows plan over limit message' do
      fill_in 'Name', with: 'One hundred and first Project'
      click_button 'Create Project'

      expect(page).to have_current_path "/projects/#{Project.last.id}"
      expect(page).to have_content 'One hundred and first Project'
    end
  end
end
