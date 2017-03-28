require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:meetings) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  describe 'attributes' do
    it 'should have firstname, lastname, slackhandle, email, role' do
      expect(user).to have_attributes(firstname: user.firstname, lastname: user.lastname, slackhandle: user.slackhandle, email: user.email, password: user.password, password_confirmation: user.password_confirmation, role: user.role)
    end

    it 'responds to role' do
      expect(user).to respond_to(:role)
    end

    it 'responds to admin?' do
      expect(user).to respond_to(:admin?)
    end

    it 'responds to member?' do
      expect(user).to respond_to(:member?)
    end
  end

  describe 'roles' do
    it 'is member by default' do
      expect(user.role).to eql('member')
    end

    context 'member user' do
      it 'returns true for #member?' do
        expect(user.member?).to be_truthy
      end

      it 'returns false for #admin?' do
        expect(user.admin?).to be_falsey
      end
    end

    context 'admin user' do
      before do
        user.admin!
      end

      it 'returns false for #member?' do
        expect(user.member?).to be_falsey
      end

      it 'returns true for #admin?' do
        expect(user.admin?).to be_truthy
      end
    end
  end
end
