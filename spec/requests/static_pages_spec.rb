require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Tabu'" do
      visit '/static_pages/home'

      page.should have_content('Strona glowna')
    end
  end
end
