require 'spec_helper'

describe UsersController do

  before :all do
    register_changeable_user
  end

  describe "routing" do
    it "routes to #new" do
      expect(:get => "/sign_up").to route_to(
             :controller => "users",
             :action => "new"
      )
    end
  end

  describe "updating a user's information" do
    it "updates email address" do
      user = User.find_by(:email => "confused@example.com")
      user.update(:email => "fools@example.com")
      expect(user.email).to eq("fools@example.com")
    end
  end

  describe "new session" do
    it "sets session[:user_id] for valid user" do
      User.create!(:email => "simon@example.com", :full_name => "yep",
                   :password => "foobar", :password_confirmation => "foobar")
      user = User.authenticate("simon@example.com", "foobar")
      user.should_not be_nil
    end
  end

end
