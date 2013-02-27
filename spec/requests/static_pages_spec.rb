require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the h1 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text =>'Home')
    end
    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "Ruby on Rails Tutorial - Sample App | Home")
    end
    describe "Help Page" do
      it "should have the h1 'Help'" do
        visit '/static_pages/help'
        page.should have_selector('h1', :text =>'Help')
      end
      it "should have the right title" do
        visit '/static_pages/help'
        page.should have_selector('title', :text => "Ruby on Rails Tutorial - Sample App | Help")
      end
    end
    describe "About Page" do
      it "should have the h1 'About us'" do
        visit '/static_pages/about'
        page.should have_selector('h1', :text =>'About Us')
      end
      it "should have the right title" do
        visit '/static_pages/about'
        page.should have_selector('title', :text => "Ruby on Rails Tutorial - Sample App | About")
      end      
    end
  end
end

