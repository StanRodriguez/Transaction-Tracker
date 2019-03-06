import React from "react";
import "./SignUp.css";

const SignUp = ({ user, handleChangeLogIn, handleSubmitSignup }) => {
  return (
    <form className="ui form signup-form" onSubmit={handleSubmitSignup}>
      <h4 className="ui dividing header">Sign Up</h4>
      <div className="field">
        <input
          type="text"
          value={user.first_name}
          onChange={handleChangeLogIn}
          name="first_name"
          placeholder="First Name"
        />
      </div>
      <div className="field">
        <input
          type="text"
          value={user.last_name}
          onChange={handleChangeLogIn}
          name="last_name"
          placeholder="Last Name"
        />
      </div>
      <div className="field">
        <input
          type="email"
          value={user.email}
          onChange={handleChangeLogIn}
          required
          name="email"
          placeholder="Email"
        />
      </div>
      <div className="field">
        <input
          type="text"
          required
          value={user.username}
          onChange={handleChangeLogIn}
          name="username"
          placeholder="Username"
        />
      </div>
      <div className="field">
        <input
          type="password"
          name="password"
          onChange={handleChangeLogIn}
          value={user.password}
          placeholder="Password"
        />
      </div>
      <div className="field">
        <input
          type="password"
          name="repeat_password"
          onChange={handleChangeLogIn}
          value={user.repeat_password}
          placeholder="Repeat password"
        />
      </div>
      <div className="field">
        <button className="ui button secondary">Sign Up</button>
      </div>
    </form>
  );
};
export default SignUp;
