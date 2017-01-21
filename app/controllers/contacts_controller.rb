
class ContactsController < ApplicationController

  def create
    from = current_user
    post = Post.find params[:post_id]
    to = User.find post.user_id
    
    mail = UserMailer.contact_request(from, to, post, params["message"])
    if mail.deliver_now
      flash[:info] = t(:controller_contacts_flash_info)
      redirect_to post
    else
      flash[:error] = t(:controller_contacts_flash_error)
      redirect_to post
    end
  end

  
  private

  def contact_params
    params.require(:contact).permit(:post_id,
                                    :message)
  end
    
end
