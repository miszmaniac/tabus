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

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 follower",  href: followers_user_path(user)) }
      end
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
