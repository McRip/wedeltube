class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_participant, :except => [ :create ]

  def create
    @participant = Participant.new(params[:participant])
    render @participant
  end

  def update
    @participant.update_attributes(params[:participant])
    render @participant
  end

  def destroy
    @video = @participant.video
    @participant.destroy
    redirect_to @video
  end

  private

  def find_participant
    @participant = Particiant.find params[:id]
  end
end
