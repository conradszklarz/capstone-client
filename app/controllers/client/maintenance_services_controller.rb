class Client::MaintenanceServicesController < ApplicationController
  def index
    client_params = {
                     search: params[:search],
                     sort_by: params[:sort_by],
                     sort_order: params[:sort_order],
                     category: params[:category]
                    }
    response = Unirest.get(
                           "http://localhost:3000/api/maintenance_services",
                           parameters: client_params
                           )
    @maintenance_services = response.body
    render 'index.html.erb'
  end

  def new
    @maintenance_service = {}
    render 'new.html.erb'
  end

  def create
    @maintenance_service = {
                   'maintenance_event_id' => params[:maintenance_event_id],
                   'service_id' => params[:service_id]
                   }

    response = Unirest.post(
                            "http://localhost:3000/api/maintenance_services",
                            parameters: @maintenance_service
                            )

    if response.code == 200
      flash[:success] = "Successfully Created Maintenance Service"
      redirect_to "/client/maintenance_services/"
    elsif response.code == 401
      flash[:warning] = "You Are Not Authorized To Make A Maintenance Service"
      redirect_to "/"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    maintenance_service_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/maintenance_services/#{maintenance_service_id}")
    @maintenance_service = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/maintenance_services/#{params[:id]}")
    @maintenance_service = response.body
    render 'edit.html.erb'
  end

  def update
    @maintenance_service = {
                   'maintenance_event_id' => params[:maintenance_event_id],
                   'service_id' => params[:service_id]
                  }

    response = Unirest.patch(
                            "http://localhost:3000/api/maintenance_services/#{params[:id]}",
                            parameters: @maintenance_service
                            )

    if response.code == 200
      flash[:success] = "Successfully Updated Maintenance Service"
      redirect_to "/client/maintenance_services/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/maintenance_services/#{params['id']}")
    if response.code == 200
      flash[:success] = "Successfully Destroyed Maintenance Service"
      redirect_to "/client/maintenance_services"
    else
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    end
  end
end
