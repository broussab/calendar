require 'rails_helper'

RSpec.describe API::MeetingsController, type: :controller do
  let!(:user) do
    FactoryGirl.create(:user, {
      firstname: 'Alyssa',
      lastname: 'Broussard',
      slackhandle: 'alyssa',
      email:  'alybeic@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    })
  end

  let(:headers) do
    { 'ORIGIN' => 'http://registered_application.com',
      'ACCEPT' => 'application/json',
      'CONTENT_TYPE' => 'application/json'}
  end

  let(:params) do
    { format: :json,
      :text => 'a reason',
      :user_name => 'alyssa' }
  end

  describe "adding a meeting" do
    it 'should create a meeting' do
      params[:text] = 'sick, 03-27-2017 8:00 AM, 03-27-2017 5:00 PM'
      post :create, params: params, headers: headers

      expect(response).to be_success

      body = JSON.parse(response.body)
      expect(body['attachments'][0]['title']).to eq("Alyssa Broussard  -  sick")
      expect(body['attachments'][0]['text']).to eq("#{user.meetings.last.start_time.strftime '%B %d, %Y at %I:%M %P'} - #{user.meetings.last.end_time.strftime '%B %d, %Y at %I:%M %P'}")
    end

    it 'should return an error if the text param is not accurate' do
      params[:text] = 'sick 2017-03-27'
      post :create, params: params, headers: headers

      expect(response).to be_unprocessable
    end
  end

  describe 'getting help' do
    it 'should return the help message' do
      params[:text] = 'help'
      post :create, params: params, headers: headers

      expect(response).to be_success

      body = JSON.parse(response.body)
      expect(body['attachments'][0]['title']).to eq("Out of Office Calendar Help")
      expect(body['attachments'][0]['text']).to eq("Just enter /ooo [reason, start time, end time] and your event will automatically be added to the Out of Office Calendar! Make sure the parameters are separated by commas and the times are in the format: MM-DD-YYYY HH:MM am/pm. For example: /ooo WFH, 03-27-2017 8:00 am, 03-27-2017 5:00 pm")
    end
  end

  describe 'is a user in or out' do
    let(:meeting) do
      FactoryGirl.create(:meeting, {
        name: 'Alyssa Broussard',
        reason: 'vacation',
        start_time: '2017-03-30 08:00:00',
        end_time: '2017-03-30 17:00:00',
        user: user
      })
    end

    it 'should return if the user is in/out' do
      params[:text] = '@alyssa'
      post :create, params: params, headers: headers

      JSON.parse(response.body)
      expect(response).to be_success
    end

    it 'should return if the user does not exist' do
      params[:text] = '@test'
      post :create, params: params, headers: headers
      JSON.parse(response.body)
      expect(response).to be_unprocessable
    end
  end
end
