# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show edit update destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show; end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit; end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @tema = Tema.find(params[:tema_id])
    subscription_re = @tema.subscriptions.build(user_id: current_user.id)
    if subscription_re.save
      answer2(current_user, @tema)
    else
      redirect_back(fallback_location: root_path, alert: 'Subscription could not be sent.')
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    tema = @subscription.tema
    @subscription.destroy
    message = 'Subscription was successfully cancelled.'
    respond_to do |format|
      format.html { redirect_back(fallback_location: tema_path(tema), notice: message) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.fetch(:subscription, {})
  end

  def answer2(user, tema)
    message = "Subscription send for #{tema.name}."
    respond_to do |format|
      format.html { redirect_back(fallback_location: tema_path(tema), notice: message) }
      format.json do
        render json: {
          friendship: {
            name: user.name,
            id: user.id
          },
          message: "#{tema.name} have a new subscription from #{user.name}!"
        }
      end
    end
  end
end
