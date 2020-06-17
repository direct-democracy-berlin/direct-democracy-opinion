class VotesController < ApplicationController
  def index
    @theses = Thesis.joins(:votes).where(votes: {user: current_user})
    render controller: :thesis, action: 'index'
  end

  def vote
    @thesis = Thesis.find(params[:thesis])
    vote = Vote.create!(thesis: @thesis, user: current_user, vote: params[:vote])
    #@thesis.cast_vote! vote # added as callback
    redirect_to results_thesis_path(@thesis)
  end
end