class AddressesController < ApplicationController
  before_action :logged_in_user
  
  
  def index
    @user = current_user
    @addresses = @user.addresses.paginate(page: params[:page])
    # For address form builder
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      flash[:success] = "Address created"
    
    end
    redirect_to addresses_url
    
  end

  def update

  end
  
  def destroy
    
    Address.find(params[:id]).destroy
    flash[:success] = "Address deleted"
    redirect_to addresses_url
  end

  private
  
  def address_params
    params.require(:address).permit(:company,
                                   :street_name,
                                   :street_no,
                                   :zip,
                                   :city,
                                   :phone,
                                   :email,
                                   :contact_person,
                                   :vat_no,
                                   :country_iso_code,
                                   :website,
                                   :state,
                                   :headcount,
                                   :scope_of_experience,
                                   :scope_of_work,
                                   :display)
  end
  
end

