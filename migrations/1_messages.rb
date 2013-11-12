Sequel.migration do
  change do
    create_table(:messages) do
      primary_key :id
      String :channel, :size=>255
      String :nick, :size=>255
      String :message, :size=>255
      DateTime :created
      TrueClass :normal
    end
  end
end
