import React from "react";
import {
  Form,
  Input,
  Segment,
  Checkbox,
  TextArea,
  Button,
  Grid
} from "semantic-ui-react";

import "./TransactionForm.css";

const TransactionForm = ({ handleSubmit, handleChange, transaction }) => {
  console.log(transaction);

  return (
    <Segment textAlign="center" className="transaction-form">
      <Form onSubmit={handleSubmit}>
        <input type="hidden" name="id" value={transaction.id} />
        <Grid stackable columns={2}>
          <Grid.Column>
            <Form.Field>
              <Input
                label="Date:"
                // value="2018-06-12T19:30"
                type="datetime-local"
                name="date"
                onChange={handleChange}
                value={transaction.date}
                required
              />
            </Form.Field>
          </Grid.Column>
          <Grid.Column>
            <Form.Field>
              <Input
                // value="2018-06-12T19:30"
                className={transaction.is_expense ? "expense" : "income"}
                iconPosition="left"
                onChange={handleChange}
                value={transaction.amount}
                name="amount"
                placeholder="0.00"
                type="number"
                icon="dollar sign"
                required
              />
            </Form.Field>
          </Grid.Column>
          <Grid.Column width={16}>
            <Form.Field>
              <Checkbox
                toggle
                type="checkbox"
                name="isExpense"
                label={transaction.is_expense ? "Expense" : "Income"}
                checked={transaction.is_expense}
                onClick={
                  (onclick,
                  () =>
                    handleChange({
                      target: {
                        type: "checkbox",
                        name: "is_expense",
                        value: !transaction.is_expense
                      }
                    }))
                }
              />
            </Form.Field>
          </Grid.Column>

          <Grid.Column>
            <Form.Field>
              <TextArea
                autoHeight
                onChange={handleChange}
                value={transaction.description}
                name="description"
                placeholder="Description"
                required
              />
            </Form.Field>
          </Grid.Column>
          <Grid.Column>
            <Form.Field>
              <TextArea
                name="comment"
                onChange={handleChange}
                value={transaction.comment}
                placeholder="Comments"
              />
            </Form.Field>
          </Grid.Column>
          <Grid.Column width={16}>
            <Form.Field>
              <Button primary>Submit</Button>
            </Form.Field>
          </Grid.Column>
        </Grid>
      </Form>
    </Segment>
  );
};
export default TransactionForm;
