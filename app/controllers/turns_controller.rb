class TurnsController < ApplicationController
  before_action :set_turn, only: %i[ show edit update destroy ]

  # GET /turns or /turns.json
  def index
    @turns = Turn.all
  end

  # GET /turns/1 or /turns/1.json
  def show
  end

  # GET /turns/new
  def new
    @turn = Turn.new
  end

  # GET /turns/1/edit
  def edit
  end

  # POST /turns or /turns.json
  def create
    @game = Game.find(params[:game_id])  # Get game from nested route
    @turn = @game.turns.build(turn_params)  # Associate with game

    @turn.turn_number = @game.current_turn
    @game.current_turn += 1
    @game.save

    respond_to do |format|
      if @turn.save
        format.html { redirect_to @game, notice: "Turn was successfully created." }
        format.json { render :show, status: :created, location: @turn }
      else
        format.html { redirect_to @game, alert: "Error creating turn" }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turns/1 or /turns/1.json
  def update
    respond_to do |format|
      if @turn.update(turn_params)
        format.html { redirect_to @turn, notice: "Turn was successfully updated." }
        format.json { render :show, status: :ok, location: @turn }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turns/1 or /turns/1.json
  def destroy
    @turn.destroy!

    respond_to do |format|
      format.html { redirect_to turns_path, status: :see_other, notice: "Turn was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def turn_params
      params.require(:turn).permit(:game_id, :bet_type, :wager, :result, :card)
    end
end
