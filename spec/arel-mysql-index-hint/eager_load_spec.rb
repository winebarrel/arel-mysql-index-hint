describe "arel-mysql-index-hint" do
  describe "#eager_load" do
    context "when single index" do
      subject do
        User.
          eager_load(:microposts).
          where(microposts: {id: 1}).
          hint(microposts: {index_microposts_on_user_id_and_created_at: hint_type}).
          to_sql.gsub(/\s+/, " ")
      end

      let(:sql) do
        "SELECT `users`.`id` AS t0_r0, `users`.`name` AS t0_r1, `users`.`email` AS t0_r2, `users`.`created_at` AS t0_r3, `users`.`updated_at` AS t0_r4, `users`.`password_digest` AS t0_r5, `users`.`remember_token` AS t0_r6, `users`.`admin` AS t0_r7, `microposts`.`id` AS t1_r0, `microposts`.`content` AS t1_r1, `microposts`.`user_id` AS t1_r2, `microposts`.`created_at` AS t1_r3, `microposts`.`updated_at` AS t1_r4 " +
        "FROM `users` " +
        "LEFT OUTER JOIN `microposts` " +
        "#{hint_type.to_s.upcase} INDEX (`index_microposts_on_user_id_and_created_at`) " +
        "ON `microposts`.`user_id` = `users`.`id` " +
        "WHERE `microposts`.`id` = 1"
      end

      let(:hint_type) { :force }

      it { is_expected.to eq sql }
    end

    context "when multiple indexes" do
      subject do
        User.
          eager_load(:microposts).
          where(microposts: {id: 1}).
          hint(
            users: {index_users_on_email: hint_type},
            microposts: {index_microposts_on_user_id_and_created_at: hint_type},
          ).
          to_sql.gsub(/\s+/, " ")
      end

      let(:sql) do
        "SELECT `users`.`id` AS t0_r0, `users`.`name` AS t0_r1, `users`.`email` AS t0_r2, `users`.`created_at` AS t0_r3, `users`.`updated_at` AS t0_r4, `users`.`password_digest` AS t0_r5, `users`.`remember_token` AS t0_r6, `users`.`admin` AS t0_r7, `microposts`.`id` AS t1_r0, `microposts`.`content` AS t1_r1, `microposts`.`user_id` AS t1_r2, `microposts`.`created_at` AS t1_r3, `microposts`.`updated_at` AS t1_r4 " +
        "FROM `users` " +
        "#{hint_type.to_s.upcase} INDEX (`index_users_on_email`) " +
        "LEFT OUTER JOIN `microposts` " +
        "#{hint_type.to_s.upcase} INDEX (`index_microposts_on_user_id_and_created_at`) " +
        "ON `microposts`.`user_id` = `users`.`id` " +
        "WHERE `microposts`.`id` = 1"
      end

      let(:hint_type) { :force }

      it { is_expected.to eq sql }
    end
  end
end
