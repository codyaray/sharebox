require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Folder.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Folder.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Folder.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to folder_url(assigns(:folder))
  end

  def test_edit
    get :edit, :id => Folder.first
    assert_template 'edit'
  end

  def test_update_invalid
    Folder.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Folder.first
    assert_template 'edit'
  end

  def test_update_valid
    Folder.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Folder.first
    assert_redirected_to folder_url(assigns(:folder))
  end

  def test_destroy
    folder = Folder.first
    delete :destroy, :id => folder
    assert_redirected_to folders_url
    assert !Folder.exists?(folder.id)
  end
end
