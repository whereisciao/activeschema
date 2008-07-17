class TableTreesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @table_trees_pages, @table_trees = paginate :table_trees, :per_page => 10
  end

  def show
    @table_trees = TableTrees.find(params[:id])
  end

  def new
    @table_trees = TableTrees.new
  end

  def create
    @table_trees = TableTrees.new(params[:table_trees])
    if @table_trees.save
      flash[:notice] = 'TableTrees was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @table_trees = TableTrees.find(params[:id])
  end

  def update
    @table_trees = TableTrees.find(params[:id])
    if @table_trees.update_attributes(params[:table_trees])
      flash[:notice] = 'TableTrees was successfully updated.'
      redirect_to :action => 'show', :id => @table_trees
    else
      render :action => 'edit'
    end
  end

  def destroy
    TableTrees.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
