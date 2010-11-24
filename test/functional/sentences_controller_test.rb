require 'test_helper'

class SentencesControllerTest < ActionController::TestCase
  setup do
    @sentence = sentences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sentences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sentence" do
    assert_difference('Sentence.count') do
      post :create, :sentence => @sentence.attributes
    end

    assert_redirected_to sentence_path(assigns(:sentence))
  end

  test "should show sentence" do
    get :show, :id => @sentence.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sentence.to_param
    assert_response :success
  end

  test "should update sentence" do
    put :update, :id => @sentence.to_param, :sentence => @sentence.attributes
    assert_redirected_to sentence_path(assigns(:sentence))
  end

  test "should destroy sentence" do
    assert_difference('Sentence.count', -1) do
      delete :destroy, :id => @sentence.to_param
    end

    assert_redirected_to sentences_path
  end
end
