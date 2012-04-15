# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Tabu') }
    it { should have_content('Tabu') }
    it { should have_selector('title', :text => full_title(''))}
    it { should_not have_selector('title', :text => "Strona główna") }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('pomoc') }
  end

  describe "Privacy policy" do
    before { visit privacy_path }

    it { should have_content('Polityka prywatności') }
  end

  describe "Contact page" do
    before {visit contact_path }

    it { should have_selector('h1', text: 'Kontakt') }
    it { should have_selector('title', text: full_title('Kontakt')) }
  end
end
