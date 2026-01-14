class ParticipationsController < ApplicationController
  def create
    event = Event.find(params[:event_id])

    if Participation.exists?(user_id: current_user.id, event_id: event.id, status: ["favorite", "confirmed"])
      redirect_back fallback_location: events_path, alert: "すでに参加希望済みです"
      return
    end

    total_participants = event.participations.where(status: ["favorite", "confirmed"]).count
    if total_participants >= event.capacity
      redirect_back fallback_location: events_path, alert: "定員に達しているため参加できません"
      return
    end

    @participation = Participation.new(
      user_id: current_user.id,
      event_id: event.id,
      status: "favorite"
    )

    if @participation.save
      redirect_back fallback_location: events_path, notice: "参加希望を送信しました"
    else
      redirect_back fallback_location: events_path, alert: "参加希望に失敗しました"
    end
  end

  def update
    @participation = Participation.find(params[:id])

    unless @participation.user == current_user || current_user.admin?
      redirect_back fallback_location: events_path, alert: "更新権限がありません"
      return
    end

    if params[:status] == "favorite"
      total_participants = @participation.event.participations.where(status: ["favorite", "confirmed"]).count
      if total_participants >= @participation.event.capacity
        redirect_back fallback_location: events_path, alert: "定員に達しているため再登録できません"
        return
      end
    end

    if @participation.update(status: params[:status])
      redirect_back fallback_location: events_path, notice: "ステータスを更新しました"
    else
      redirect_back fallback_location: events_path, alert: "更新に失敗しました"
    end
  end

  def destroy
    @participation = Participation.find(params[:id])

    unless @participation.user == current_user || current_user.admin?
      redirect_back fallback_location: events_path, alert: "削除権限がありません"
      return
    end

    @participation.destroy
    redirect_back fallback_location: events_path, notice: "参加を取り消しました"
  end
end
