# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
Rails.application.config.assets.precompile += %w( dialog.ie.css )
Rails.application.config.assets.precompile += %w( backend.js )
Rails.application.config.assets.precompile += %w( backend.css )
Rails.application.config.assets.precompile += %w( users.coffee )
Rails.application.config.assets.precompile += %w( password_confirmation.js )
Rails.application.config.assets.precompile += %w( static_pages.coffee )
Rails.application.config.assets.precompile += %w( sessions.coffee )
Rails.application.config.assets.precompile += %w( todo_lists.js )
Rails.application.config.assets.precompile += %w( calendars.js )
Rails.application.config.assets.precompile += %w( pages/css/calendar.css )
Rails.application.config.assets.precompile += %w( jquery.menuclipper.css )
Rails.application.config.assets.precompile += %w( js/*.js)
Rails.application.config.assets.precompile << 'blog.css'
Rails.application.config.assets.precompile += %w( practices.css )
Rails.application.config.assets.precompile += %w(account_activations.js application.js
appointments.js
backend.js
bank_accounts.js
blog.js
cable.js
calendars.js
charges.js
comments.js
conversations.js
dashboards.js
days.js
external.js
invitation.js
invoices.js
marketplaces.js
messages.js
modernizr.custom.js
pages.calendar.js
pages.email.js.erb
pages.min.js
password_confirmation.js
password_resets.js
posts.js
practices.js
profiles.js
relationships.js
reminders.js
resources.js
sessions.js
static_pages.js
stripe_handler.js
subscriptions.js
todo.js
todo_items.js
todo_lists.js
user_complaints.js
users.js)
