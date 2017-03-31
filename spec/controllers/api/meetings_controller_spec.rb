require 'rails_helper'

RSpec.describe API::MeetingsController, type: :controller do

  describe "Meetings API" do
    it 'should create a meeting' do

    user = User.create!(firstname: 'Alyssa',
      lastname: 'Broussard',
      slackhandle: 'alyssa',
      email:  'alybeic@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    )

      params = {format: :json, :text => 'sick, 03-27-2017 12:30 pm, 03-27-2017 5:00 pm', :user_name => 'alyssa'}

      post :create, params, {'ORIGIN' => 'http://registered_application.com', 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json'}

      json = JSON.parse(response.body)

      expect(response).to be_success

      expect(assigns(:meeting)).to eq Meeting.last
    end

    it 'should return an error if the text param is not accurate' do
      user = User.create!(firstname: 'Alyssa',
        lastname: 'Broussard',
        slackhandle: 'alyssa',
        email:  'alybeic@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )

        params = {format: :json, :text => 'sick 2017-03-27', :user_name => 'alyssa'}

        post :create, params, {'ORIGIN' => 'http://registered_application.com', 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json'}

        json = JSON.parse(response.body)

        expect(response).to be_unprocessable
    end

    it 'should return the help message' do
      params = {format: :json, :text => 'help'}

      post :create, params, {'ORIGIN' => 'http://registered_application.com', 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json'}

      json = JSON.parse(response.body)
      expect(response).to be_success
    end

    it 'should return if the user is in/out' do
      @user = User.create!(firstname: 'Alyssa',
        lastname: 'Broussard',
        slackhandle: 'alyssa',
        email:  'alybeic@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )

      @meeting = Meeting.create!(name: 'Alyssa Broussard',
        reason: 'vacation',
        start_time: '2017-03-30 08:00:00',
        end_time: '2017-03-30 17:00:00',
        user_id: @user.id
      )

      params = {format: :json, :text => '@alyssa'}

      post :create, params, {'ORIGIN' => 'http://registered_application.com', 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json'}

      json = JSON.parse(response.body)
      expect(response).to be_success
    end

    it 'should return if the user does not exist' do
      params = {format: :json, :text => '@test'}

      post :create, params, {'ORIGIN' => 'http://registered_application.com', 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json'}

      json = JSON.parse(response.body)
      expect(response).to be_unprocessable
    end
  end
end
