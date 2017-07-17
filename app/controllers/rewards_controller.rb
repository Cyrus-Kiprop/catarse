# frozen_string_literal: true

class RewardsController < ApplicationController
  respond_to :html, :json
  helper_method :resource, :parent

  def sort
    authorize resource
    resource.update_attribute :row_order_position, params[:reward][:row_order_position]
    render nothing: true
  end

  def resource
    @reward ||= parent.rewards.find params[:id]
  end

  def parent
    @project ||= Project.find params[:project_id]
  end

  def toggle_survey_finish
    authorize resource
    survey = resource.survey
    if survey.finished_at
      survey.finished_at = nil
    elsif survey.sent_at
      survey.finished_at = Time.current
    end
    survey.save!
    return render nothing: true
  end

  def destroy
    authorize resource
    if resource.destroy!
      render status: 200, json: { success: 'OK' }
    else
      render status: 400, json: { errors_json: resource.errors.to_json }
    end
  end
end
