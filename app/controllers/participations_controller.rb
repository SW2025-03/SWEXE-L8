class ParticipationsController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
    @participations = @event.participations
  end

  def create
    @event = Event.find(params[:event_id])

    participation = Participation.new(
      event_id: @event.id,
      user_id: session[:user_id],
      status: 0  
    )

    if participation.save
      redirect_to @event, notice: "イベントに参加しました"
    else
      redirect_to @event, alert: "参加できませんでした"
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    participation = @event.participations.find_by(user_id: session[:user_id])

    if participation
      participation.destroy
      redirect_to @event, notice: "参加をキャンセルしました"
    else
      redirect_to @event, alert: "参加情報がありません"
    end
  end

  def update
    @event = Event.find(params[:event_id])
    participation = @event.participations.find(params[:id])

    if participation.update(status: params[:status])
      redirect_to event_participations_path(@event), notice: "ステータスを更新しました"
    else
      redirect_to event_participations_path(@event), alert: "更新に失敗しました"
    end
  end
end
