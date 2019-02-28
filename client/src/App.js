import React, { Component } from "react";
import "./App.css";
import axios from "axios";
import Header from "./components/Header/Header";
import Transaction from "./components/Transaction/Transaction";

class App extends Component {
  state = {
    user: {},
    transactions: {},
    isLoaded: false
  };
  async componentDidMount() {
    const response = await axios("/transaction/" + 2);
    const { user, transactions } = response.data;
    this.setState({
      user,
      transactions,
      isLoaded: true
    });
  }
  render() {
    const { user, transactions } = this.state;

    return this.state.isLoaded ? (
      <div className="App">
        <Header username={user.username} balance={user.balance} />
        {transactions.map(transaction => {
          return <Transaction transaction={transaction} key={transaction.id} />;
        })}
      </div>
    ) : (
      <div className="is-loading">Loading...</div>
    );
  }
}

export default App;
