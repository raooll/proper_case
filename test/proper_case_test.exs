defmodule ProperCaseTest do
  use ExUnit.Case, async: true

  test ".to_camel_case converts a maps key to `camelCase`" do
    incoming = %{ "user" => %{ "first_name" => "Han", "last_name" => "Solo",
        "allies_in_combat" => [
          %{"name" => "Luke", "weapon_of_choice" => "lightsaber"},
          %{"name" => "Chewie", "weapon_of_choice" => "bowcaster"},
          %{"name" => "Leia", "weapon_of_choice" => "blaster"}
        ]
      }
    }
    expected = %{
      "user" => %{
        "firstName" => "Han",
        "lastName" => "Solo",
        "alliesInCombat" => [
          %{"name" => "Luke", "weaponOfChoice" => "lightsaber"},
          %{"name" => "Chewie", "weaponOfChoice" => "bowcaster"},
          %{"name" => "Leia", "weaponOfChoice" => "blaster"}
        ]
      }
    }

    assert ProperCase.to_camel_case(incoming) === expected
  end

  test ".to_camel_case treats non-Enumerable structs as plain values" do
    epoch = Ecto.DateTime.from_unix!(0, :microseconds)
    incoming = %{ "unix_epoch" => epoch }
    expected = %{ "unixEpoch" => epoch }

    assert ProperCase.to_camel_case(incoming) === expected
  end

  test ".camel_case_key camel cases a string" do
    assert ProperCase.camel_case("chewie_were_home") === "chewieWereHome"
  end

  test ".camel_case_key ignores leading underscore" do
    assert ProperCase.camel_case("_boba_fett_where") === "_bobaFettWhere"
    assert ProperCase.camel_case("__boba_fett_where") === "__bobaFettWhere"
  end

  test ".camel_case_key converts an atom to a string and camel cases it" do
    assert ProperCase.camel_case(:no_i_am_your_father) === "noIAmYourFather"
  end

  test ".to_snake_case converts map keys to `snake_case`" do
    expected_params = %{
      "user" => %{
        "first_name" => "Han",
        "last_name" => "Solo",
        "allies_in_combat" => [
          %{"name" => "Luke", "weapon_of_choice" => "lightsaber"},
          %{"name" => "Chewie", "weapon_of_choice" => "bowcaster"},
          %{"name" => "Leia", "weapon_of_choice" => "blaster"}
        ]
      }
    }
    incoming_params = %{"user" => %{
        "firstName" => "Han",
        "lastName" => "Solo",
        "alliesInCombat" => [
          %{"name" => "Luke", "weaponOfChoice" => "lightsaber"},
          %{"name" => "Chewie", "weaponOfChoice" => "bowcaster"},
          %{"name" => "Leia", "weaponOfChoice" => "blaster"}
        ]
      }
    }
    assert ProperCase.to_snake_case(incoming_params) === expected_params
  end

  test ".snake_case converts a string to `snake_case`" do
    assert ProperCase.snake_case("getToDaChoppa") === "get_to_da_choppa"
  end

  test ".snake_case converts an atom to snake_case string" do
    assert ProperCase.snake_case(:getToDaChoppa) === "get_to_da_choppa"
  end

end
