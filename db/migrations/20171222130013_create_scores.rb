Hanami::Model.migration do
  change do
    create_table :scores do
      primary_key :id
      foreign_key :player_id, :players, on_delete: :cascade, null: false
      foreign_key :round_id, :rounds, on_delete: :cascade, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      column :table_number, Integer, null: false
      column :player_count, Integer, null: false
      column :vp_gained, Integer
      column :has_extra_turn, TrueClass
      column :rank, Integer
      column :same_ranks, Integer
    end
  end
end
