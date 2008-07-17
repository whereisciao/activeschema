class IndexSeriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @index_series_pages, @index_series = paginate :index_series, :per_page => 10
  end

  def show
    @index_series = IndexSeries.find(params[:id])
  end

  def new
    @index_series = IndexSeries.new
  end

  def create
    @index_series = IndexSeries.new(params[:index_series])
    if @index_series.save
      flash[:notice] = 'IndexSeries was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @index_series = IndexSeries.find(params[:id])
  end

  def update
    @index_series = IndexSeries.find(params[:id])
    if @index_series.update_attributes(params[:index_series])
      flash[:notice] = 'IndexSeries was successfully updated.'
      redirect_to :action => 'show', :id => @index_series
    else
      render :action => 'edit'
    end
  end

  def destroy
    IndexSeries.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
