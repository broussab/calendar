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

      params = {format: :json, :text => 'sick, 03-27-2017 8:00 Am, 03-27-2017 5:00 pm', :user_name => 'alyssa'}

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
  end
end
