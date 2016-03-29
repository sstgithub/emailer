class RecipientsController < ApplicationController
  before_action :set_recipient, only: [:show, :edit, :update, :destroy]

  # GET /recipients
  # GET /recipients.json
  def index
    @recipients = Recipient.all
    render json: @recipients
  end

  # GET /recipients/1
  # GET /recipients/1.json
  def show
    render json: @recipient
  end

  # GET /recipients/1/edit
  def edit
  end

  # POST /recipients
  # POST /recipients.json
  def create
    @recipient = Recipient.new(full_recipient_params)

    if @recipient.save
      render json: @recipient
    else
      render json: @recipient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipients/1
  # PATCH/PUT /recipients/1.json
  def update
    if @recipient.update(full_recipient_params)
      head :ok
    else
      render json: @recipient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipients/1
  # DELETE /recipients/1.json
  def destroy
    @recipient.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipient
      @recipient = Recipient.find(params[:id])
    end

    def full_recipient_params
      hash = recipient_params
      hash["campaign_ids"] = params["recipient"]["campaign_ids"]
      hash
    end

    # def campaign_ids
    #   params["data"]["relationships"]["campaigns"]["data"].map {|campaign| campaign["id"]}
    # end

    def recipient_params
      # params.require(:data)
      #     .require(:attributes)
      #     .permit(:first_name, :"last_name", :"email_address", :"sent", :"salutation")
      params.require(:recipient).permit(:first_name, :last_name, :email_address, :salutation, :campaign_ids)
    end
end
