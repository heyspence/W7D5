class SessionsController < ApplicationController
    before_action :require_logged_in, only:[:destroy]
    before_action :require_logged_out, only:[:create, :new]

    def create
        user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if user
            login(user)
            redirect_to users_url
        else
            flash.now[:errors] = ["Invalid login credentials"]
            @user = User.new(email: params[:user][:email])
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def destroy
        logout
        redirect_to new_session_url
    end
end
