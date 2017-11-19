Hanami::Model.migration do
  change do
    create_table :players do
      primary_key :id
      foreign_key :tournament_id, :tournaments, on_delete: :cascade, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      column :name, String, null: false
    end
  end
end
