defmodule RestApi.AdminTest do
  use RestApi.DataCase

  alias RestApi.Admin

  describe "users" do
    alias RestApi.Admin.User

    import RestApi.AdminFixtures

    @invalid_attrs %{email: nil, name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Admin.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Admin.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", name: "some name"}

      assert {:ok, %User{} = user} = Admin.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", name: "some updated name"}

      assert {:ok, %User{} = user} = Admin.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_user(user, @invalid_attrs)
      assert user == Admin.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Admin.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Admin.change_user(user)
    end
  end

  describe "clocks" do
    alias RestApi.Admin.Clock

    import RestApi.AdminFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Admin.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Admin.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2023-10-23 08:30:00]}

      assert {:ok, %Clock{} = clock} = Admin.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2023-10-23 08:30:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2023-10-24 08:30:00]}

      assert {:ok, %Clock{} = clock} = Admin.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2023-10-24 08:30:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_clock(clock, @invalid_attrs)
      assert clock == Admin.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Admin.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Admin.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias RestApi.Admin.Workingtime

    import RestApi.AdminFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Admin.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Admin.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{end: ~N[2023-10-23 08:30:00], start: ~N[2023-10-23 08:30:00]}

      assert {:ok, %Workingtime{} = workingtime} = Admin.create_workingtime(valid_attrs)
      assert workingtime.end == ~N[2023-10-23 08:30:00]
      assert workingtime.start == ~N[2023-10-23 08:30:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{end: ~N[2023-10-24 08:30:00], start: ~N[2023-10-24 08:30:00]}

      assert {:ok, %Workingtime{} = workingtime} = Admin.update_workingtime(workingtime, update_attrs)
      assert workingtime.end == ~N[2023-10-24 08:30:00]
      assert workingtime.start == ~N[2023-10-24 08:30:00]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Admin.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Admin.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Admin.change_workingtime(workingtime)
    end
  end
end
