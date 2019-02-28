import React from "react";
import { formatCompleteDate } from "../../helperFunctions/formatTime";

const Transaction = props => {
  const { id, amount, type, description, date, time } = props.transaction;
  console.log();

  return (
    <section>
      <h3>Date: {formatCompleteDate(time, date)}</h3>
      <h3>${amount} </h3>
      <p>{description}</p>
      <button type="button">Show details</button>
    </section>
  );
};
export default Transaction;
