# Project Overview

## Project Schedule

This schedule will be used to keep track of your progress throughout the week and align with our expectations.

You are **responsible** for scheduling time with your squad to seek approval for each deliverable by the end of the corresponding day, excluding `Saturday` and `Sunday`.

| Day   | Deliverable                                          | Status   |
| ----- | ---------------------------------------------------- | -------- |
| Day 1 | Project Description                                  | Incomplete |
| Day 1 | Wireframes / Priority Matrix / Functional Components | Incomplete |
| Day 2 | Core Application Structure (HTML, CSS, etc.)         | Incomplete |
| Day 3 | Pseudocode / actual code                             | Incomplete |
| Day 3 | Initial Clickable Model                              | Incomplete |
| Day 4 | MVP                                                  | Incomplete |
| Day 5 | Present                                              | Incomplete |

## Project Description

This app keeps track of all expenses and incomes and see the balance you have at the moment.

## [Wireframes](https://photos.app.goo.gl/BWXa42kUcKHUA1aG7)

[Link to Wireframes](https://photos.app.goo.gl/BWXa42kUcKHUA1aG7)

## [Priority Matrix](https://photos.app.goo.gl/bnLUxTuaLBdyW4US9)

[Link to Priority Matrix](https://photos.app.goo.gl/bnLUxTuaLBdyW4US9)

## [ERD](https://photos.app.goo.gl/SWXnxWQW6kmUdFLN7)

[Link to ERD](https://photos.app.goo.gl/SWXnxWQW6kmUdFLN7)


### MVP/PostMVP - 5min

The functionality will then be divided into two separate lists: MPV and PostMVP. Carefully decided what is placed into your MVP as the client will expect this functionality to be implemented upon project completion.

#### MVP

- The user can insert incomes. 
- The user can insert expenses. 
- The user can delete incomes. 
- The user can delete expenses. 
- The user can see their balance. 
- The user can see the transaction details.

#### PostMVP

- User login.
- Image uploading.
- History.
- Session handling.
- Edit incomes.
- Edit expenses.
- More filters.
- Date filter.

## [React Architectural Design](https://photos.app.goo.gl/y5c3GFojTMtRKcVj6)

[Link to React Architectural Design](https://photos.app.goo.gl/y5c3GFojTMtRKcVj6)

## UI Components

Based on the initial logic defined in the previous sections try and breakdown the logic further into stateless/stateful components.

| Component       |                               Description                                |
| --------------- | :----------------------------------------------------------------------: |
| App             |                        Serves as a main container.                       |
| Header          |            Renders the user balance.             |
| Dashboard       |              Renders all your transactions from a week ago.              |
| Transaction     | Renders short summary transaction. |
| TransactionDetail|                   Renders all the transaction-related information.        |
| NewTransaction |          Create an income and/or expense.           |
| History          |         Hold the static information for all the transactions in a given time.                     |
| Table          |                      Serves a header to grab the transaction details.                      |
|TableRow| Render each transaction|

## Time Frames

Time frames are also key in the development cycle. You have limited time to code all phases of the game. Your estimates can then be used to evalute game possibilities based on time needed and the actual time you have before game must be submitted. It's always best to pad the time by a few hours so that you account for the unknown so add and additional hour or two to each component to play it safe.

| Component                            | Priority | Estimated Time | Actual Time |
| ----------------------------------------- | :------: | :------------: | :---------: |
|  HTML/CSS                                 |    H     |      7hrs      |   hrs    |
| The user can insert incomes               |    H     |      7hrs      |   hrs    |
| The user can insert expenses              |    H     |      3hrs      |    hrs     |
| The user can delete incomes               |    H     |      5hrs      |    hrs     |
| The user can delete expenses              |    H     |      3hrs      |    hrs     |
| The user can see their balance            |    H     |      2hrs      |    hrs     |
| The user can see the transaction details  |    M     |      5hrs      |    hrs     |
| PostMVPs                                  |    L     |     20hrs      |    hrs     |
| Total                                     |          |     52hrs      |   hrs   |


## Helper Functions

Helper functions should be generic enought that they can be reused in other applications. Use this section to document all helper functions that fall into this category.

| Function |                                  Description                                  |
| -------- | :---------------------------------------------------------------------------: |


## Additional Libraries

Use this section to list all supporting libraries and thier role in the project.

| Library            |                      What it Does                       |
| ------------------ | :-----------------------------------------------------: |
| Bootstrap      | For a responsive approach  |
| Django      | Back-end framework built in Python |

## Code Snippet

Use this section to include a brief code snippet of functionality that you are proud of an a brief description

```
const numberWithCommas = x => {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};

// this function add commas as a separator in numbers.
// source: https://stackoverflow.com/questions/2901102/how-to-print-a-number-with-commas-as-thousands-separators-in-javascript
export default numberWithCommas;

```

## Change Log

Use this section to document what changes were made and the reasoning behind those changes.

| Original Plan                  |                                      Outcome                                       |
| ------------------------------ | :--------------------------------------------------------------------------------: |
| Have one Information component | I added another component to render several items in the same information category |

## Issues and Resolutions

Use this section to list of all major issues encountered and their resolution.

**ERROR**: Map returning to default when zooming in or out.
**RESOLUTION**: adding the previous state to the onViewPortChange event.
