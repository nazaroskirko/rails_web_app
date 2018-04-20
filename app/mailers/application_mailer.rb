class ApplicationMailer < ActionMailer::Base
  default from: 'Patient Notes <dan@patientnotes.co>'
  layout 'mailer'
end
