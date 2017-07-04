require 'rails_helper'

RSpec.describe Project::UpdateForm, type: :model do
  describe 'attributes' do
    it 'has name' do
      expect(described_class).to have_attribute(:name).of_type(String)
    end

    it 'has user_id' do
      expect(described_class).to have_attribute(:user_id).of_type(Integer)
    end
  end

  describe 'validates' do
    it 'has name' do
      is_expected.to validate_presence_of(:name)
    end

    it 'not have user_id' do
      is_expected.not_to validate_presence_of(:user_id)
    end
  end

  describe '#validate?' do
    it 'not validate if no name' do
      expect(described_class.new(name: '').validate?).to eq(false)
    end
  end
end
