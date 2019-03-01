import React, { useState } from "react";
import { Form, Input, Segment, Dropdown } from "semantic-ui-react";
import { actualDateTimeInput } from "../../helperFunctions/formatTime";
const TransactionForm = () => {
  const [selectValue, setSelectValue] = useState("IN");

  return (
    <Segment textAlign="center">
      <Form>
        <Form.Field>
          <Input
            label="Date:"
            // value="2018-06-12T19:30"
            type="datetime-local"
          />
        </Form.Field>
        <Form.Field>
          <Input
            // value="2018-06-12T19:30"
            iconPosition="left"
            name="date"
            placeholder="0.00"
            type="number"
            icon="dollar sign"
          />
        </Form.Field>
        <Form.Field>
          <Dropdown
            placeholder="Select Friend"
            fluid
            selection
            value={selectValue}
            onChange={}
            options={[
              { value: "IN", text: "Income" },
              { value: "EX", text: "Expense" }
            ]}
          />
        </Form.Field>
      </Form>
    </Segment>
  );
};
export default TransactionForm;
