Rails.application.routes.draw do
	root 'main#view'
	get 'index', to: 'main#view'
end

