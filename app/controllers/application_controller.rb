class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    # this makes it reject HTTP requests that are coming from somewhere besides my domain
    # all forms have a special token that is automatically included, which my app decrypts
    # any request not from my site wouldn't have that token
end
