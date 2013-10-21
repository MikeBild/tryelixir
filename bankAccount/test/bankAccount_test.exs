defmodule BankAccountTest do
  use ExUnit.Case

  test "starts with a balance of 0" do
    account = spawn_link(BankAccount, :start, [])
    account <- {:checkBalance, self()}
    assert_receive {:ok, 0}
  end
  test "deposit 10 should return 10" do
    account = spawn_link(BankAccount, :start, [])
    account <- {:deposit, 10}
    account <- {:checkBalance, self()}
    assert_receive {:ok, 10}
  end
  test "2x deposit 10 should return 20" do
    account = spawn_link(BankAccount, :start, [])
    account <- {:deposit, 10}
    account <- {:deposit, 10}
    account <- {:checkBalance, self()}
    assert_receive {:ok, 20}
  end
  test "deposit 10 and withdraw 10 should return 0" do
    account = spawn_link(BankAccount, :start, [])
    account <- {:deposit, 10}
    account <- {:withdraw, -10}
    account <- {:checkBalance, self()}
    assert_receive {:ok, 0}
  end
end
