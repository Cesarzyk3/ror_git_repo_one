require 'rails_helper'

RSpec.describe User, type: :model do
  context 'during creation' do
    it 'cannot have blank email' do
      user = User.new(email: '', password: 'foobar', password_confirmation: 'foobar')
      user.save
      expect(user).not_to be_valid
    end

    it 'cannot have blank password' do
      user = User.new(email: 'foo@bar.com', password: '', password_confirmation: 'foobar')
      user.save
      expect(user).not_to be_valid
    end

    it 'must have the same passwords' do
      user = User.new(email: 'foo@bar.com', password: 'barfoo', password_confirmation: 'foobar')
      user.save
      expect(user).not_to be_valid
    end
  end
end
