module Admin
  class GeneralContentsController < AdminsController
    before_action :set_executive_member, only: [:show, :edit, :update, :destroy]

    def index
      @general_contents = GeneralContent.all
    end

    def show
    end

    def edit
    end

    def new
      @executive_team = GeneralContent.new
    end

    def create
      @executive_team = GeneralContent.new(executive_team_params)
      if @executive_team.save
        redirect_to admin_team_edit_path(@executive_team)
        flash[:success] = 'Team member created.'
      else
        render 'new'
      end
    end

    def update
      if @executive_team.update(executive_team_params)
        redirect_to admin_team_edit_path(@executive_team)
        flash[:success] = 'Saved'
      else
        render 'edit'
      end
    end

    def destroy
      @executive_team.destroy
      flash[:success] = 'Deleted.'
      redirect_to :back
    end

    private
    def executive_team_params
      params.require(:executive_team).permit(:first_name, :last_name, :title, :content, :is_member)
    end

    def set_executive_member
      @executive_team = GeneralContent.find(params[:id])
    end
  end
end
















