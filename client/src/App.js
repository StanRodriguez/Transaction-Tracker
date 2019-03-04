import React, { Component } from "react";
import "./App.css";
import Axios from "axios";
import HeaderComponent from "./components/HeaderComponent/HeaderComponent";
import Transaction from "./components/Transaction/Transaction";
import {
  Container,
  Dimmer,
  Loader,
  Icon,
  Button,
  Transition,
  Message
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
      id: "",
      amount: "",
      is_expense: true,
      description: "",
      comment: ""
    },
    isLoaded: false,
    message: {
      text: "",
      code: 0
    },
    isFormVisible: false
  };
  getTransactions = async id => {
    const response = await Axios(`/user/${id}/transactions/`);
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
      const response = await Axios({
        method: "delete",
        url: `/user/${this.state.user.id}/transaction/${id}/delete`,

        headers: { "X-CSRFToken": csrftoken }
      });
      response.data[0] > 0
        ? this.setState({
            message: {
              text: "Transaction deleted successfully.",
              code: "positive"
            }
          })
        : this.setState({
            message: {
              text: "Something went wrong trying to delete. Try again.",
              code: "negative"
            }
          });

      window.scrollTo(0, 0);

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
  handleAmount = (amount, is_expense = null) => {
    is_expense =
      is_expense === null ? this.state.transaction.is_expense : is_expense;
    amount = parseFloat(amount);
    return is_expense ? Math.abs(amount) * -1 : Math.abs(amount);
  };

  handleChange = e => {
    let { name, value } = e.target;
    value = name === "amount" ? this.handleAmount(value) : value;
    if (name === "is_expense") {
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

    const response = await Axios({
      method: "post",
      url: `user/${user.id}/transaction/post/`,
      data: { ...transaction, date, time },
      headers: { "X-CSRFToken": csrftoken }
    });
    console.log(response.data.id);
    response.data.id
      ? this.setState({
          transaction: {
            date: actualDateTimeInput(),
            amount: "",
            is_expense: true,
            description: "",
            comment: ""
          },
          message: {
            text: "Transaction created successfully",
            code: "positive"
          }
        })
      : this.setState({
          transaction: {
            date: actualDateTimeInput(),
            amount: "",
            is_expense: true,
            description: "",
            comment: ""
          },
          message: {
            text: "There was a problem trying to create",
            code: "negative"
          }
        });
  };
  put = () => {
    const response = Axios.put("");
  };
  handleSubmit = e => {
    e.preventDefault();
    e.target.id.value ? this.post() : this.update();
    // e.target.id
    // this.post();
  };
  // handleDetailsClick = async id => {
  //   const response = await Axios.get(
  //     `user/${this.state.user.id}/transaction/${id}/details/`
  //   );
  //   console.log(response.data);

  //   this.setState({
  //     transaction: {
  //       ...response.data
  //     }
  //   });
  // };
  handleEdit = transaction => {
    const { date, time } = transaction;
    console.log(`${date}T${time}`);

    this.setState({
      transaction: { ...transaction, date: `${date}T${time}` },
      isFormVisible: true
    });
  };
  render() {
    // console.log(this.state.transaction);

    const {
      user,
      transactions,
      isLoaded,
      isFormVisible,
      transaction,
      message
    } = this.state;

    return isLoaded ? (
      <Container fluid textAlign="center">
        <HeaderComponent username={user.username} balance={user.balance} />
        {message.text ? (
          <div className="message-div">
            <Message
              positive={message.code === "positive" ? true : false}
              negative={message.code === "negative" ? true : false}
            >
              <Message.Header>{message.text}</Message.Header>
            </Message>
          </div>
        ) : (
          ""
        )}

        <Button icon onClick={(onclick, e => this.handleFormVisibility(e))}>
          <Icon name={isFormVisible ? "minus" : "plus"} />
        </Button>

        {isFormVisible && (
          <TransactionForm
            transaction={transaction}
            handleSubmit={this.handleSubmit}
            handleChange={this.handleChange}
          />
        )}

        {transactions.map(transaction => {
          return (
            <Transaction
              // handleDetailsClick={this.handleDetailsClick}
              handleEdit={this.handleEdit}
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
