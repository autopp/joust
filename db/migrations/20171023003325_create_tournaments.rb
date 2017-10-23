Hanami::Model.migration do
  change do
    create_table :tournaments do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      column :name, String, null: false
      column :finished_count, Integer, null: false, default: 0
      column :total_vp_used, TrueClass, null: false, default: true
      column :rank_history_used, TrueClass, null: false, default: true
    end
  end
end
