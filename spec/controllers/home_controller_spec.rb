require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET weekly' do
    it 'renders the weekly template' do
      get :weekly
      expect(response).to render_template('weekly')
    end
  end

  describe 'GET daily' do
    it 'renders the daily template' do
      get :daily
      expect(response).to render_template('daily')
    end
  end

  describe 'GET about' do
    it 'renders the about template' do
      get :about
      expect(response).to render_template('about')
    end
  end
end
