require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Strona glowna'" do
      visit '/static_pages/home'

      page.should have_content('Strona glowna')
    end
  end
  describe "Help page" do

    it "should have the content 'Pomoc'" do
      visit '/static_pages/help'
      page.should have_content('pomoc')
    end
  end
end
