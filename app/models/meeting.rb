class Meeting < ApplicationRecord
  belongs_to :user
  default_scope { order('start_time ASC') }

  scope :for_calendar, ->(start_date, end_date) { where('(? BETWEEN start_time AND end_time) OR (? BETWEEN start_time AND end_time) OR (start_time >= ? AND end_time <= ?)', start_date, end_date, start_date, end_date) }

  scope :for_user, -> { where('start_time >= ? AND end_time <= ?', DateTime.now - 365.days, DateTime.now + 365.days) }

  validates :name, presence: true
  validates :reason, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :user, presence: true
end
