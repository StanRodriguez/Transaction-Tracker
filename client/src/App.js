import React, { Component } from "react";
import "./App.css";
import axios from "axios";
import HeaderComponent from "./components/HeaderComponent/HeaderComponent";
import Transaction from "./components/Transaction/Transaction";
import { Container, Dimmer, Loader } from "semantic-ui-react";

import { Cookies } from "react-cookie";
import TransactionForm from "./components/TransactionForm/TransactionForm";
const cookies = new Cookies();
const csrftoken = cookies.get("csrftoken");

class App extends Component {
  state = {
    user: {},
    transactions: {},
    isLoaded: false,
    message: ""
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
    try {
      const response = await axios({
        method: "delete",
        url: `/user/${this.state.user.id}/transaction/delete/${id}`,

        headers: { "X-CSRFToken": csrftoken }
      });
      response.data[0] > 0
        ? this.setState({ message: "Transaction deleted successfully." })
        : this.setState({
            message: "Something went wrong trying to delete. Try again."
          });

      this.getTransactions(this.state.user.id);
      console.log(response);
    } catch (error) {
      console.error("Error ocurred trying to delete: ", error);
    }
  };
  handleDelete = e => {
    e.preventDefault();
    window.confirm("Are you sure?") && this.delete(e.target.value);
  };

  render() {
    const { user, transactions } = this.state;

    return this.state.isLoaded ? (
      <Container fluid textAlign="center">
        <HeaderComponent username={user.username} balance={user.balance} />
        <TransactionForm />
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
      <Dimmer active inverted>
        <Loader inverted content="Loading" />
      </Dimmer>
    );
  }
}

export default App;
