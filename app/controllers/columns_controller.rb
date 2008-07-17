class ColumnsController < ApplicationController
  in_place_edit_for :column, :description

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @column_pages, @columns = paginate :columns, :per_page => 10
  end

  def show
    @column = Column.find(params[:id])
  end

  def new
    @column = Column.new
  end

  def create
    @column = Column.new(params[:column])
    if @column.save
      flash[:notice] = 'Column was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @column = Column.find(params[:id])
  end

  def sort
     case(params[:type])
          when /0/
               @columns = Column.find_all_by_tables_id(params[:id])
          
          when /1/
               @columns = Column.find_all_by_tables_id(params[:id], :order => "name ASC")
          
          when /2/
               @columns = Column.find_all_by_tables_id(params[:id], :order => "name DESC")
          when /3/
               @columns = Column.find_all_by_tables_id(params[:id], :order => "code_value DESC, name DESC")
     end
     render(:partial => "/columns/show_col")
  end

  def update
    @column = Column.find(params[:id])
    if @column.update_attributes(params[:column])
      flash[:notice] = 'Column was successfully updated.'
      redirect_to :action => 'show', :id => @column
    else
      render :action => 'edit'
    end
  end

  def destroy
    Column.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
