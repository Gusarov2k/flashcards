require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:cards) }
  end

  it 'has a valid factory' do
    create(:user).should be_valid
  end
end
