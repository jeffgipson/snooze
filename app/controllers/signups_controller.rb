class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :edit, :update, :destroy]

  @token = ''
  @user_id = ''

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
    @token = body['data']['token']
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

    # @u = params[:username]
    # @p = params[:password]
# Login as SuperAdmin
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
    @token = body['data']['token']

# Rails local signup
    respond_to do |format|
      if @signup.save
        format.html { redirect_to @signup, notice: 'Signup was successfully created.' }
        format.json { render :show, status: :created, location: @signup }
      else
        format.html { render :new }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
# Create User
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
    request["authorization"] = @token
    email = @signup.email
    first_name = @signup.first_name
    last_name = @signup.last_name
    # password = @signup.password
    request.body = "{\"identity\":{\"email\":\"#{email}\",\"firstName\":\"#{first_name}\",\"lastName\":\"#{last_name}\"}}"
    # ,\"password\":\"#{password}\"
    @response = http.request(request)
    # puts @response.read_body
    body = JSON.parse(@response.read_body)
    @user_id = body['data']['id']
# Adds user to group
    require 'uri'
    require 'net/http'
    require 'openssl'

    url1 = URI("https://api.openpath.com/orgs/3240/groups/11796/users/#{@user_id}")

    http1 = Net::HTTP.new(url1.host, url1.port)
    http1.use_ssl = true
    http1.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request1 = Net::HTTP::Put.new(url1)
    request1["authorization"] = @token

    response1 = http1.request(request1)
    puts response1.read_body
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
