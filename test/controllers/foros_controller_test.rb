# frozen_string_literal: true

require 'test_helper'

class ForosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @foro = foros(:one)
  end

  test 'should get index' do
    get foros_url
    assert_response :success
  end

  test 'should get new' do
    get new_foro_url
    assert_response :success
  end

  test 'should create foro' do
    assert_difference('Foro.count') do
      post foros_url, params: { foro: { description: @foro.description, title: @foro.title } }
    end

    assert_redirected_to foro_url(Foro.last)
  end

  test 'should show foro' do
    get foro_url(@foro)
    assert_response :success
  end

  test 'should get edit' do
    get edit_foro_url(@foro)
    assert_response :success
  end

  test 'should update foro' do
    patch foro_url(@foro), params: { foro: { description: @foro.description, title: @foro.title } }
    assert_redirected_to foro_url(@foro)
  end

  test 'should destroy foro' do
    assert_difference('Foro.count', -1) do
      delete foro_url(@foro)
    end

    assert_redirected_to foros_url
  end
end
