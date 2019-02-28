import React, { Component } from "react";
import "./App.css";
import axios from "axios";
import HeaderComponent from "./components/HeaderComponent/HeaderComponent";
import Transaction from "./components/Transaction/Transaction";
import { Container } from "semantic-ui-react";

class App extends Component {
  state = {
    user: {},
    transactions: {},
    isLoaded: false
  };
  getTransactions = async id => {
    const response = await axios(`/user/${id}/transactions/`);
    const { user, transactions } = response.data;
    this.setState({
      user,
      transactions,
      isLoaded: true
    });
  };
  componentDidMount() {
    this.getTransactions(2);
  }
  delete = async id => {
    const response = await axios({
      method: "delete",
      url: `/user/${this.state.user.id}/transaction/delete/${id}`,
      xsrfHeaderName: "X-CSRFToken"
    });
    console.log(response);
  };
  handleDelete = e => {
    e.preventDefault();
    this.delete(e.target.value);
  };
  render() {
    const { user, transactions } = this.state;

    return this.state.isLoaded ? (
      <Container fluid textAlign="center">
        <HeaderComponent username={user.username} balance={user.balance} />
        {transactions.map(transaction => {
          return (
            <Transaction
              transaction={transaction}
              handleDelete={this.handleDelete}
              key={transaction.id}
            />
          );
        })}
      </Container>
    ) : (
      <div className="is-loading">Loading...</div>
    );
  }
}

export default App;
