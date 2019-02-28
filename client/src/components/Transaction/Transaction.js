import React from "react";
import { formatCompleteDate } from "../../helperFunctions/formatTime";
import TransactionDetails from "../TransactionDetails/TransactionDetails";

const Transaction = ({ transaction, handleDelete }) => {
  const { id, amount, type, description, date, time } = transaction;
  console.log(handleDelete);

  return (
    <section>
      <h3>Date: {formatCompleteDate(time, date)}</h3>
      <h3>${amount} </h3>
      <p>{description}</p>
      <TransactionDetails handleDelete={handleDelete} id={id} />
    </section>
  );
};
export default Transaction;
