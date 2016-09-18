class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      # 17/09/2016 switch followed/all posts
      if params['filter'] == "all"
        @feed_items = Post.all.paginate page: params[:page]
      else
        @feed_items = current_user.feed.paginate page: params[:page]
      end
    end
    
  end

  def help
  end

  def about
  end

  def contact
  end

  def tac
  end
  
end
