Hanami::Model.migration do
  change do
    create_table :rounds do
      primary_key :id
      foreign_key :tournament_id, :tournaments, on_delete: :cascade, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      column :number, Integer, null: false
    end
  end
end
