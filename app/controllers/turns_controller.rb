class TurnsController < ApplicationController
  before_action :set_turn, only: %i[ show edit update destroy ]

  CARD_NAMES = [ nil, nil, "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace" ]
  SUIT_NAMES = [ "spades", "hearts", "diamonds", "clubs" ]


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

    @turn.bet_type = params[:red_or_black]
    @turn.wager = params[:wager]

    # draw a card, and ensure it's unique
    @cards_so_far = @game.turns.pluck(:card)
    unique_card = false

    until unique_card
      card_value = rand(2..14)
      card_suit = rand(0..3)  # or rand(4)
      card = "#{CARD_NAMES[card_value]} #{SUIT_NAMES[card_suit]}"
      unique_card = @cards_so_far.exclude? card
    end
    @turn.card = "#{CARD_NAMES[card_value]} #{SUIT_NAMES[card_suit]}"

    case @turn.turn_number
    when 1
      is_red_card = SUIT_NAMES[card_suit].in?([ "hearts", "diamonds" ])
      player_guessed_red = params[:red_or_black] == "red"

      if (is_red_card && player_guessed_red) || (!is_red_card && !player_guessed_red)
        Rails.logger.info "You win!"
        @turn.result = "win"
      else
        Rails.logger.info "You lose!"
        @turn.result = "loss"
      end

    when 2

    when 3

    when 4

    else
        Rails.logger.info "For some reason we're not in turn 1, 2, 3, or 4..."
    end

    @game.save # I should check for errors here

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
