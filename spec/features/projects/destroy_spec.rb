require 'rails_helper'

RSpec.describe 'Projects#destroy' do
  let(:user) { create(:user, email: 'test@example.com') }

  before { assume_logged_in(user) }

  context 'project without tasks' do
    before do
      user.projects << create(:project, user: user)
      visit '/projects'
    end

    it 'can to destroy' do
      click_link 'Destroy'

      expect(page).to have_current_path '/projects'
      expect(page).to have_content 'Project was successfully destroyed.'
    end
  end

  context 'project with tasks' do
    before do
      @project = (user.projects << create(:project, user: user)).last
      @project.tasks << create(:task, project: @project)
      visit '/projects'
    end

    it 'cant destroy' do
      click_link 'Destroy'

      expect(page).to have_current_path '/projects'
      expect(page).to have_content "The project: '#{@project.name}' has tasks"
    end
  end

end
