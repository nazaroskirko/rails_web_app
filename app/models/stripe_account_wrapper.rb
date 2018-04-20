class StripeAccountWrapper
  require "stripe"


  def initialize
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @stripe_account = Stripe::Account
    @stripe_cusstomer = Stripe::Customer
    @stripe_charge = Stripe::Charge
  end

  def self.retrieve_account user
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    Stripe::Account.retrieve(user.stripe_id)
  end

  def self.create_customer user, token, plan
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    response = Stripe::Customer.create(source: token, plan: plan, email: user.email)
    user.stripe_customer_token = response.id
    user.save
  end




  def self.retrieve_needed_verification_information stripe_response_json
    missing_items_array = stripe_response_json[:verification][:fields_needed]
  end

  def self.update_account user, params_list, ip_address
    account = StripeAccountWrapper.retrieve_account(user)
    possible_keys = [
      "legal_entity.type",
      "legal_entity.first_name",
      "legal_entity.last_name",
      "legal_entity.address.city",
      "legal_entity.address.line1",
      "legal_entity.address.postal_code",
      "legal_entity.address.state",
      "legal_entity.ssn_last_4",
      "legal_entity.personal_id_number",
      "legal_entity.business_name",
      "legal_entity.business_tax_id",
    ]

    tos = [
    "tos_acceptance.date",
    "tos_acceptance.ip"]

    date = [
    "legal_entity.dob.day",
    "legal_entity.dob.month",
    "legal_entity.dob.year"]
    doc=[
    "legal_entity.verification.document"
    ]

    if params_list.key? date[0]
      unless params_list[date[0]].empty?
        date_info = params_list[date[0]].split("-")
        day_keys = date[0].split('.')
        day_keys.map!(&:to_sym)
        set_account_attribute(account,day_keys, date_info[2])
        month_keys = date[1].split('.')
        month_keys.map!(&:to_sym)
        set_account_attribute(account,month_keys, date_info[1])
        year_keys = date[2].split('.')
        year_keys.map!(&:to_sym)
        set_account_attribute(account,year_keys, date_info[0])
      end
    end

    if params_list.key? tos[0]
      unless params_list[tos[0]] == false
        date_keys = tos[0].split('.')
        date_keys.map!(&:to_sym)
        set_account_attribute(account,date_keys, Time.now.to_i)
        ip_keys = tos[1].split('.')
        ip_keys.map!(&:to_sym)
        set_account_attribute(account,ip_keys, ip_address)
      end
    end


    possible_keys.each do |pk|
      if params_list.key? pk
        unless params_list[pk].empty?
          keys = pk.split('.')
          keys.map!(&:to_sym)
          set_account_attribute(account,keys, params_list[pk].downcase)
        end
      end
    end
    account.save
  end

  def self.add_external_account user
    account = StripeAccountWrapper.retrieve_account(user)
    response = account.external_accounts.create(:external_account => user.bank_account.stripe_token)
    user.stripe_bank_token = response.id
    user.save
  end

  def self.create_account user, country
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    stripe = Stripe::Account
    response = stripe.create({:country => country,:managed => true})
    user.update_attributes(stripe_id: response["id"],stripe_secret:response["keys"]["secret"],stripe_publishable:response["keys"]["publishable"])
    user.stripe_id ? response : false
  end

  def self.bill_customer patient_id, doctor_id
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    billing_rate = (User.find(doctor_id).appointment_setting.billing_rate * 100).to_i
    fee = billing_rate / 25
    charge = Stripe::Charge.create(:amount => billing_rate,:currency => "usd",:destination => User.find(doctor_id).stripe_id,:customer => User.find(patient_id).stripe_customer_token, application_fee: fee)
    return charge
  end

  def charge_guest stripe_token, doctor_id
    billing_rate = (User.find(doctor_id).appointment_setting.billing_rate * 100).to_i
    fee = billing_rate / 25
    charge = @stripe_charge.create(:amount => billing_rate,:currency => "usd",:destination => User.find(doctor_id).stripe_id,:source => stripe_token, application_fee: fee)
    return charge
  end


  private

  def self.set_account_attribute(account, keys, value)
    count = keys.length
    if count == 1
      return account[keys[0]] = value
    elsif count == 2
      return account[keys[0]][keys[1]] = value
    elsif count == 3
      return account[keys[0]][keys[1]][keys[2]] = value
    elsif count == 4
      return account[keys[0]][keys[1]][keys[2]][keys[3]]  = value
    end
  end

end
