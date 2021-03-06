class PostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy, :show]
  before_action :correct_user, only: :destroy
  
  def create
    @post = current_user.posts.build(post_params)
    # store money values in minor units
    if @post.hourly_payment
      @post.hourly_payment *= 100
    end
    
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      # reset hourly payment when an error happened
      if @post.hourly_payment
        @post.hourly_payment /= 100
      end
      
      @feed_items = []
      render 'static_pages/home'
    end
    
  end

  def destroy
    
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referer || root_url
  end

  def show
    @post = Post.find(params[:id])
    if @post.hourly_payment
      @post.hourly_payment /= 100
    end
    @user = current_user
  end
  

  # TODO: add test if address belongs to user on change
  

  private

  def post_params
    params.require(:post).permit(:content_type,
                                 :channel,
                                 :billing_type,
                                 :scope_hours,
                                 :title,
                                 :remarks,
                                 :scope_of_work,
                                 :scope_of_experience,
                                 :start_date,
                                 :end_date,
                                 :hourly_payment,
                                 :currency,
                                 :anonymous,
                                 :address_id,
                                 :picture,
                                 :document)
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
  
end
