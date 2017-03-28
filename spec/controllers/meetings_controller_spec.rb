require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'GET show' do
    let(:my_meeting) { create(:meeting, user_id: @user.id) }

    it 'returns http success' do
      get :show, id: my_meeting.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      get :show, id: my_meeting.id
      expect(response).to render_template :show
    end

    it 'assigns meeting to @meeting' do
      get :show, id: my_meeting.id
      expect(assigns(:meeting)).to eq(my_meeting)
    end
  end

  describe 'GET new' do
    let(:my_meeting) { create(:meeting, user_id: @user.id) }

    it 'returns http success' do
      get :new, id: my_meeting.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new, id: my_meeting.id
      expect(response).to render_template :new
    end

    it 'instantiates @meeting' do
      get :new, id: my_meeting.id
      expect(assigns(:meeting)).not_to be_nil
    end
  end

  describe 'POST create' do
    it 'increases the number of Meeting by 1' do
      expect { post :create, meeting: { 'reason' => 'sick', 'user_id' => @user.id, 'start_time(1i)' => '2017',
                                 'start_time(2i)' => '03',
                                 'start_time(3i)' => '25',
                                 'start_time(4i)' => '08',
                                 'start_time(5i)' => '00:00',
                                 'end_time(1i)' => '2017',
                                 'end_time(2i)' => '03',
                                 'end_time(3i)' => '25',
                                 'end_time(4i)' => '17',
                                 'end_time(5i)' => '00:00' } }.to change(Meeting, :count).by(1)
    end

    it 'assigns the new meeting to @meeting' do
      post :create, meeting: { 'reason' => 'sick', 'user_id' => @user.id, 'start_time(1i)' => '2017',
                                 'start_time(2i)' => '03',
                                 'start_time(3i)' => '25',
                                 'start_time(4i)' => '08',
                                 'start_time(5i)' => '00:00',
                                 'end_time(1i)' => '2017',
                                 'end_time(2i)' => '03',
                                 'end_time(3i)' => '25',
                                 'end_time(4i)' => '17',
                                 'end_time(5i)' => '00:00' }
      expect(assigns(:meeting)).to eq Meeting.last
    end

    it 'redirects to the new meeting' do
      post :create, meeting: { 'reason' => 'sick', 'user_id' => @user.id, 'start_time(1i)' => '2017',
                                 'start_time(2i)' => '03',
                                 'start_time(3i)' => '25',
                                 'start_time(4i)' => '08',
                                 'start_time(5i)' => '00:00',
                                 'end_time(1i)' => '2017',
                                 'end_time(2i)' => '03',
                                 'end_time(3i)' => '25',
                                 'end_time(4i)' => '17',
                                 'end_time(5i)' => '00:00' }
      expect(response).to redirect_to [Meeting.last]
    end
  end

  describe 'GET edit' do
    let(:my_meeting) { create(:meeting, user_id: @user.id) }

    it 'returns http success' do
      get :edit, id: my_meeting.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      get :edit, id: my_meeting.id
      expect(response).to render_template :edit
    end

    it 'assigns meeting to be updated to @meeting' do
      get :edit, id: my_meeting.id
      meeting_instance = assigns(:meeting)

      expect(meeting_instance.id).to eq my_meeting.id
      expect(meeting_instance.name).to eq my_meeting.name
      expect(meeting_instance.reason).to eq my_meeting.reason
      expect(meeting_instance.start_time).to eq my_meeting.start_time
      expect(meeting_instance.end_time).to eq my_meeting.end_time
    end
  end

  describe 'PUT update' do
    let(:my_meeting) { create(:meeting, user_id: @user.id) }

      it 'updates post with expected attributes' do
        new_reason = 'vacation'

        put :update, id: my_meeting.id, meeting: { reason: new_reason, 'start_time(1i)' => '2017',
                                   'start_time(2i)' => '03',
                                   'start_time(3i)' => '25',
                                   'start_time(4i)' => '08',
                                   'start_time(5i)' => '00:00',
                                   'end_time(1i)' => '2017',
                                   'end_time(2i)' => '03',
                                   'end_time(3i)' => '26',
                                   'end_time(4i)' => '17',
                                   'end_time(5i)' => '00:00'}

        updated_meeting = assigns(:meeting)
        expect(updated_meeting.id).to eq my_meeting.id
        expect(updated_meeting.reason).to eq new_reason
      end

      it 'redirects to the updated post' do
        new_reason = 'vacation'

        put :update, id: my_meeting.id, meeting: { reason: new_reason, 'start_time(1i)' => '2017',
                                   'start_time(2i)' => '03',
                                   'start_time(3i)' => '25',
                                   'start_time(4i)' => '08',
                                   'start_time(5i)' => '00:00',
                                   'end_time(1i)' => '2017',
                                   'end_time(2i)' => '03',
                                   'end_time(3i)' => '25',
                                   'end_time(4i)' => '17',
                                   'end_time(5i)' => '00:00'}

        expect(response).to redirect_to [my_meeting]
      end
    end

    describe 'DELETE destroy' do
      let(:my_meeting) { create(:meeting, user_id: @user.id) }

      it 'deletes the post' do
        delete :destroy, id: my_meeting.id
        count = Meeting.where(id: my_meeting.id).size
        expect(count).to eq 0
      end

      it 'redirects to posts index' do
        delete :destroy, id: my_meeting.id
        expect(response).to redirect_to root_path
      end
    end
end
