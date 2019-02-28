import React from "react";
import { Header } from "semantic-ui-react";
const HeaderComponent = ({ balance, username }) => {
  return (
    <Header>
      Welcome, {username}! your balance is ${balance}
    </Header>
  );
};
export default HeaderComponent;
