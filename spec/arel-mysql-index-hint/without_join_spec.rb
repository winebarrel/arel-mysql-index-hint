describe "arel-mysql-index-hint" do
  describe "#all" do
    subject do
      User.
        all.
        hint(users: {hint_type => :index_users_on_email}).
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

  describe "call nothing" do
    subject do
      User.
        hint(users: {hint_type => :index_users_on_email}).
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

  describe "#limit" do
    subject do
      User.
        limit(1).
        hint(users: {hint_type => :index_users_on_email}).
        to_sql.gsub(/\s+/, " ")
    end

    let(:sql) do
      "SELECT `users`.* " +
      "FROM `users` " +
      "#{hint_type.to_s.upcase} INDEX (`index_users_on_email`) " +
      "LIMIT 1"
    end

    let(:hint_type) { :force }

    it { is_expected.to eq sql }
  end

  describe "#first" do
    subject do
      User.
        hint(users: {hint_type => :index_users_on_email}).
        first
    end

    let(:sql) do
      "SELECT `users`.* FROM `users` " +
      "#{hint_type.to_s.upcase} INDEX (`index_users_on_email`) " +
      "ORDER BY `users`.`id` ASC " +
      "LIMIT 1"
    end

    let(:hint_type) { :force }

    it do
      subject
      expect(sql_log.first).to eq sql
    end
  end

  describe "#take" do
    subject do
      User.
        hint(users: {hint_type => :index_users_on_email}).
        take
    end

    let(:sql) do
      "SELECT `users`.* FROM `users` " +
      "#{hint_type.to_s.upcase} INDEX (`index_users_on_email`) " +
      "LIMIT 1"
    end

    let(:hint_type) { :force }

    it do
      subject
      expect(sql_log.first).to eq sql
    end
  end
end
