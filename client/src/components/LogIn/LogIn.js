import React from "react";
import "./LogIn.css";

const LogIn = ({ handleSubmitLogIn, handleChangeLogIn, user }) => {
  return (
    <div className="ui segment raised login-form">
      <form className="ui form" onSubmit={handleSubmitLogIn}>
        <div className="inline fields">
          <div className="field">
            <input
              type="text"
              onChange={handleChangeLogIn}
              value={user.username}
              name="username"
              placeholder="Username"
            />
          </div>
          <div className="field">
            <input
              type="password"
              name="password"
              value={user.password}
              onChange={handleChangeLogIn}
              placeholder="Password"
            />
          </div>
          <div className="field">
            <button className="ui button primary">Log In</button>
          </div>
        </div>
      </form>
    </div>
  );
};
export default LogIn;
