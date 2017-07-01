require 'rails_helper'

RSpec.describe Project::AllForUser do
  let(:good_user)  { create(:user, email: 'good@example.com') }
  let(:bad_user)   { create(:user, email: 'bad@example.com') }

  let(:good_project)   { create(:project, user: good_user) }
  let(:another_project) { create(:project, user: bad_user) }

  let(:query) { described_class.new.call(Project.all, good_user) }

  it 'returns expected scope' do
    expect(query).to include(good_project)
    expect(query).not_to include(another_project)
  end
end
