class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_participant, :except => [ :create ]

  def create
    video = Video.find params[:video_id]
    if current_user.is_admin? || current_user.owns_video?(video)
      @participant = Participant.new(params[:participant])
      @participant.role = @participant.role.delete_if { |participant| participant.empty? }
      @participant.role = @participant.role.join(", ")
      @participant.video = video
      user = User.find_by_username params[:participant][:name]
      if user.present?
        @participant.user = user
        @participant.name = user.username
      end
      respond_to do |format|
        if @participant.save
          format.html { redirect_to video_url(@participant.video) }
          format.js { render @participant }
        else
          format.html { redirect_to video_url(@participant.video) }
          format.js { render :partial => "form", :status => 403 }
        end
      end
    else
      flash[:error] = "Funktion nicht erlaubt."
      redirect_to video
    end
  end

  def update
    @participant.update_attributes(params[:participant])
    render @participant
  end

  def destroy
    @video = @participant.video
    if true
      if @participant.destroy
        redirect_to @video
      else
        render :new
      end
    else
       flash[:error] = "Funktion nicht erlaubt"
       redirect_to @video
    end
  end

  private

  def find_participant
    @participant = Participant.find params[:id]
  end
end
