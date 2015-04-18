describe "arel-mysql-index-hint" do
  context "unnested hint" do
    subject do
      User.
        hint(index_users_on_email: hint_type).
        to_sql
    end

    let(:sql) do
      "SELECT `users`.* " +
      "FROM `users` " +
      "#{hint_type} INDEX (index_users_on_email)"
    end

    let(:hint_type) { :force }

    it { is_expected.to eq sql }
  end
end
