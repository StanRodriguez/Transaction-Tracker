import React, { Component } from "react";
import "./App.css";
import Axios from "axios";
import HeaderComponent from "./components/HeaderComponent/HeaderComponent";
import Transaction from "./components/Transaction/Transaction";
import { Dimmer, Loader, Icon, Button, Message } from "semantic-ui-react";
import "semantic-ui-css/semantic.min.css";

import { Cookies } from "react-cookie";
import TransactionForm from "./components/TransactionForm/TransactionForm";
import {
  actualDateTimeInput,
  todayDateOnly,
  dateAgo
} from "./helperFunctions/formatTime";
import LogIn from "./components/LogIn/LogIn";

const cookies = new Cookies();
const csrftoken = cookies.get("csrftoken");

class App extends Component {
  state = {
    user: {
      id: 0,
      username: "",
      password: "",
      balance: 0
    },
    isLoggedIn: false,
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
    dateFilter: [
      { key: "TO", text: "Today", value: todayDateOnly() },
      { key: "TR", text: "Three days ago", value: dateAgo(3) },
      {
        key: "WE",
        text: "A week ago",
        value: dateAgo(7)
      },
      {
        key: "FI",
        text: "Two weeks ago",
        value: dateAgo(15)
      },
      {
        key: "MO",
        text: "A month ago",
        value: dateAgo(30)
      },
      {
        key: "SM",
        text: "Six Months ago",
        value: dateAgo(183)
      },
      {
        key: "YE",
        text: "A year ago",
        value: dateAgo(365)
      }
    ],
    filter: dateAgo(3),
    isFormVisible: false,
    isOnline: false
  };
  getTransactions = async (
    id,
    fromDate = dateAgo(3),
    toDate = todayDateOnly()
  ) => {
    if (navigator.onLine) {
      const response = await Axios(
        `/user/${id}/transactions/date/from/${fromDate}/to/${toDate}`
      );
      const { transactions } = response.data;
      this.setState({
        transactions,
        isLoaded: true
      });
      localStorage.setItem("transactions", JSON.stringify(transactions));
    } else {
      const transactions = JSON.parse(localStorage.getItem("transactions"));

      this.setState({
        transactions,
        isLoaded: true,
        message: {
          text:
            "You are currently offline. You are in read-only mode. Make sure you are online and reload.",
          code: "negative"
        }
      });
    }
  };

  componentDidMount() {
    const user = JSON.parse(sessionStorage.getItem("user"));
    if (user) {
      this.setState(prevState => {
        return {
          user: {
            ...user,
            password: prevState.user.password
          },
          isLoggedIn: true
        };
      });
      this.getTransactions(user.id);
    }
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
    const message = response.data.id
      ? {
          text: "Transaction created successfully",
          code: "positive"
        }
      : {
          text: "There was a problem trying to create",
          code: "negative"
        };
    this.setState({
      transaction: {
        id: "",
        date: actualDateTimeInput(),
        amount: "",
        is_expense: true,
        description: "",
        comment: ""
      },
      message,
      isFormVisible: false
    });
    this.getTransactions(this.state.user.id);
  };
  put = async () => {
    const { transaction } = this.state;
    const [date, time] = this.formatToSend();
    const response = await Axios.put(
      `user/${this.state.user.id}/transaction/${transaction.id}/put/`,
      { ...transaction, date, time },
      { headers: { "X-CSRFToken": csrftoken } }
    );

    const message = response.data.id
      ? { text: "Transaction updated successfully", code: "positive" }
      : {
          text: "There was a problem trying to update.",
          code: "negative"
        };

    this.setState({
      transaction: {
        date: actualDateTimeInput(),
        id: "",
        amount: "",
        is_expense: true,
        description: "",
        comment: ""
      },
      isFormVisible: false,
      message
    });
    console.log(response.data);
    this.getTransactions(this.state.user.id);
  };
  handleSubmit = e => {
    e.preventDefault();
    e.target.id.value ? this.put() : this.post();
  };
  handleLogIn = async e => {
    e.preventDefault();
    if (navigator.onLine) {
      const { username, password } = this.state.user;
      const response = await Axios.post(
        "/user/auth",
        { username, password },
        { headers: { "X-CSRFToken": csrftoken } }
      );

      if (response.data.user) {
        const { user } = response.data;
        this.getTransactions(user.id, this.state.filter);
        sessionStorage.setItem("user", JSON.stringify(user));
        this.setState(prevState => {
          return {
            user: {
              ...user,
              password: prevState.user.password
            },
            isLoggedIn: true
          };
        });
      } else {
        console.log("you are not login");
      }
    } else {
      const user = JSON.parse(sessionStorage.getItem("user"));
      this.setState(prevState => {
        return {
          user: {
            ...user,
            password: prevState.user.password
          },
          isLoggedIn: true
        };
      });
    }
  };
  handleLogOut = () => {
    sessionStorage.clear();
    console.log("pres");
    this.setState({
      user: {
        id: 0,
        username: "",
        password: "",
        balance: 0
      },
      isLoggedIn: false
    });
  };
  handleChangeLogIn = e => {
    const { name, value } = e.target;
    this.setState(prevState => {
      return {
        user: {
          ...prevState.user,
          [name]: value
        }
      };
    });
  };
  handleEdit = transaction => {
    const { date, time } = transaction;
    console.log(`${date}T${time}`);

    this.setState({
      transaction: { ...transaction, date: `${date}T${time}` },
      isFormVisible: true
    });
    window.scrollTo(0, 0);
  };
  handleFilter = e => {
    this.getTransactions(this.state.user.id, e.target.value);
    this.setState({
      filter: e.target.value
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
      message,
      dateFilter,
      filter,
      isLoggedIn
    } = this.state;
    console.log(isLoggedIn);

    if (isLoggedIn) {
      return isLoaded ? (
        <React.Fragment>
          <HeaderComponent
            handle
            handleLogOut={this.handleLogOut}
            username={user.username}
            balance={user.balance}
          />
          <div className="ui container fluid">
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
            <Button icon onClick={(onclick, this.handleFormVisibility)}>
              <Icon name={isFormVisible ? "minus" : "plus"} />
            </Button>
            <br />
            {isFormVisible && (
              <TransactionForm
                transaction={transaction}
                handleSubmit={this.handleSubmit}
                handleChange={this.handleChange}
              />
            )}
            <div className="date-filter">
              <div className="ui label ">
                <i className="filter icon" /> Filter:{" "}
                <select
                  className="ui dropdown "
                  value={filter}
                  onChange={this.handleFilter}
                  name="date-filter-select"
                >
                  {dateFilter.map((filter, i) => {
                    return (
                      <option key={i} value={filter.value}>
                        {filter.text}
                      </option>
                    );
                  })}
                </select>
              </div>
            </div>
            <div className="ui input search-filter">
              <input type="text" placeholder="Search..." />
            </div>
            <div className="ui stackable three column grid transactions">
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
            </div>
          </div>
        </React.Fragment>
      ) : (
        <Dimmer active inverted>
          <Loader inverted content="Loading" />
        </Dimmer>
      );
    } else {
      return (
        <LogIn
          user={user}
          handleChangeLogIn={this.handleChangeLogIn}
          handleLogIn={this.handleLogIn}
        />
      );
    }
  }
}

export default App;
