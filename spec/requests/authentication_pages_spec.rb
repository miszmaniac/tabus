# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Logowanie') }
    it { should have_selector('title', text: 'Logowanie') }

    describe "with invalid information" do
      before { click_button "Zaloguj" }

      it { should have_selector('title', text: 'Logowanie') }
      it { should have_error_message('Nieprawidłowy') }
      it { should_not have_link('Profil') }

      describe "after visiting another page" do
        before { click_link "Strona główna" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before {valid_signin(user)}

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Wyloguj', href: signout_path) }
      it { should_not have_link('Zaloguj', href: signin_path) }
    end
  end


end