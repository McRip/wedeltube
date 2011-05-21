class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_participant

  def create

  end

  def update

  end

  def destroy
    
  end

  private

  def find_participant
    @participant = Particiant.find params[:id]
  end
end
