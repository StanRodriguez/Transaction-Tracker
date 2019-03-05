import React from "react";
import "./HeaderComponent.css";
const HeaderComponent = ({ balance, username, handleLogOut }) => {
  return (
    <header className="header-component">
      <h3>Welcome, {username}!</h3> <h3> Balance: ${balance}</h3>
      <button className="ui icon button" onClick={handleLogOut}>
        <i className="sign-out icon" />
      </button>
    </header>
  );
};
export default HeaderComponent;
