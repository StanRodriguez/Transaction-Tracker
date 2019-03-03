import React, { Component } from "react";
import "./App.css";
import axios from "axios";
import HeaderComponent from "./components/HeaderComponent/HeaderComponent";
import Transaction from "./components/Transaction/Transaction";
import {
  Container,
  Dimmer,
  Loader,
  Icon,
  Button,
  Transition
} from "semantic-ui-react";

import { Cookies } from "react-cookie";
import TransactionForm from "./components/TransactionForm/TransactionForm";
import { actualDateTimeInput } from "./helperFunctions/formatTime";

const cookies = new Cookies();
const csrftoken = cookies.get("csrftoken");

class App extends Component {
  state = {
    user: {},
    transactions: [],
    transaction: {
      date: actualDateTimeInput(),
      amount: "",
      isExpense: true,
      description: "",
      comment: ""
    },
    isLoaded: false,
    message: "",
    isFormVisible: false
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
  handleFormVisibility = e => {
    this.setState(prevState => {
      return {
        isFormVisible: !prevState.isFormVisible
      };
    });
  };
  handleAmount = (amount, isExpense = null) => {
    isExpense =
      isExpense === null ? this.state.transaction.isExpense : isExpense;
    amount = parseFloat(amount);
    return isExpense ? Math.abs(amount) * -1 : Math.abs(amount);
  };

  handleChange = e => {
    let { name, value } = e.target;
    value = name === "amount" ? this.handleAmount(value) : value;
    if (name === "isExpense") {
      let { amount } = this.state.transaction;
      amount = this.handleAmount(amount, value);
      this.setState(prevState => {
        return {
          transaction: {
            ...prevState.transaction,
            amount,
            [name]: value
          }
        };
      });
    } else {
      this.setState(prevState => {
        return {
          transaction: {
            ...prevState.transaction,
            [name]: value
          }
        };
      });
    }
  };
  formatToSend = () => {
    const { transaction } = this.state;
    return transaction.date.split("T");
  };

  post = async () => {
    const { transaction, user } = this.state;
    const [date, time] = this.formatToSend();
    console.log(this.state.transaction);

    const response = axios({
      method: "post",
      url: `user/${user.id}/transaction/post/`,
      data: { ...transaction, date, time },
      headers: { "X-CSRFToken": csrftoken }
    });
  };
  handleSubmit = e => {
    e.preventDefault();

    this.post();
  };
  render() {
    const {
      user,
      transactions,
      isLoaded,
      isFormVisible,
      transaction
    } = this.state;

    return isLoaded ? (
      <Container fluid textAlign="center">
        <HeaderComponent username={user.username} balance={user.balance} />
        <Button icon onClick={(onclick, e => this.handleFormVisibility(e))}>
          <Icon name={isFormVisible ? "minus" : "plus"} />
        </Button>

        <Transition.Group duration={20} animation="scale">
          {isFormVisible && (
            <TransactionForm
              transaction={transaction}
              handleSubmit={this.handleSubmit}
              handleChange={this.handleChange}
            />
          )}
        </Transition.Group>

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
