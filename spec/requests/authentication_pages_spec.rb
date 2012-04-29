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
        it { should_not have_error_message() }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before {valid_signin(user)}

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Użytkownicy',    href: usersindex_path) }
      it { should have_link('Ustawienia', href: edit_user_path(user)) }
      it { should have_link('Wyloguj', href: signout_path) }
      it { should_not have_link('Zaloguj', href: signin_path) }
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user)
            fill_in "Email",    with: user.email
            fill_in "Hasło", with: user.password
            click_button "Zaloguj"
          end

          describe "after signing in" do

            it "should render the desired protected page" do
              page.should have_selector('title', text: 'Edytuj')
            end
          end
        end

        describe "in the Microposts controller" do

          describe "submitting to the create action" do
            before { post microposts_path }
            specify { response.should redirect_to(signin_path) }
          end

          describe "submitting to the destroy action" do
            before do
              micropost = FactoryGirl.create(:micropost)
              delete micropost_path(micropost)
            end
            specify { response.should redirect_to(signin_path) }
          end
        end
      end

      describe "visiting the user index" do
        before { visit users_path }
        it { should have_selector('title', text: 'Logowanie') }
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edytuj')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end

  describe "as non-admin user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:non_admin) { FactoryGirl.create(:user) }

    before { sign_in non_admin }

    describe "submitting a DELETE request to the Users#destroy action" do
      before { delete user_path(user) }
      specify { response.should redirect_to(root_path) }
    end
  end


end