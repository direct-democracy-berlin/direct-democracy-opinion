# frozen_string_literal: true

class ThesesController < ApplicationController
  def index
    @theses = Thesis.all
  end

  def show
    @thesis = Thesis.find(params[:id])
    @vote = Vote.find_by thesis: @thesis, user: current_user
    render 'results' if @vote
  end

  def my_own
    @theses = Thesis.of_user(current_user)
  end

  def show_voted
    @theses = Thesis.voted_by(current_user)
    render 'index'
  end

  def show_of_tags
    if params[:tag]
      @tags = Tag.includes(:theses).where(name: params[:tag].split(','))
      @theses = Thesis.joins(:taggings).where(taggings: { tag: @tags }).distinct
    else
      @theses = Thesis.all
    end
    #@theses = Thesis.joins(taggings: :tag).where(taggings: { tag: { name: params[:tag].split(',') }}).distinct
    render 'index'
  end

  def new
    @thesis = Thesis.new
  end

  def edit
    @thesis = Thesis.find(params[:id])
    render 'new'
  end

  def update
    @thesis = Thesis.find(params[:id])
    if @thesis.update(thesis_params)
      redirect_to @thesis
    else
      render 'edit'
    end
  end

  def create
    @thesis = Thesis.new(thesis_params)
    @thesis.creator = current_user
    if @thesis.save
      redirect_to @thesis
    else
      render 'new'
    end
  end

  def destroy
    @thesis = Thesis.find(params[:id])
    @thesis.destroy
    redirect_to theses_path
  end

  def results
    @thesis = Thesis.find(params[:id])
    @vote = Vote.find_by thesis: @thesis, user: current_user
  end

  def random
    offset = rand(Thesis.count)
    if params[:current]
      offset = -1
      results = Thesis.where.not(id: params[:current].to_i)
    else
      results = Thesis
    end
    id = results.offset(offset).pluck(:id).first
    redirect_to thesis_path(id: id)
  end

  private

  def thesis_params
    params.require(:thesis).permit(:title, :description, :all_tags)
  end
end
