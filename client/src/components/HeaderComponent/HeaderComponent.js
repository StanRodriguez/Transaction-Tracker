import React from "react";
import "./HeaderComponent.css";
const HeaderComponent = ({ balance, username }) => {
  return (
    <header className="header">
      <h3>Welcome, {username}!</h3> <h3> Balance: ${balance}</h3>
    </header>
  );
};
export default HeaderComponent;
