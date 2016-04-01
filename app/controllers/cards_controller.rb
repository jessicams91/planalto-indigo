class CardsController < ApplicationController
  before_action :set_card, only: [:show]

  def show
  end

  def index
    @cards = Card.all
  end

  def import
    Card.import(params[:file])
    redirect_to root_url, notice: "Cards imported."
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

end
