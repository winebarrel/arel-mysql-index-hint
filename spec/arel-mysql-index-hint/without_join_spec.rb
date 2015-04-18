describe "arel-mysql-index-hint" do
  describe "#all" do
    subject do
      User.
        all.
        hint(users: {index_users_on_email: hint_type}).
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

  describe "call nothing" do
    subject do
      User.
        hint(users: {index_users_on_email: hint_type}).
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

  describe "#limit" do
    subject do
      User.
        limit(1).
        hint(users: {index_users_on_email: hint_type}).
        to_sql
    end

    let(:sql) do
      "SELECT  `users`.* " +
      "FROM `users` " +
      "#{hint_type} INDEX (index_users_on_email)  " +
      "LIMIT 1"
    end

    let(:hint_type) { :force }

    it { is_expected.to eq sql }
  end

  describe "#first" do
    subject do
      User.
        hint(users: {index_users_on_email: hint_type}).
        first
    end

    let(:sql) do
      "SELECT  `users`.* FROM `users` " +
      "#{hint_type} INDEX (index_users_on_email)   " +
      "ORDER BY `users`.`id` ASC " +
      "LIMIT 1"
    end

    let(:hint_type) { :force }

    it do
      subject

      expect(sql_log).to include sql
    end
  end

  describe "#take" do
    subject do
      User.
        hint(users: {index_users_on_email: hint_type}).
        take
    end

    let(:sql) do
      "SELECT  `users`.* FROM `users` " +
      "#{hint_type} INDEX (index_users_on_email)  " +
      "LIMIT 1"
    end

    let(:hint_type) { :force }

    it do
      subject

      expect(sql_log).to include sql
    end
  end
end
