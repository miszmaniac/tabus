# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading) { 'Tabu' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: 'Strona główna | ' }

    it "should have the right links on the layout" do
      visit root_path

      click_link "O stronie"
      page.should have_selector 'title', text: full_title('O stronie')
    end
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading) { 'Pomoc' }
    let(:page_title) { 'Pomoc' }

    it_should_behave_like "all static pages"
  end

  describe "Privacy policy" do
    before { visit privacy_path }

    let(:heading) { 'Polityka prywatności' }
    let(:page_title) { 'Polityka prywatności' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before {visit contact_path }

    let(:heading) { 'Kontakt' }
    let(:page_title) { 'Kontakt' }

    it_should_behave_like "all static pages"
  end
end
