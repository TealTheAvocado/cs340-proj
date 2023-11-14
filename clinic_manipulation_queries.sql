-- Clent Page
-- 1. Browse/Read: Get all Clients: 
-- for each client, list clientID, firstName, lastName and Primary Provider 
SELECT Clients.clientID AS ID, Clients.firstName AS FirstName, Clients.lastName AS LastName, IFNULL(CONCAT(Providers.firstName, ' ' ,Providers.lastName), 'Null') AS Provider 
FROM Clients 
LEFT JOIN Providers ON Clients.providerID = Providers.providerID;
   

-- 2. Add/Create a client: 
-- get infor to create provider drop down menu
SELECT providerID AS providerID, CONCAT(firstName, ' ' ,lastName) AS Provider FROM Providers;

-- insert client into database
INSERT INTO Clients (firstName, lastName, providerID) 
VALUES (:firstName, :lastName, :provider_id_from_dropdown_Input);


-- 3. Edit/Update a client:  Note this has not been implemented yet
-- get a single client's data for the Update Client form 
-- SELECT clientID, firstName, lastName, providerID FROM Clients
-- WHERE clientID = :client_ID_selected_from_browse_client_page;
-- Get all Provider IDs, firstNames, lastNames to populate the Provider dropdown
-- SELECT providerID, firstName, lastName FROM Providers;
-- update a client's data based on submission of the Update Client form 
-- UPDATE Clients SET firstName = :fnameInput, lastName= :lnameInput, 
-- providerID = :provider_id_from_dropdown_Input
-- WHERE clientID= :client_ID_from_the_update_form;

-- 4. Delete a client:
DELETE FROM Clients 
WHERE clientID = :client_ID_selected_from_browse_client_page;

-- Provider Page 
-- 1. Browse/Read: get all providers
-- for each provider, list ID, first name, last name, and title
SELECT providerID, firstName, lastName, title FROM Providers; 

-- 2. Add/Create a provider: 
-- create dropdown for title
SELECT DISTINCT title From Providers; 
-- add new provider 
INSERT INTO Providers 
(firstName, lastName, title) 
VALUES 
(:fnameInput, :lnameInput, :title_from_drowpdown_Input);

-- 3. Edit/Update up provider:
-- create dropdown for title
SELECT DISTINCT title From Providers; 
-- get a single provider's data for the Update Provider form
SELECT providerID, firstName, lastName, title FROM Providers
WHERE providerID = :provider_ID_selected_from_browse_provider_page
-- update a provider's data based on submission of the Update Provider form 
UPDATE Providers SET firstName = :fnameInput, lastName= :lnameInput, title= :title_from_dropdown_input
WHERE providerID= :provider_ID_from_the_update_form;

-- 4. Delete a provider:
DELETE FROM Providers 
WHERE providerID = :provider_ID_selected_from_browse_provider_page;

-- Perinatal Appointments Page
-- 1. Browse/Read: get all perinatal Appointments
-- for each appointment, list ID, name, billing code, and description
SELECT perinatalApptID, name, billingCode, description FROM PerinatalAppointments; 

-- 2. Add/Create: Create a new perinatal Appointment
-- insert new perinatal appointment 
INSERT INTO PerinatalAppointments 
(name, billingCode, description) 
VALUES 
(:nameInput, :billingCodeInput, :descriptionInput);

-- 3.Edit/Update: Edit an appointment
-- get a single appointment's data for the Update Perinatal Appointment form
SELECT perinatalApptID, name, billingCode, description FROM PerinatalAppointments
WHERE perinatalApptID = :appointment_ID_selected_from_browse_appointment_page;
-- update an appointment's data based on submission of the Update Perinatal Appointment form 
UPDATE PerinatalAppointments SET name = :nameInput, billingCode= :billingCodeInput, description= :descriptionInput
WHERE perinatalApptID= :appointment_ID_from_the_update_form;

-- 4. Delete: To preserve patient histories, deletion of perinatal appointments is not allowed. 

-- Appointment Histories Page
-- 1. Browse/Read: get all Appointment Histories
-- for each Appointment History, list apptHistoryID, clients first name and last name, perinatal appointment name, providers first and last name concatenated and date
SELECT AppointmentHistories.apptHistoryID, Clients.firstName, Clients.lastName, PerinatalAppointments.name AS Appointment, CONCAT(Providers.firstName," ", Providers.lastName) AS Provider, date 
FROM PerinatalAppointments
INNER JOIN AppointmentHistories ON PerinatalAppointments.perinatalApptID = AppointmentHistories.perinatalApptID
INNER JOIN Providers ON AppointmentHistories.providerID = Providers.providerID
INNER JOIN Clients ON AppointmentHistories.clientID = Clients.clientID;


-- 2. Add/Create: add a new appointment history event
-- Create drop down for client, listing each client by id and first and last name
SELECT clientID, CONCAT(firstName, " ", lastName) as client 
FROM Clients;
-- Create a drop down for appointment, listing each by appointment name 
SELECT perinatalApptID, PerinatalAppointments.name AS Appointment
FROM PerinatalAppointments;
-- Create a provider drop down, listing each by first name and last name
SELECT providerID, CONCAT(Providers.firstName," ", Providers.lastName) as Provider 
FROM Providers;
-- insert new appointment history
INSERT INTO AppointmentHistories
(perinatalApptID, clientID, providerID, date) 
VALUES 
(:perinatal_appt_ID_from_dropdownInput, :client_ID_from_dropdownInput, :provider_ID_from_dropdownInput, :dateInput);

-- 3. Edit/Update: At this time, the appointment and date can be updated from this page, but client cannot. 
--  get a single appointment history event's data for the Update Appointment Histories form
SELECT apptHistoryID, clientID, perinatalApptID, providerID, date FROM AppointmentHistories
WHERE apptHistoryID = :appointment_history_ID_selected_from_browse_appointment_history_page;
-- Create a drop down for appointment, listing each by appointment name 
SELECT perinatalApptID, PerinatalAppointments.name AS Appointment
FROM PerinatalAppointments;
-- Create a provider drop down, listing each by first name and last name
SELECT providerID, CONCAT(Providers.firstName," ", Providers.lastName) as Provider 
FROM Providers;
-- update appointment history data based on submission of the Update Services History form 
UPDATE AppointmentHistories SET clientID = :client_ID_selected_from_dropdown, perinatalApptID = :perinatalAppt_ID_selected_from_dropdown, providerID = :provider_ID_selected_from_dropdown, date= :dateInput
WHERE apptHistoryID= :appointment_ID_from_the_update_form;

-- 4. Delete: remove an appointment history event
DELETE FROM AppointmentHistories
WHERE apptHistoryID = :appointment_history_ID_selected_from_browse_appointment_histories_page;


-- Employee Page 
-- 1. Browse/Read: get all employees
-- for each provider, list ID, first name, last name, and title
 SELECT employeeID AS ID, firstName AS FirstName, lastName AS LastName, title AS Title FROM NonmedicalEmployees;

-- 2. Add/Create an employee: 
-- create dropdown for title
SELECT DISTINCT title From NonmedicalEmployees; 
-- add new employee
INSERT INTO NonmedicalEmployees
(firstName, lastName, title) 
VALUES 
(:fnameInput, :lnameInput, :title_from_drowpdown_Input);

-- 3. Edit/Update up employee -- not allowed at this time:
-- create dropdown for title
-- SELECT DISTINCT title From NonmedicalEmployees; 
-- get a single employee's data for the Update Employee form
-- SELECT employeeID, firstName, lastName, title FROM NonmedicalEmployees
-- WHERE employeeID = :employee_ID_selected_from_browse_employee_page
-- update an employee's data based on submission of the Update Employee form 
-- UPDATE Employees SET firstName = :fnameInput, lastName= :lnameInput, title= :title_from_dropdown_input
-- WHERE employeeID= :employee_ID_from_the_update_form;

-- 4. Delete an employee:
DELETE FROM NonmedicalEmployees
WHERE employeeID = :employee_ID_selected_from_browse_employee_page;

-- Nonmedical Services Page
-- 1. Browse/Read: get all Nonmedical Services
-- for each service, list ID, name, and description
SELECT serviceID AS ID, name AS Name, description AS Description FROM NonmedicalServices; 

-- 2. Add/Create: Create a new Service
-- insert new nonmedical service 
INSERT INTO NonmedicalServices 
(name, description) 
VALUES 
(:nameInput, :descriptionInput);

-- 3.Edit/Update: Edit a service at this time editing a service is not allowed. 
-- get a single service's data for the Update Nonmedical Services form
-- SELECT serviceID, name, description FROM NonmedicalServices
-- WHERE serviceID = :service_ID_selected_from_browse_appointment_page;
-- update a services data based on submission of the Update Nonmedical Services form 
-- UPDATE NonmedicalServices SET name = :nameInput, description= :descriptionInput
-- WHERE serviceID= :service_ID_from_the_update_form;

-- 4. Delete: To preserve patient histories, deletion of nonmedical services is not allowed. 

-- Service Histories Page
-- 1. Browse/Read: get all Service Histories
-- for each Service History, list serviceHistoryID, clients first name and last name, service name, providers first and last name concatenated and date
SELECT serviceHistoryID AS ID, CONCAT(Clients.firstName, ' ', Clients.lastName) AS Client, NonmedicalServices.name AS Service, IFNULL(CONCAT(NonmedicalEmployees.firstName, ' ', NonmedicalEmployees.lastName), 'Null') AS Employee, DATE_FORMAT(ServiceHistories.date, '%m/%d/%y') AS Date FROM NonmedicalServices 
INNER JOIN ServiceHistories ON NonmedicalServices.serviceID = ServiceHistories.serviceID 
LEFT JOIN NonmedicalEmployees ON ServiceHistories.employeeID = NonmedicalEmployees.employeeID 
INNER JOIN Clients ON ServiceHistories.clientID = Clients.clientID;               

-- 2. Add/Create: add a new service history event
-- Create drop down for client, listing each client by id and first and last name
SELECT clientID, CONCAT(firstName, " ", lastName) as Client 
FROM Clients;
-- Create a drop down for service, listing each by name
SELECT serviceID, NonmedicalServices.name AS Service
FROM NonmedicalServices;
-- Create a employee drop down, listing each by first name and last name
SELECT employeeID, CONCAT(NonmedicalEmployees.firstName," ", NonmedicalEmployees.lastName) as Employee 
FROM NonmedicalEmployees;
-- insert new service history
INSERT INTO ServiceHistories
(clientID, serviceID, employeeID, date) 
VALUES 
(:client_ID_from_dropdownInput, :service_ID_from_dropdownInput, :employee_ID_from_dropdownInput, :dateInput);

-- 3. Edit/Update: At this time, all details of the service history can be updated 
-- get a single service history event's data for the Update Service Histories form
SELECT serviceHistoryID, clientID, serviceID, employeeID, date FROM ServiceHistories
WHERE serviceHistoryID = :service_history_ID_selected_from_browse_history_page;
-- Create drop down for client, listing each client by id and first and last name
SELECT clientID, CONCAT(firstName, " ", lastName) as Client 
FROM Clients;
-- Create a drop down for service, listing each by name
SELECT serviceID, NonmedicalServices.name AS Service
FROM NonmedicalServices;
-- Create a employee drop down, listing each by first name and last name
SELECT employeeID, CONCAT(NonmedicalEmployees.firstName," ", NonmedicalEmployees.lastName) as Employee 
FROM NonmedicalEmployees;
-- update a service history data based on submission of the Update Services History form 
UPDATE ServiceHistories SET clientID = :client_ID_selected_from_dropdown, serviceID = :service_ID_selected_from_dropdown, employeeID = :employee_ID_selected_from_dropdown, date= :dateInput
WHERE serviceHistoryID= :service_ID_from_the_update_form;

-- 4. Delete: remove a service history event
DELETE FROM ServiceHistories
WHERE serviceHistoryID = :service_history_ID_selected_from_browse_service_histories_page;
