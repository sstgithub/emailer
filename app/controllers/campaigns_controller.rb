class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

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

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_campaign
    campaign = Campaign.find_by_campaign_name(params["campaign_name"])
    subject = campaign.email_subject
    body = campaign.email_body
    # recipient = Recipient.find(params['recipient_ids'].first)
    # response = CampaignMailer.send_mail(recipient, subject, body)

    response = CampaignMailer.send_mail(params['recipient_ids'], subject, body)
    render json: response
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:campaign_name, :email_subject, :email_body)
    end
end
