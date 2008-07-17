class TablesController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
#    @table_pages, @tables = paginate :tables, :per_page => 10
    
     
     if(params[:letter] != nil)
          @tables = Table.find_by_sql ["SELECT t.* from tables t where t.name like ?", "#{params[:letter]}%"]
     else
          @table_pages = Paginator.new( self, Table.count, 100, params[:page])
          @tables = Table.find( :all,
          			       :limit => @table_pages.items_per_page,
                                :order => "name",
          				  :offset => @table_pages.current.offset)
     end
  end

  def search
     @table_pages = Paginator.new( self, Table.count, 50, params[:page])
     @tables = Table.find( :all,
                           :conditions => ["name = ?", params[:table][:name]],
     			       :limit => @table_pages.items_per_page,
     				  :offset => @table_pages.current.offset)
  
  end

  def show
     if(params[:type] == 'NAME')
          @table = Table.find_by_name(params[:id])
     else
          @table = Table.find(params[:id])
     end
     @parents = TableTrees.find_parents(@table.id)
     @parent_col_size = (@parents.size + 1) / 3
     
     @children = TableTrees.find_children(@table.id)
     @child_col_size = (@children.size + 1) / 4
     
     @table_indexes = IndexSeries.find_index_for(@table.id)
     
     @columns = Column.find_all_by_tables_id(@table.id)
     
     if(@child_col_size <= 0)
          @child_col_size = 1
     end
     if(@parent_col_size <= 0)
          @parent_col_size = 1
     end
  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new(params[:table])
    if @table.save
      flash[:notice] = 'Table was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @table = Table.find(params[:id])
  end

  def update
    @table = Table.find(params[:id])
    if @table.update_attributes(params[:table])
      flash[:notice] = 'Table was successfully updated.'
      redirect_to :action => 'show', :id => @table
    else
      render :action => 'edit'
    end
  end

  def destroy
    Table.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
