# This migration comes from spree (originally 20230322085416)
class RemoveMatchPolicyFromSpreePromotion < ActiveRecord::Migration[5.2]
  def change
    remove_column :spree_promotions, :match_policy, :string, default: "all"
  end
end
