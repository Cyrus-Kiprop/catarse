class MigrateNotificationsTemplateNameToContribution < ActiveRecord::Migration
  TEMPLATE_NAMES = [ [:backer_confirmed_after_project_was_closed, :contribution_confirmed_after_project_was_closed],
                     [:backer_project_successful, :contribution_project_successful],
                     [:backer_project_unsuccessful, :contribution_project_unsuccessful],
                     [:confirm_backer, :confirm_contribution],
                     [:pending_backer_project_unsuccessful, :pending_contribution_project_unsuccessful],
                     [:project_owner_backer_confirmed, :project_owner_contribution_confirmed],
                     [:backer_canceled_after_confirmed, :contribution_canceled_after_confirmed] ]
  def up
    TEMPLATE_NAMES.each do |t|
      execute "UPDATE notifications SET template_name = '#{t[1]}' WHERE notifications.template_name = '#{t[0]}'"
    end
  end

  def down
    TEMPLATE_NAMES.each do |t|
      execute "UPDATE notifications SET template_name = '#{t[0]}' WHERE notifications.template_name = '#{t[1]}'"
    end
  end
end
