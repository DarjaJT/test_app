Rails.application.routes.draw do
  # get 'users/new'
  resources :users # Получаем REST-style Users URL на работу
  resources :sessions, only: [:new, :create, :destroy] # Добавление ресурса для получения стандартных RESTful действий для сессий.

  root  'static_pages#home'  # начальная страницы сайта
  match '/signup',  to: 'users#new',            via: 'get' # Страница регистрации
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
