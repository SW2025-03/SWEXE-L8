class EventsController < ApplicationController

  def index
    @events = Event.order(start_datetime: :asc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(
      title: params[:event][:title],
      description: params[:event][:description],
      location: params[:event][:location],
      start_datetime: params[:event][:start_datetime],
      end_datetime: params[:event][:end_datetime],
      capacity: params[:event][:capacity],
      category: params[:event][:category],
      organizer: params[:event][:organizer],
      thumbnail_url: params[:event][:thumbnail_url],
      is_public: params[:event][:is_public],
      creator_id: params[:event][:creator_id]
    )

    if @event.save
      redirect_to @event, notice: "イベントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(
      title: params[:event][:title],
      description: params[:event][:description],
      location: params[:event][:location],
      start_datetime: params[:event][:start_datetime],
      end_datetime: params[:event][:end_datetime],
      capacity: params[:event][:capacity],
      category: params[:event][:category],
      organizer: params[:event][:organizer],
      thumbnail_url: params[:event][:thumbnail_url],
      is_public: params[:event][:is_public]
    )
      redirect_to @event, notice: "イベントを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "イベントを削除しました"
  end

end
