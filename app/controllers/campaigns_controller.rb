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
    @campaign = Campaign.new(full_campaign_params)

    if @campaign.save
      render json: @campaign
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    binding.pry
    if @campaign.update(full_campaign_params)
      head :ok
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  def send_campaign
    binding.pry
    campaign = Campaign.find_by_campaign_name(params["campaign_name"])
    subject = campaign.email_subject
    body = campaign.email_body

    response = CampaignMailer.send_mail(params['recipient_ids'], subject, body)
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

    def full_campaign_params
      hash = campaign_params
      hash["recipient_ids"] = params["campaign"]["recipient_ids"]
      hash
    end

    def campaign_params
      params.require(:campaign).permit(:campaign_name, :email_subject, :email_body, :sent, :recipient_ids)
    end
end
