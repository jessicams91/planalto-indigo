class CardsController < ApplicationController
  before_action :set_card, only: [:show]

  def show
    @prices = CardPrice.where(card: @card).order(:price)
    @expansion = @card.expansion
  end

  def index
    @cards = Card.all.order(:expansion_id).order(:id)
    @prices = CardPrice.all
  end

  def import
    begin
      Card.import(params[:file])
      redirect_to root_url, notice: "Cards imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end
end
