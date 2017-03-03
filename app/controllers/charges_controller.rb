class ChargesController < ApplicationController
  def new
     @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     #description: "BigMoney Membership - #{params[:stripeEmail]}",
     description: "BigMoney Membership - #{current_user.email}",
     amount: Amount.default
   }
end

def create
 
 
  customer = Stripe::Customer.create(
    email: current_user.email,
    source: params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: Amount.default,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
  )
  
  change_plan(current_user)


 flash[:notice] = "Thanks for upgrading, #{current_user.email}!"

 #redirect_to charge_thanks_path(current_user)
  redirect_to wikis_path

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end

def destroy
  change_plan(current_user)
  flash[:alert] = "Your plan has been downgraded, #{current_user.email}."
  redirect_to wikis_path
  #redirect_to charge_goodbye_path(current_user)
end


private

class Amount
  def self.default
    return 500
  end
end

end
