defmodule Ragball.TestFactories do
  def valid_user_params do
    %{
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com"
    }
  end
end
