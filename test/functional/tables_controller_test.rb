require File.dirname(__FILE__) + '/../test_helper'
require 'tables_controller'

# Re-raise errors caught by the controller.
class TablesController; def rescue_action(e) raise e end; end

class TablesControllerTest < Test::Unit::TestCase
  fixtures :tables

  def setup
    @controller = TablesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = tables(:first).id
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

    assert_not_nil assigns(:tables)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:table)
    assert assigns(:table).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:table)
  end

  def test_create
    num_tables = Table.count

    post :create, :table => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_tables + 1, Table.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:table)
    assert assigns(:table).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Table.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Table.find(@first_id)
    }
  end
end
