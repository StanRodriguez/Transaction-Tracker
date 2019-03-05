import React from "react";

const LogIn = ({ handleLogIn, handleChangeLogIn, user }) => {
  return (
    <form onSubmit={handleLogIn}>
      <input
        type="text"
        onChange={handleChangeLogIn}
        value={user.username}
        name="username"
        placeholder="Username"
      />
      <input
        type="password"
        name="password"
        value={user.password}
        onChange={handleChangeLogIn}
        placeholder="Password"
      />
      <button>LogIn</button>
    </form>
  );
};
export default LogIn;
