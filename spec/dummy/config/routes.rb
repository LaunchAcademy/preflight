Rails.application.routes.draw do
  mount Preflight::Engine => "/preflight"
end
