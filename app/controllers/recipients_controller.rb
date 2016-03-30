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
    @recipient = Recipient.new(recipient_params)

    if @recipient.save
      render json: @recipient
    else
      render json: @recipient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipients/1
  # PATCH/PUT /recipients/1.json
  def update
    if @recipient.update(recipient_params)
      render json: @recipient
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

    def recipient_params
      #use new method in AMS10.0rc4 to deserialize JSONAPI
      # and then transform keys to underscores
      deserialized_hash = ActiveModelSerializers::Deserialization.jsonapi_parse(params.to_unsafe_h)
      deserialized_hash.transform_keys! {|key| key.to_s.underscore}
    end
end
