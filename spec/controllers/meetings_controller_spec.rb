require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'GET show' do
    let(:meeting) { create(:meeting, user: user) }

    before do
      get :show, params: { id: meeting.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      expect(response).to render_template :show
    end

    it 'assigns meeting to @meeting' do
      expect(assigns(:meeting)).to eq(meeting)
    end
  end

  describe 'GET new' do
    let(:meeting) { create(:meeting, user: user) }

    before do
      get :new, params: { id: meeting.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      expect(response).to render_template :new
    end

    it 'instantiates @meeting' do
      expect(assigns(:meeting)).not_to be_nil
    end
  end

  describe 'POST create' do
    it 'increases the number of Meeting by 1' do
      expect(-> {
        post :create,
          params: {
            meeting: {
              reason: 'sick',
                'user_id': user.id,
                'start_time(1i)': '2017',
                'start_time(2i)': '03',
                'start_time(3i)': '25',
                'start_time(4i)': '08',
                'start_time(5i)': '00:00',
                'end_time(1i)': '2017',
                'end_time(2i)': '03',
                'end_time(3i)': '25',
                'end_time(4i)': '17',
                'end_time(5i)': '00:00'
            }
          }
      }).to change(Meeting, :count).by(1)
    end

    context "response" do
      before do
        post :create, params: {
          meeting: {
            reason: 'sick',
            user_id: user.id,
            'start_time(1i)': '2017',
            'start_time(2i)': '03',
            'start_time(3i)': '25',
            'start_time(4i)': '08',
            'start_time(5i)': '00:00',
            'end_time(1i)': '2017',
            'end_time(2i)': '03',
            'end_time(3i)': '25',
            'end_time(4i)': '17',
            'end_time(5i)': '00:00'
          }
        }
      end

      it 'assigns the new meeting to @meeting' do
        expect(assigns(:meeting)).to eq Meeting.last
      end

      it 'redirects to the new meeting' do
        expect(response).to redirect_to [Meeting.last]
      end
    end
  end

  describe 'GET edit' do
    let(:meeting) { create(:meeting, user: user) }

    before do
      get :edit, params: { id: meeting.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      expect(response).to render_template :edit
    end

    it 'assigns meeting to be updated to @meeting' do
      meeting_instance = assigns(:meeting)

      expect(meeting_instance.id).to eq meeting.id
      expect(meeting_instance.name).to eq meeting.name
      expect(meeting_instance.reason).to eq meeting.reason
      expect(meeting_instance.start_time).to eq meeting.start_time
      expect(meeting_instance.end_time).to eq meeting.end_time
    end
  end

  describe 'PUT update' do
    let(:meeting) { create(:meeting, user: user) }
    let(:new_reason) { 'vacation' }

    before do
      put :update, params: {
        id: meeting.id,
        meeting: {
          reason: new_reason,
          'start_time(1i)': '2017',
          'start_time(2i)': '03',
          'start_time(3i)': '25',
          'start_time(4i)': '08',
          'start_time(5i)': '00:00',
          'end_time(1i)': '2017',
          'end_time(2i)': '03',
          'end_time(3i)': '26',
          'end_time(4i)': '17',
          'end_time(5i)': '00:00'
        }
      }
    end

    it 'updates post with expected attributes' do
      updated_meeting = assigns(:meeting)
      expect(updated_meeting.id).to eq meeting.id
      expect(updated_meeting.reason).to eq new_reason
    end

    it 'redirects to the updated post' do
      expect(response).to redirect_to [meeting]
    end
  end

  describe 'DELETE destroy' do
    let(:meeting) { create(:meeting, user: user) }

    before do
      delete :destroy, params: { id: meeting.id }
    end

    it 'deletes the post' do
      expect(Meeting.where(id: meeting.id).size).to eq 0
    end

    it 'redirects to posts index' do
      expect(response).to redirect_to root_path
    end
  end
end
