require 'test_helper'

class Test01sControllerTest < ActionController::TestCase
  setup do
    @test01 = test01s(:one)
  end

#  test "should get index" do
#    puts "\nget_index"
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:test01s)
#  end

#  test "should get new" do
#    puts "\nget_new"
#    get :new
#    assert_response :success
#  end

  test "should create test01" do
    puts "\ncreate"
    puts "\nCount: #{Test01.count}"
    assert_difference('Test01.count') do
      post :create, test01: { price: @test01.price, title: 'PIPPO' }
    end
    
    assert_redirected_to test01_path(assigns(:test01))
    puts "\nCount: #{Test01.count}"      
  end

#  test "should show test01" do
#    puts "\nshow"
#    get :show, id: @test01
#    assert_response :success
#  end

#  test "should get edit" do
#    puts "\nget_edit"
#      get :edit, id: @test01
#    assert_response :success
#  end

#  test "should update test01" do
#    puts "\nupdate"
#    patch :update, id: @test01, test01: { price: @test01.price, title: @test01.title }
#    assert_redirected_to test01_path(assigns(:test01))
#  end

#  test "should destroy test01" do
#    puts "\ndestroy"
#    assert_difference('Test01.count', -1) do
#      delete :destroy, id: @test01
#    end
#
#    assert_redirected_to test01s_path
#  end
  
  
end
