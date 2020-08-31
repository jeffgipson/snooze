class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :edit, :update, :destroy]

  # GET /signups
  # GET /signups.json
  def index
    @signups = Signup.all
  end

  def login
  end

  def dashboard
    @u = params[:username]
    @p = params[:password]

    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json'

    url = URI("https://api.openpath.com/auth/login")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request.body = "{\"email\":\"jeff@recruiterswebsites.com\",\"password\":\"Placement123\"}"

    @response = http.request(request)
    puts @response.read_body

    body = JSON.parse(@response.read_body)
    token = body['data']['token']
  end

  # GET /signups/1
  # GET /signups/1.json
  def show
  end

  # GET /signups/new
  def new
    @signup = Signup.new


  end

  # GET /signups/1/edit
  def edit
  end

  # POST /signups
  # POST /signups.json
  def create
    @signup = Signup.new(signup_params)

    respond_to do |format|
      if @signup.save
        format.html { redirect_to @signup, notice: 'Signup was successfully created.' }
        format.json { render :show, status: :created, location: @signup }
      else
        format.html { render :new }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end

    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://api.openpath.com/orgs/3240/users")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGl0eUlkIjoxMjg5Mjk0LCJybmQiOjAuNDM1NTUwNzIwNTYyMTg4OSwiaWF0IjoxNTk4OTA3MDU2LCJleHAiOjE2MDAxMTY2NTZ9.ap_OhXF64qVVAFrYvsWvIcXqgCPklTU0Cy2M_9vgnZA '
    request.body = "{\"identity\":{\"email\":\"jeff@yahoo.com\",\"firstName\":\"Jeff\",\"lastName\":\"Gipson\",\"password\":\"password123\"}}"

    @response = http.request(request)
    # puts @response.read_body

  end

  # PATCH/PUT /signups/1
  # PATCH/PUT /signups/1.json
  def update
    respond_to do |format|
      if @signup.update(signup_params)
        format.html { redirect_to @signup, notice: 'Signup was successfully updated.' }
        format.json { render :show, status: :ok, location: @signup }
      else
        format.html { render :edit }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signups/1
  # DELETE /signups/1.json
  def destroy
    @signup.destroy
    respond_to do |format|
      format.html { redirect_to signups_url, notice: 'Signup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      @signup = Signup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def signup_params
      params.require(:signup).permit(:first_name, :last_name, :email, :address, :address2, :city, :state, :zip, :phone, :photo_id, :selfie)
    end
end
