require 'rails_helper'

RSpec.describe Meeting, type: :model do
  let(:user) { create(:user) }
  let(:meeting) { create(:meeting) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:reason) }
  it { is_expected.to validate_presence_of(:start_time) }
  it { is_expected.to validate_presence_of(:end_time) }
  it { is_expected.to validate_presence_of(:user) }

  describe 'attributes' do
    it 'has name, reason, start_time, end_time and user attributes' do
      expect(meeting).to have_attributes(name: meeting.name, reason: meeting.reason, start_time: meeting.start_time, end_time: meeting.end_time)
    end
  end
end
