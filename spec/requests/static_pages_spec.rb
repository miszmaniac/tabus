# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Strona główna'" do
      visit '/static_pages/home'

      page.should have_content('Strona główna')
    end
    it "should have the title 'tabu" do
      visit '/static_pages/home'
      page.should have_selector('title',
                                :text => "Strona główna")
    end
  end
  describe "Help page" do

    it "should have the content 'Pomoc'" do
      visit '/static_pages/help'
      page.should have_content('pomoc')
    end
  end
  describe "Privacy policy" do

    it "should have the content 'polityka prywatnosci'" do
      visit '/static_pages/privacy'
      page.should have_content('Polityka prywatności')
    end
  end
end
