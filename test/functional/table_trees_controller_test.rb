require File.dirname(__FILE__) + '/../test_helper'
require 'table_trees_controller'

# Re-raise errors caught by the controller.
class TableTreesController; def rescue_action(e) raise e end; end

class TableTreesControllerTest < Test::Unit::TestCase
  fixtures :table_trees

  def setup
    @controller = TableTreesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = table_trees(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:table_trees)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:table_trees)
    assert assigns(:table_trees).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:table_trees)
  end

  def test_create
    num_table_trees = TableTrees.count

    post :create, :table_trees => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_table_trees + 1, TableTrees.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:table_trees)
    assert assigns(:table_trees).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TableTrees.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TableTrees.find(@first_id)
    }
  end
end
