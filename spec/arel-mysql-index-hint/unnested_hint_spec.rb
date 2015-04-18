describe "arel-mysql-index-hint" do
  context "unnested hint" do
    subject do
      User.
        hint(hint_type => :index_users_on_email).
        to_sql.gsub(/\s+/, " ")
    end

    let(:sql) do
      "SELECT `users`.* " +
      "FROM `users` " +
      "#{hint_type.to_s.upcase} INDEX (`index_users_on_email`)"
    end

    let(:hint_type) { :force }

    it { is_expected.to eq sql }
  end
end
