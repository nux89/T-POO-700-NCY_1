defmodule RestApiWeb.Auth.Pipeline do
use Guardian.Plug.Pipeline, otp_app: :rest_api,
module: RestApiWeb.Auth.Guardian,
error_handler: RestApiWeb.Auth.GuardianErrorHandler

plug Guardian.Plug.VerifySession
plug Guardian.Plug.VerifyHeader
plug Guardian.Plug.EnsureAuthenticated
plug Guardian.Plug.LoadResource
end
