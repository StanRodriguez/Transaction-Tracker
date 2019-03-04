import React, { useState } from "react";
import { Button, Header, Modal } from "semantic-ui-react";
import "./TransactionDetails.css";
const TransactionDetails = ({
  // id,
  handleDelete,
  // handleDetailsClick,
  handleEdit,
  transaction
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const { id, amount, comment, description, time, date } = transaction;

  return (
    <Modal
      closeIcon
      closeOnDimmerClick={true}
      closeOnEscape={true}
      onClose={(onclick, e => setIsOpen(!isOpen))}
      size="mini"
      dimmer="blurring"
      open={isOpen}
      trigger={
        <Button
          onClick={
            (onclick,
            e => {
              // handleDetailsClick(id);
              setIsOpen(!isOpen);
            })
          }
          primary
        >
          Show details
        </Button>
      }
    >
      <Modal.Header className="modal-header">
        <p>Transaction # ${transaction.id}</p>
      </Modal.Header>
      <Modal.Content>
        <Modal.Description>
          <Header>{amount}</Header>
          <p>{description}</p>
          <p>
            {date} {time}
          </p>
          <p>{comment}</p>
        </Modal.Description>
      </Modal.Content>
      <Modal.Actions>
        <Button
          basic
          color="yellow"
          onClick={
            (onclick,
            e => {
              handleEdit(transaction);
              setIsOpen(!isOpen);
            })
          }
        >
          Edit
        </Button>
        <Button
          basic
          color="red"
          name="delete"
          value={id}
          onClick={
            (onclick,
            e => {
              handleDelete(e);
              setIsOpen(!isOpen);
            })
          }
        >
          Delete
        </Button>
      </Modal.Actions>
    </Modal>
  );
};

export default TransactionDetails;
