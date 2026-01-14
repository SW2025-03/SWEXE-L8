class EventsController < ApplicationController
  def index
    @events = Event.where(is_public: true)

    if params[:keyword].present?
      @events = @events.where("title LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @events = @events.where(category: params[:category])
    end

    if params[:start_date].present?
      begin_date = Date.parse(params[:start_date])
      @events = @events.where("start_datetime >= ?", begin_date.beginning_of_day)
    end

    @events = @events.order(start_datetime: :asc)
  end

  def show
    @event = Event.find_by(id: params[:id])
    unless @event
      redirect_to events_path, alert: "指定されたイベントが見つかりません"
      return
    end
  
    if logged_in? && (@event.creator_id == current_user.id || current_user.admin?)
      @participations = Participation
        .includes(:user)
        .where(event_id: @event.id, status: "favorite")
  
      @favorite_count = @participations.count
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id

    if @event.save
      redirect_to @event, notice: "イベントを作成しました"
    else
      render :new
    end
  end

  def edit
    @event = Event.find_by(id: params[:id])
    if @event.nil? || (@event.creator_id != current_user.id && !current_user.admin?)
      redirect_to events_path, alert: "編集権限がありません"
    end
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event && (@event.creator_id == current_user.id || current_user.admin?)
      if @event.update(event_params)
        redirect_to @event, notice: "イベントを更新しました"
      else
        render :edit
      end
    else
      redirect_to events_path, alert: "編集権限がありません"
    end
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event && (@event.creator_id == current_user.id || current_user.admin?)
      @event.destroy
      redirect_to events_path, notice: "イベントを削除しました"
    else
      redirect_to events_path, alert: "削除権限がありません"
    end
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :location,
      :start_datetime, :end_datetime,
      :capacity, :category, :organizer,
      :thumbnail_url, :is_public
    )
  end
  
  def join
  event = Event.find(params[:id])

  if event.full?
    redirect_to event_path(event), alert: "定員に達しています"
    return
  end

  event.participations.create(user: current_user)
  redirect_to event_path(event), notice: "参加しました"
end
end
