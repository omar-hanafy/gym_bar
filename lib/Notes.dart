/*
?Folder Instructions:
!Core is divided into three folders.
  *Models: Contains all the plain data models.
  *Services: Contains the dedicated files that will handle actual business logic.
  *ViewModels: Contains the Provider models for each of the Widget views.

!UI is also divided into three folders.
  *Shared: Contains files used in multiple other UI files.
  *Views: Contains the files for the app views.
  *Widgets: Contains widget files that are too big to keep in the view files.

?we’ll put all the routing in a separate file called router.dart under the UI folder
?his function receives RouteSettings which contains the name of the route being requested.
?We’ll also return an error view for any undefined route.

*/

// !Needed fields in database:
///////////////////////////////////////////////////////////////////////////////

//?customer:
/*
name
id
balance
branch
*/

///////////////////////////////////////////////////////////////////////////////

//?employers:
/*
name:
id
email:
*/

///////////////////////////////////////////////////////////////////////////////

//?employers_logs:
/*
employerName
loginDate
loginTime
branch
*/

///////////////////////////////////////////////////////////////////////////////

//?transactions:
/*
id:
date:
employerName:
customerName:
customerId:
sells:
total
paid
change
branch
*/

///////////////////////////////////////////////////////////////////////////////

//?products
/*
name
category
number
customerPrice
employeePrice
housePrice
branch
*/

////////////////////////////////////////////////////////////////////////////////

//?branches
/*
name
location
*/

///////////////////////////////////////////////////////////////////////////////
