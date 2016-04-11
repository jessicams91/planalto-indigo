class CardsController < ApplicationController
  before_action :set_card, only: [:show]

  def show
  end

  def index
    @cards = Card.all.order(:expansion_id)
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
