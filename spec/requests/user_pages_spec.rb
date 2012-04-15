# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Załóż konto') }
    it { should have_selector('title', text: full_title('Załóż konto')) }
  end
end