# Specifies user sees Hello Rails on home page

require 'rails_helper'

RSpec.describe 'Testing gets, non-gui system specs', type: :system do
  
  before do
    app_host=Capybara.app_host
    get "#{app_host}/welcome/index"
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns Hello, Rails in response' do
    expect(response.body).to have_text('Hello, Rails!')
  end
end
