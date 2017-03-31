class HomeController < ApplicationController
  def index
    date = DateTime.strptime(params[:start_date], '%Y-%m-%d') if params[:start_date]
    start_date = date ? date.beginning_of_month : DateTime.now.beginning_of_month
    end_date = date ? date.end_of_month : DateTime.now.end_of_month
    @meetings = Meeting.for_calendar(start_date - 6.days, end_date + 6.days)
  end

  def about; end

  def weekly
    date = DateTime.strptime(params[:start_date], '%Y-%m-%d') if params[:start_date]
    start_date = date ? date.beginning_of_week : DateTime.now.at_beginning_of_week
    end_date = date ? date.end_of_week : DateTime.now.at_end_of_week
    @meetings = Meeting.for_calendar(start_date, end_date)
  end

  def daily
    @meetings = Meeting.all
  end
end
