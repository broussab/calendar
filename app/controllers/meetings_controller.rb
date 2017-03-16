class MeetingsController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :create]
  def index
    @meetings = Meeting.all
  end

  def show
    @meeting = Meeting.find(params[:id])
    sdate = @meeting.start_time
    edate = @meeting.end_time
    @start_time = sdate.strftime '%B %d, %Y at %I:%M %P'
    @end_time = edate.strftime('%B %d, %Y at %I:%M %P')
  end

  def new
    @meeting = Meeting.new
  end

  def create
    params[:meeting][:start_time] = DateTime.new(params[:meeting]['start_time(1i)'].to_i,
                                                 params[:meeting]['start_time(2i)'].to_i,
                                                 params[:meeting]['start_time(3i)'].to_i,
                                                 params[:meeting]['start_time(4i)'].to_i,
                                                 params[:meeting]['start_time(5i)'].to_i)
    params[:meeting][:end_time] = DateTime.new(params[:meeting]['end_time(1i)'].to_i,
                                               params[:meeting]['end_time(2i)'].to_i,
                                               params[:meeting]['end_time(3i)'].to_i,
                                               params[:meeting]['end_time(4i)'].to_i,
                                               params[:meeting]['end_time(5i)'].to_i)

    @meeting = current_user.meetings.build(meeting_params)
    @meeting.name = current_user.full_name

    if @meeting.save
      flash[:notice] = 'Out of office event was saved.'
      redirect_to @meeting
    else
      flash.now[:alert] = 'There was an error saving the out of office event. Please try again.'
      render :new
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])

    params[:meeting][:start_time] = DateTime.new(params[:meeting]['start_time(1i)'].to_i,
                                                 params[:meeting]['start_time(2i)'].to_i,
                                                 params[:meeting]['start_time(3i)'].to_i,
                                                 params[:meeting]['start_time(4i)'].to_i,
                                                 params[:meeting]['start_time(5i)'].to_i)
    params[:meeting][:end_time] = DateTime.new(params[:meeting]['end_time(1i)'].to_i,
                                               params[:meeting]['end_time(2i)'].to_i,
                                               params[:meeting]['end_time(3i)'].to_i,
                                               params[:meeting]['end_time(4i)'].to_i,
                                               params[:meeting]['end_time(5i)'].to_i)

    if @meeting.update(meeting_params)
      flash[:notice] = 'Out of office event was saved.'
      redirect_to @meeting
    else
      flash.now[:alert] = 'There was an error saving the out of office event. Please try again.'
      render :edit
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    if @meeting.destroy
      flash[:notice] = "\"#{@meeting.name}-#{@meeting.reason}\" was deleted successfully."
      redirect_to root_path
    else
      flash.now[:alert] = 'There was an error deleting the out of office event.'
      render :show
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:reason, :start_time, :end_time)
  end

  def authorize_user
    @meeting = Meeting.find(params[:id])
    unless @meeting.user == current_user || current_user.admin?
      flash[:alert] = 'You must be the owner of the event or an admin to do that.'
      redirect_to root_path
    end
  end
end
