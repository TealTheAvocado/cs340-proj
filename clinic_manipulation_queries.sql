-- Clent Page
-- 1. Browse/Read: Get all Clients: 
-- for each client, list clientID, firstName, lastName and Primary Provider 
SELECT Clients.clientID, Clients.firstName, Clients.lastName, CONCAT(Providers.firstName," ", Providers.lastName) AS Provider 
FROM Clients
INNER JOIN Providers ON Clients.providerID = Providers.providerID;

-- 2. Add/Create a client: 
-- Get all Provider IDs, firstNames, lastNames to populate the Provider dropdown
SELECT providerID, firstName, lastName FROM Providers;
-- add a new client 
INSERT INTO Clients 
(firstName, lastName, providerID) 
VALUES 
(:firstName, :lastName, :provider_id_from_dropdown_Input);

-- 3. Edit/Update a client: 
-- get a single client's data for the Update Client form 
SELECT clientID, firstName, lastName, providerID FROM Clients
WHERE clientID = :client_ID_selected_from_browse_client_page;
-- Get all Provider IDs, firstNames, lastNames to populate the Provider dropdown
SELECT providerID, firstName, lastName FROM Providers;
-- update a client's data based on submission of the Update Client form 
UPDATE Clients SET firstName = :fnameInput, lastName= :lnameInput, 
providerID = :provider_id_from_dropdown_Input
WHERE clientID= :client_ID_from_the_update_form;

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

-- Appointment Details Page
-- 1. Browse/Read: get all Appointment Details
-- for each Appointment Detail, list ID, perinatal appointment name, and concatenated provider first and last name 
SELECT apptDetailID, PerinatalAppointments.name, CONCAT(Providers.firstName," ", Providers.lastName) AS Provider
FROM PerinatalAppointments 
INNER JOIN AppointmentDetails ON PerinatalAppointments.perinatalApptID = AppointmentDetails.perinatalApptID
INNER JOIN Providers ON AppointmentDetails.providerID = Providers.providerID;

-- 2. Add/Create: add a new appointment detail 
-- create drop down for perinatal appointments, listing them by name
SELECT perinatalapptID, name FROM PerinatalAppointments;
-- create drop down menu for providers, listing each provider by first name and last name
SELECT providerID, CONCAT(firstName, " ", lastName) AS Provider FROM Providers;
-- insert new perinatal Appointment Detail
INSERT INTO AppointmentDetails 
(perinatalApptID, providerID) 
VALUES 
(:appointment_ID_from_droptdownInput, :provider_ID_sfrom_dropdownInput);

-- 3. Edit/Update: To preserve patient histories, editing/updating appointment detials is not allowed

-- 4. Delete: To preserve patient histories, deleting appointment details is not allowed

-- Appointment Histories Page
-- 1. Browse/Read: get all Appointment Histories
-- for each Appointment History, list apptHistoryID, clients first name and last name, perinatal appointment name, providers first and last name concatenated and date
SELECT AppointmentHistories.apptHistoryID, Clients.firstName, Clients.lastName, PerinatalAppointments.name, CONCAT(Providers.firstName," ", Providers.lastName) AS Provider, date 
FROM PerinatalAppointments
INNER JOIN AppointmentHistories ON PerinatalAppointments.perinatalApptID = AppointmentDetails.perinatalApptID
INNER JOIN Providers ON AppointmentDetails.providerID = Providers.providerID
INNER JOIN Clients ON AppointmentHistories.clientID = Clients.clientID;

-- 2. Add/Create: add a new appointment history event
-- Create drop down for client, listing each client by id and first and last name
SELECT clientID, CONCAT(firstName, " ", lastName) as client 
FROM Clients;
-- Create a drop down for appointment detail, listing each detail by appointment name and provider
SELECT perinatalApptID, CONCAT(PerinatalAppointments.name, " - ", Providers.firstName," ", Providers.lastName) AS AppointmentDetail
FROM PerinatalAppointments 
-- Create a provider drop down, listing each by first name and last name
SELECT providerID, CONCAT(Providers.firstName," ", Providers.lastName) as Provider 
FROM Providers;
-- insert new appointment history
INSERT INTO AppointmentHistories
(perinatalApptID, clientID, provuderID, date) 
VALUES 
(:perinatal_appt_ID_from_dropdownInput, :client_ID_from_dropdownInput, :provider_ID_from_dropdownInput, :dateInput);

-- 3. Edit/Update: At this time, the appointment and date can be updated from this page, but client cannot. 
-- get a single appointment history event's data for the Update Appointment Histories form
SELECT apptHistoryID, clientID, perinatalApptID, providerID, date FROM AppointmentHistories
WHERE apptHistoryID = :appointment_history_ID_selected_from_browse_appointment_history_page;

-- 4. Delete: remove an appointment history event
DELETE FROM AppointmentHistories
WHERE apptHistoryID = :appointment_history_ID_selected_from_browse_appointment_histories_page;


-- Employee Page 
-- 1. Browse/Read: get all employees
-- for each provider, list ID, first name, last name, and title
SELECT employeeID, firstName, lastName, title FROM Employees; 

-- 2. Add/Create an employee: 
-- create dropdown for title
SELECT DISTINCT title From Employees; 
-- add new employee
INSERT INTO Employees
(firstName, lastName, title) 
VALUES 
(:fnameInput, :lnameInput, :title_from_drowpdown_Input);

-- 3. Edit/Update up employee:
-- create dropdown for title
SELECT DISTINCT title From Employees; 
-- get a single employee's data for the Update Employee form
SELECT employeeID, firstName, lastName, title FROM Employees
WHERE employeeID = :employee_ID_selected_from_browse_employee_page
-- update an employee's data based on submission of the Update Employee form 
UPDATE Employees SET firstName = :fnameInput, lastName= :lnameInput, title= :title_from_dropdown_input
WHERE employeeID= :employee_ID_from_the_update_form;

-- 4. Delete an employee:
DELETE FROM Employees
WHERE employeeID = :employee_ID_selected_from_browse_employee_page;

-- Nonmedical Services Page
-- 1. Browse/Read: get all Nonmedical Services
-- for each service, list ID, name, and description
SELECT ServceID, name, description FROM NonmedicalServices; 

-- 2. Add/Create: Create a new Service
-- insert new nonmedical service 
INSERT INTO NonmedicalServices 
(name, description) 
VALUES 
(:nameInput, :descriptionInput);

-- 3.Edit/Update: Edit a service
-- get a single service's data for the Update Nonmedical Services form
SELECT serviceID, name, description FROM NonmedicalServices
WHERE serviceID = :service_ID_selected_from_browse_appointment_page;
-- update a services data based on submission of the Update Nonmedical Services form 
UPDATE NonmedicalServices SET name = :nameInput, description= :descriptionInput
WHERE serviceID= :service_ID_from_the_update_form;

-- 4. Delete: To preserve patient histories, deletion of nonmedical services is not allowed. 

-- Service Histories Page
-- 1. Browse/Read: get all Service Histories
-- for each Service History, list serviceHistoryID, clients first name and last name, service name, providers first and last name concatenated and date
SELECT ServiceHistories.serviceHistoryID, Clients.firstName, Clients.lastName, NonmedicalServices.name AS Service, CONCAT(NonmedicalEmployees.firstName," ", NonmedicalEmployees.lastName) AS Employee, date 
FROM NonmedicalServices
INNER JOIN ServiceHistories ON NonmedicalServices.serviceID = ServiceHistories.serviceID
INNER JOIN NonmedicalEmployees ON ServiceHistories.employeeID = NonmedicalEmployees.employeeID
INNER JOIN Clients ON ServiceHistories.clientID = Clients.clientID;

-- 2. Add/Create: add a new service history event
-- Create drop down for client, listing each client by id and first and last name
SELECT clientID, CONCAT(firstName, " ", lastName) as client 
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

-- 3. Edit/Update: At this time, the service type and date can be updated, but client cannot. 
-- get a single service history event's data for the Update Service Histories form
SELECT serviceHistoryID, clientID, serviceID, employeeID, date FROM ServiceHistories
WHERE serviceHistoryID = :service_history_ID_selected_from_browse_history_page;

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
