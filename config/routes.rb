Rails.application.routes.draw do
  resources :mailer_services
  resources :recipients
  resources :campaigns

  post "/campaigns/send_campaign"

  mount_ember_app :frontend, to: "/"
end
