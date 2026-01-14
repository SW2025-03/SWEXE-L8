class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new(
      user_id: current_user&.id,   
      event_id: params[:event_id],
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

    if current_user.nil? || (@participation.user && @participation.user != current_user && !current_user.admin?)
      redirect_back fallback_location: events_path, alert: "更新権限がありません"
      return
    end

    if @participation.update(status: params[:status])
      redirect_back fallback_location: events_path, notice: "ステータスを更新しました"
    else
      redirect_back fallback_location: events_path, alert: "更新に失敗しました"
    end
  end

  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy

    redirect_back fallback_location: events_path, notice: "参加を取り消しました"
  end
end
