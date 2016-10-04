class UserMailer < MandrillMailer::TemplateMailer
  default from: 'purnima.sharma@berylsystems.com'
  default from_name: 'Purnima'



  def send_mail(company_id)
    company = Company.find_by(id: company_id)
    template = "welcome"
    subject = "Welcome"
    mandrill_mail(
      template: template,
      subject: subject,
      to: "purnima.s250@gmail.com",
      vars: {
        'NAME' => company.name
      },
      important: true,
      inline_css: true,
    )
  end
end
