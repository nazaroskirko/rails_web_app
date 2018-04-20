Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]



StripeEvent.configure do |events|
  events.subscribe 'charge.failed' do |event|
    print event.data.object
  end

  events.subscribe 'customer.subscription.created' do |event|
    print event.data.object
  end

  events.all do |event|

  end
end
