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

This app keeps track of all your expenses and incomes and see the balance you have for each month.

## [Wireframes](https://photos.app.goo.gl/BWXa42kUcKHUA1aG7)

[Link to Wireframes](https://photos.app.goo.gl/BWXa42kUcKHUA1aG7)

## [Priority Matrix](https://photos.app.goo.gl/bnLUxTuaLBdyW4US9)

[Link to Priority Matrix](https://photos.app.goo.gl/bnLUxTuaLBdyW4US9)

### MVP/PostMVP - 5min

The functionality will then be divided into two separate lists: MPV and PostMVP. Carefully decided what is placed into your MVP as the client will expect this functionality to be implemented upon project completion.

#### MVP

- The user can insert incomes. &#10003;
- The user can insert expenses. &#10003;
- The user can delete incomes. &#10003;
- The user can delete expenses. &#10003;
- The user can see their balance. &#10003;
- The user can see the transaction details. &#10003;
- Date filter.

#### PostMVP

- User login.
- Image uploading (invoice).
- History.
- Session handling.
- Edit incomes.
- Edit expenses.
- More filters.

## [React Architectural Design](https://photos.app.goo.gl/qjdD6iHLRSxhJQeg8)

[Link to React Architectural Design](https://photos.app.goo.gl/qjdD6iHLRSxhJQeg8)

## Functional Components

Based on the initial logic defined in the previous sections try and breakdown the logic further into stateless/stateful components.

| Component       |                               Description                                |
| --------------- | :----------------------------------------------------------------------: |
| App             |                        Serves as a main container                        |
| Search          |            Searches for API information with user interaction            |
| Map             |              Renders the map pointing the country selected               |
| MapStyleButton  | Renders buttons to change map style (i.e. satellite, streets, dark, etc) |
| Information     |              Renders information about the selected country              |
| InformationList |          Renders varios items in the same piece of information           |
| Header          |                      Defines the header information                      |
| Footer          |                      Defines the footer information                      |

## Time Frames

Time frames are also key in the development cycle. You have limited time to code all phases of the game. Your estimates can then be used to evalute game possibilities based on time needed and the actual time you have before game must be submitted. It's always best to pad the time by a few hours so that you account for the unknown so add and additional hour or two to each component to play it safe.

| Component                            | Priority | Estimated Time | Actual Time |
| ------------------------------------ | :------: | :------------: | :---------: |
| Adding select box                    |    H     |      3hrs      |   1.5hrs    |
| Get the API country information      |    H     |      4hrs      |    1hrs     |
| Render the API country information   |    H     |      4hrs      |    2hrs     |
| Render API map                       |    H     |      4hrs      |    1hrs     |
| Show the country location on the map |    M     |      4hrs      |    2hrs     |
| Styling                              |    M     |      5hrs      |    3hrs     |
| PostMVPs                             |    L     |      5hrs      |    4hrs     |
| Total                                |          |     29hrs      |   14.5hrs   |

## API's Links

- [Mapbox](https://www.mapbox.com/)
- [Rest Countries](https://restcountries.eu/)

## Helper Functions

Helper functions should be generic enought that they can be reused in other applications. Use this section to document all helper functions that fall into this category.

| Function |                                  Description                                  |
| -------- | :---------------------------------------------------------------------------: |
| map      | takes an array, takes a function as a parameter and return the modified array |

## Additional Libraries

Use this section to list all supporting libraries and thier role in the project.

| Library            |                      What it Does                       |
| ------------------ | :-----------------------------------------------------: |
| Bootstrap          |  Used to help style and make my application responsive  |
| REST Countries API |            Used to get countries information            |
| React-Select       | Used to give extra functionality in the select elements |
| MapBoxGL           |            Used to render a map in the app.             |

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