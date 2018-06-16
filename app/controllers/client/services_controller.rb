class Client::ServicesController < ApplicationController
  def index
    client_params = {
                     search: params[:search],
                     sort_by: params[:sort_by],
                     sort_order: params[:sort_order],
                     category: params[:category]
                    }
    response = Unirest.get(
                           "http://localhost:3000/api/services",
                           parameters: client_params
                           )
    @services = response.body
    render 'index.html.erb'
  end

  def new
    @service = {}
    render 'new.html.erb'
  end

  def create
    @service = {
                   'name' => params[:name],
                   'mileage_marker' => params[:mileage_marker],
                   'time_marker' => params[:time_marker],
                   'time_increment' => params[:time_increment]
                  }

    response = Unirest.post(
                            "http://localhost:3000/api/services",
                            parameters: @service
                            )

    if response.code == 200
      flash[:success] = "Successfully Created Service"
      redirect_to "/client/services/"
    elsif response.code == 401
      flash[:warning] = "You Are Not Authorized To Make A Service"
      redirect_to "/"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    service_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/services/#{service_id}")
    @service = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/services/#{params[:id]}")
    @service = response.body
    render 'edit.html.erb'
  end

  def update
    @service = {
                   'id' => params[:id],
                   'name' => params[:name],
                   'mileage_marker' => params[:mileage_marker],
                   'time_marker' => params[:time_marker],
                   'time_increment' => params[:time_increment]
                   }

    response = Unirest.patch(
                            "http://localhost:3000/api/services/#{params[:id]}",
                            parameters: @service
                            )

    if response.code == 200
      flash[:success] = "Successfully updated service"
      redirect_to "/client/services/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/services/#{params['id']}")
    if response.code == 200
      flash[:success] = "Successfully destroyed service"
      redirect_to "/client/services"
    else
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    end
  end
end
