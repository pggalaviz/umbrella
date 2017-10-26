defmodule Herps.Messenger.Email.ConfirmAccount do
  import Bamboo.Email
  alias Herps.Messenger.Mailer

  def send(user, url) do
    email = new_email()
    |> to(user.email)
    |> from("no-reply@herpkeepers.com")
    |> subject("Welcome to Herp Keepers!")
    |> put_header("X-Cmail-GroupName", "Account Confirmation")
    |> html_body(
        "<h1>Hi #{user.first_name}, thanks for joining Herp Keepers!</h1>
        <p>Please click the link below to complete your registration:</p>
        <p>#{url}</p>
        <p><small>If you don't click the link your account won't be created, you can always register again.</small></p>"
      )
    |> text_body(
        "
        Hi #{user.first_name}, thanks for joining Herp Keepers!\n
        Please click the link below to complete your registration:\n
        #{url}\n
        This link will be active for several minutes, if you don't click it your account won't be created. You can always register again.
        "
      )

    Mailer.deliver_later(email)
  end

end
