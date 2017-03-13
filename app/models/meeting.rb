class Meeting < ApplicationRecord
  default_scope { order('start_time ASC') }

  scope :for_calendar, ->(start_date, end_date) { where('(? BETWEEN start_time AND end_time) OR (? BETWEEN start_time AND end_time)', start_date, end_date) }

  validates :name, presence: true
  validates :reason, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
