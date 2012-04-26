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
        it { should have_selector('div.alert.alert-success', text: 'Witaj w Tabus!') }
        it { should have_link('Wyloguj') }
      end

      describe "followed by signout" do
        before { click_link :singout }
        it { should have_link('Zaloguj') }
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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Edytuj dane użytkownika") }
      it { should have_selector('title', text: "Edytuj dane użytkownika") }
      it { should have_link('Zmień', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Zapisz" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Hasło",         with: user.password
        fill_in "Potwierdź hasło", with: user.password
        click_button "Zapisz"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Wyloguj', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit usersindex_path
    end

    it { should have_selector('title', text: 'Użytkownicy') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
  end

  describe "delete links" do

    it { should_not have_link('Usuń') }

    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit usersindex_path
      end

      #it { should have_link('Usuń', href: user_path(User.first)) }
      it "should be able to delete another user" do
        #expect { click_link('Usuń') }.to change(User, :count).by(-1)
      end
      it { should_not have_link('Usuń', href: user_path(admin)) }
    end
  end
end
