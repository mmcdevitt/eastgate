class StaticPagesController < ApplicationController
	layout :layout
	
  def index
  end

  def test
  end

  private
  def layout
  	"static_pages"
  end
end
