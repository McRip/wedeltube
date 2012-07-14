class ReportsController < ApplicationController
  def create
    if params[:comment_id].present?
      object = Comment.find(params[:comment_id])
    elsif params[:video_id].present?
      object = Video.find(params[:video_id])
    elsif params[:user_id].present?
      object = User.find(params[:user_id])
    end
    report = object.reports.new(params[:report])
    report.user = current_user
    report.viewed = false
    if report.save
      render :json => {:success => true}
    else
      render :json => {:success => false}, :status => 501
    end
  end

  def index
    @reports = Report.all
  end

  def destroy
    report = Report.find params[:id]
    report.destroy
    redirect_to reports_url
  end
end
