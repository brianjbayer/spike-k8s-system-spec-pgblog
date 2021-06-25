require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it 'displays "Hello, Rails!" as a Heading 1' do
    render
    expect(rendered.strip).to eql('<h1>Hello, Rails!</h1>')
  end
end
