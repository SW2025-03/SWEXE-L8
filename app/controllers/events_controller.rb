class EventsController < ApplicationController
  def index
    @evevts=Event.all
  end
  
  def show
    @event=Event.find(params[:id])
  end
  
  def new
    @event=Event.new
  end
  
  def create
    @event = Event.new(event_params)
    
    @event.creator_id = current_user.id if logged_in?

    if @event.save
      redirect_to events_path, notice: "イベントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def event_params
    params.require(:event).permit(
      :title, :description, :location,
      :start_datetime, :end_datetime,
      :capacity, :category, :organizer,
      :thumbnail_url, :is_public
    )
  end
end
