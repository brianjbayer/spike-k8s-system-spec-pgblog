# Specifies user sees Hello Rails on home page

require 'rails_helper'

RSpec.describe 'Hello Rails', type: :system do
  context 'when user visits the Home Page...' do
    before(:each) do
      # visit '/welcome/index/'
      visit '/'
    end
    it { expect(page).to have_text('Hello, Rails!') }
  end
end
