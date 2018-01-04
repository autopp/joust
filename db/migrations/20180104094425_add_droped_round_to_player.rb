Hanami::Model.migration do
  change do
    add_column :players, :droped_round, Integer
  end
end
