class ExpansionsController < ApplicationController
  before_action :set_expansion, only: [:show]
  def index
    Expansion.all
  end

  def import
    begin
      # Expansion.import(params[:file])
      Expansion.import
      redirect_to root_url, notice: "Expansions imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end

  def show
  end

  private

  def set_expansion
    @expansion = Expansion.find(params[:id])
  end
end
