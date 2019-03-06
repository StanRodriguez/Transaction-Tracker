import React from "react";
import "./LogIn.css";

const LogIn = ({ handleSubmitLogIn, handleChangeLogIn, user }) => {
  return (
    <form className="ui form login-form" onSubmit={handleSubmitLogIn}>
      <div className="inline fields">
        <div className="field">
          <input
            className="ui input inline"
            type="text"
            onChange={handleChangeLogIn}
            value={user.username}
            name="username"
            placeholder="Username"
          />
        </div>
        <div className="field">
          <input
            className="ui input inline"
            type="password"
            name="password"
            value={user.password}
            onChange={handleChangeLogIn}
            placeholder="Password"
          />
          <button className="ui button secondary">LogIn</button>
        </div>
      </div>
    </form>
  );
};
export default LogIn;
