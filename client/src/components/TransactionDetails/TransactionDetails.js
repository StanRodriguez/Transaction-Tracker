import React, { useState } from "react";
import { Button, Header, Modal } from "semantic-ui-react";

const TransactionDetails = ({ id, handleDelete }) => {
  const [isOpen, setIsOpen] = useState(false);
  return (
    <Modal
      open={isOpen}
      trigger={
        <Button onClick={(onclick, () => setIsOpen(!isOpen))} primary>
          Show details
        </Button>
      }
    >
      <Modal.Header>{id}</Modal.Header>
      <Modal.Content>
        <Modal.Description>
          <Header>Default Profile Image</Header>
          <p>
            We've found the following gravatar image associated with your e-mail
            address.We've found the following gravatar image associated with
            your e-mail address.We've found the following gravatar image
            associated with your e-mail address.We've found the following
            gravatar image associated with your e-mail address.We've found the
            following gravatar image associated with your e-mail address.We've
            found the following gravatar image associated with your e-mail
            address.We've found the following gravatar image associated with
            your e-mail address.We've found the following gravatar image
            associated with your e-mail address.We've found the following
            gravatar image associated with your e-mail address.We've found the
            following gravatar image associated with your e-mail address. We've
            found the following gravatar image associated with your e-mail
            address.We've found the following gravatar image associated with
          </p>
          <p>Is it okay to use this photo?</p>
        </Modal.Description>
      </Modal.Content>
      <Modal.Actions>
        <Button
          basic
          color="yellow"
          onClick={(onclick, () => setIsOpen(!isOpen))}
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
