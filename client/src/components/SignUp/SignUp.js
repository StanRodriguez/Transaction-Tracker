import React from "react";
import "./SignUp.css";

const SignUp = ({ SignUpUser, handleChangeSignUp, handleSubmitSignup }) => {
  return (
    <form className="ui form signup-form" onSubmit={handleSubmitSignup}>
      <h4 className="ui dividing header">Sign Up</h4>
      <div className="field">
        <input
          type="text"
          value={SignUpUser.first_name}
          onChange={handleChangeSignUp}
          name="first_name"
          placeholder="First Name"
        />
      </div>
      <div className="field">
        <input
          type="text"
          value={SignUpUser.last_name}
          onChange={handleChangeSignUp}
          name="last_name"
          placeholder="Last Name"
        />
      </div>
      <div className="field">
        <input
          type="email"
          value={SignUpUser.email}
          onChange={handleChangeSignUp}
          required
          name="email"
          placeholder="Email"
        />
      </div>
      <div className="field">
        <input
          type="text"
          required
          value={SignUpUser.username}
          onChange={handleChangeSignUp}
          name="username"
          placeholder="Username"
        />
      </div>
      <div className="field">
        <input
          type="password"
          name="password"
          onChange={handleChangeSignUp}
          value={SignUpUser.password}
          placeholder="Password"
        />
      </div>
      <div className="field">
        <input
          type="password"
          name="repeat_password"
          onChange={handleChangeSignUp}
          value={SignUpUser.repeat_password}
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
