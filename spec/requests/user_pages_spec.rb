# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Załóż konto') }
    it { should have_selector('title', text: full_title('Załóż konto')) }

    let(:submit) { "Załóż konto" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "has error message" do
        before { click_button submit }

        it { should have_selector('title', text: 'Załóż konto') }
        it { should have_content("error") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Login", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Hasło", with: "foobar"
        fill_in "Powtórz hasło", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: User.name) }
        it { should have_selector('div.alert.alert-success', text: 'Witamy') }
      end
    end


  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    # Code to make a user variable
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }

    it { should have_selector('title', text: user.name) }
  end
end
