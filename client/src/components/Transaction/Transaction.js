import React from "react";
import { formatCompleteDate } from "../../helperFunctions/formatTime";
import TransactionDetails from "../TransactionDetails/TransactionDetails";
import { Segment } from "semantic-ui-react";

const Transaction = ({ transaction, handleDelete, handleEdit }) => {
  const { amount, description, date, time } = transaction;

  return (
    <Segment>
      <h3>Date: {formatCompleteDate(time, date)}</h3>
      <h3>${amount} </h3>
      <p>{description}</p>

      <TransactionDetails
        transaction={transaction}
        // handleDetailsClick={handleDetailsClick}
        handleDelete={handleDelete}
        handleEdit={handleEdit}
        // id={id}
      />
    </Segment>
  );
};
export default Transaction;
