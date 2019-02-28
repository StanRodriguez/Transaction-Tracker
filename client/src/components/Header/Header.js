import React from "react";
const Header = ({ balance, username }) => {
  return (
    <header>
      Welcome, {username}! your balance is ${balance}
    </header>
  );
};
export default Header;
