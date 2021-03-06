describe "arel-mysql-index-hint" do
  describe "#preload" do
    subject do
      User.
        where(id: 1).
        preload(:microposts).
        hint(users: {hint_type => :index_users_on_email}).
        to_sql.gsub(/\s+/, " ")
    end

    let(:sql) do
      "SELECT `users`.* " +
      "FROM `users` " +
      "#{hint_type.to_s.upcase} INDEX (`index_users_on_email`) " +
      "WHERE `users`.`id` = 1"
    end

    let(:hint_type) { :force }

    it { is_expected.to eq sql }
  end
end
