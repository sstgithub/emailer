class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.all
    render json: @campaigns
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    render json: @campaign
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      render json: @campaign
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    if @campaign.update(campaign_params)
      render json: @campaign
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  def send_campaign
    subject = campaign_params["email_subject"]
    body = campaign_params["email_body"]

    response = CampaignMailer.send_mail(campaign_params["recipient_ids"], subject, body)
    render json: response
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def campaign_params
      #use new method in AMS10.0rc4 to deserialize JSONAPI
      # and then transform keys to underscores
      deserialized_hash = ActiveModelSerializers::Deserialization.jsonapi_parse(params.to_unsafe_h)
      deserialized_hash.transform_keys! {|key| key.to_s.underscore}
    end
end
