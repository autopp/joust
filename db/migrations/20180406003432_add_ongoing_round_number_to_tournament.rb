Hanami::Model.migration do
  change do
    add_column :tournaments, :ongoing_round_number, Integer
  end
end
