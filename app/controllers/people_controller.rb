class PeopleController < ApplicationController
  def show
    @person = Person.find_by_username(params[:username])
    @videos = @person.videos.order("created_at desc").page(params[:page]).per_page(3)
    render 'videos/index'
  end
end
