-- Seattle Prenatal Clinic with Team 14
-- Sonja Lavin
-- Flora Zhang

-- disable foreign key checks and auto-commit
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Drop and create the Providers table
DROP TABLE IF EXISTS Providers;
CREATE TABLE Providers (
    providerID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(45) NOT NULL,
    lastName VARCHAR(45) NOT NULL,
    title VARCHAR(45) NOT NULL,
    PRIMARY KEY (providerID)
);

-- Drop and create the Clients table
DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients (
    clientID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(45) NOT NULL,
    lastName VARCHAR(45) NOT NULL,
    providerID INT,
    PRIMARY KEY (clientID),
    FOREIGN KEY (providerID) REFERENCES Providers(providerID) 
    ON DELETE SET NULL
);

-- Drop and create the PerinatalAppointments table
DROP TABLE IF EXISTS PerinatalAppointments;
CREATE TABLE PerinatalAppointments (
    perinatalApptID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    billingCode VARCHAR(45) NOT NULL,
    description VARCHAR(255) NOT NULL,
    PRIMARY KEY (perinatalApptID)
);


-- Drop and create the AppointmentHistories table
DROP TABLE IF EXISTS AppointmentHistories;
CREATE TABLE AppointmentHistories (
    apptHistoryID INT NOT NULL AUTO_INCREMENT,
    clientID INT NOT NULL,
    perinatalApptID INT NOT NULL,
	providerID INT,
    date DATE NOT NULL,
    PRIMARY KEY (apptHistoryID),
    FOREIGN KEY (clientID) REFERENCES Clients(clientID)
    ON DELETE CASCADE,
    FOREIGN KEY (perinatalApptID) REFERENCES PerinatalAppointments(perinatalApptID)
    ON DELETE RESTRICT,
    FOREIGN KEY (providerID) REFERENCES Providers(providerID) 
    ON DELETE SET NULL
);


-- Drop and create the NonmedicalEmployees table
DROP TABLE IF EXISTS NonmedicalEmployees;
CREATE TABLE NonmedicalEmployees (
    employeeID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(45) NOT NULL,
    lastName VARCHAR(45) NOT NULL,
    title VARCHAR(45) NOT NULL,
    PRIMARY KEY (employeeID)
);

-- Drop and create the NonmedicalServices table
DROP TABLE IF EXISTS NonmedicalServices;
CREATE TABLE NonmedicalServices (
    serviceID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    PRIMARY KEY (serviceID)
);

-- Drop and create the ServiceHistories table
DROP TABLE IF EXISTS ServiceHistories;
CREATE TABLE ServiceHistories (
    serviceHistoryID INT NOT NULL AUTO_INCREMENT,
    clientID INT NOT NULL,
    serviceID INT NOT NULL,
	employeeID INT,
    date DATE NOT NULL,
    PRIMARY KEY (serviceHistoryID),
    FOREIGN KEY (clientID) REFERENCES Clients(clientID)
    ON DELETE CASCADE,
    FOREIGN KEY (serviceID) REFERENCES NonmedicalServices(serviceID)
    ON DELETE RESTRICT,
    FOREIGN KEY (employeeID) REFERENCES NonmedicalEmployees(employeeID) 
    ON DELETE SET NULL
);


-- Insert data into the Providers table
INSERT INTO Providers (providerID, firstName, lastName, title)
VALUES
    (6, 'Mark', 'Sloan', 'Doctor'),
    (7, 'Miranda', 'Bailey', 'Doctor'),
    (8, 'Izzie', 'Stevens', 'Nurse Practitioner'),
    (9, 'Callie', 'Torres', 'Doctor'),
    (10, 'Arizona', 'Robbins', 'Doctor');

-- Insert data into the Clients table
INSERT INTO Clients (clientID, firstName, lastName, providerID)
VALUES
    (1, 'Jane', 'Smith', (SELECT providerID FROM Providers WHERE firstName = "Callie" AND Providers.lastName = "Torres")),
    (2, 'Katie', 'Lee', (SELECT providerID FROM Providers WHERE firstName = "Miranda" AND lastName = "Bailey")),
    (3, 'Nicole', 'Dicaprio', (SELECT providerID FROM Providers WHERE firstName = "Izzie" AND lastName = "Stevens")),
    (4, 'Meredith', 'Grey', (SELECT providerID FROM Providers WHERE firstName = "Arizona" AND lastName = "Robbins")),
    (5, 'Christina', 'Yang', (SELECT providerID FROM Providers WHERE firstName = "Izzie" AND lastName = "Stevens"));


-- Insert data into the PerinatalAppointments table
INSERT INTO PerinatalAppointments (perinatalApptID, name, billingCode, description)
VALUES
    (16, '8 wk prenatal', '1256-7', '8 week prenatal visit'),
    (17, '6 wk postpartum', '1236-0', 'postpartum maternal wellness check'),
    (18, 'family planning', '12344-22', 'discuss planning for pregnancy'),
    (19, '24 wk prenatal', '13435-123', '24 week prenatal visit'),
    (20, '16 wk prenatal', '12343-12', '15 week prenatal visit');
      
    -- Insert data into the AppointmentHistories table
INSERT INTO AppointmentHistories (apptHistoryID, clientID, perinatalApptID, providerID, date)
VALUES
    (31, 
    (SELECT clientID FROM Clients WHERE firstName = "Jane" AND lastName = "Smith"),
    (SELECT perinatalApptID FROM PerinatalAppointments WHERE PerinatalAppointments.name = '8 wk prenatal'),
    (SELECT providerID FROM Providers WHERE Providers.firstName = "Mark" AND Providers.lastName = "Sloan"),
	'2021-04-03'),
    (32, 
    (SELECT clientID FROM Clients WHERE firstName = "Jane" AND lastName = "Smith"), 
    (SELECT perinatalApptID FROM PerinatalAppointments WHERE PerinatalAppointments.name = '6 wk postpartum'),
    (SELECT providerID FROM Providers WHERE Providers.firstName = "Miranda" AND Providers.lastName = "Bailey"),
    '2021-04-03'),
    (33, 
    (SELECT clientID FROM Clients WHERE firstName = "Katie" AND lastName = "Lee"), 
    (SELECT perinatalApptID FROM PerinatalAppointments WHERE PerinatalAppointments.name = 'family planning'),
    (SELECT providerID FROM Providers WHERE Providers.firstName = "Izzie" AND Providers.lastName = "Stevens"),
    '2021-03-29'),
    (34, 
    (SELECT clientID FROM Clients WHERE firstName = "Christina" AND lastName = "Yang"),
    (SELECT perinatalApptID FROM PerinatalAppointments WHERE PerinatalAppointments.name = '24 wk prenatal'),
    (SELECT providerID FROM Providers WHERE Providers.firstName = "Callie" AND Providers.lastName = "Torres"),
    '2021-04-12'),
    (35, 
    (SELECT clientID FROM Clients WHERE firstName = "Nicole" AND lastName = "Dicaprio"), 
    (SELECT perinatalApptID FROM PerinatalAppointments WHERE PerinatalAppointments.name = '16 wk prenatal'),
    (SELECT providerID FROM Providers WHERE Providers.firstName = "Arizona" AND Providers.lastName = "Robbins"),
    '2021-04-05');
    
-- Insert data into the NonmedicalEmployees table
INSERT INTO NonmedicalEmployees (employeeID, firstName, lastName, title)
VALUES
    (11, 'Lexie', 'Grey', 'Lactation Consultant'),
    (12, 'Jo', 'Wilson', 'Nutritionist'),
    (13, 'Jackson', 'Avery', 'Lactation Consultant'),
    (14, 'George', 'O''Malley', 'Social Worker'),
    (15, 'April', 'Kepner', 'Social Worker');

-- Insert data into the NonmedicalServices table
INSERT INTO NonmedicalServices (serviceID, name, description)
VALUES
    (21, 'Lactation Counseling', '1:1 appointment with lactation consultant'),
    (22, 'Breastfeeding Group', 'breastfeeding support group lead by lactation consultant'),
    (23, 'Housing Assistance', 'meeting with social worker to determine housing options'),
    (24, 'Prenatal Nutrition', 'appointment with nutritionist to improve and support prenatal nutrition'),
    (25, 'Gestational Diabetes Nutrition', 'appointment with nutritionist to support nutrition in the setting of gestational diabetes');
    

-- Insert data into the ServiceHistories table
INSERT INTO ServiceHistories (serviceHistoryID, clientID, serviceID, employeeID, date)
VALUES
    (26, 
    (SELECT clientID FROM Clients WHERE firstName = "Jane" AND lastName = "Smith"), 
    (SELECT serviceID FROM NonmedicalServices WHERE NonmedicalServices.name = 'Breastfeeding Group'),
    (SELECT employeeID FROM NonmedicalEmployees WHERE NonmedicalEmployees.firstName = 'Lexie' AND NonmedicalEmployees.lastName = 'Grey'),
	'2021-04-03'),
    (27, 
    (SELECT clientID FROM Clients WHERE firstName = "Katie" AND lastName = "Lee"), 
    (SELECT serviceID FROM NonmedicalServices WHERE NonmedicalServices.name = 'Lactation Counseling'),
    (SELECT employeeID FROM NonmedicalEmployees WHERE NonmedicalEmployees.firstName = 'Jackson' AND NonmedicalEmployees.lastName = 'Avery'),
    '2021-03-29'),
    (28, 
    (SELECT clientID FROM Clients WHERE firstName = "Nicole" AND lastName = "Dicaprio"), 
    (SELECT serviceID FROM NonmedicalServices WHERE NonmedicalServices.name = 'Housing Assistance'),
    (SELECT employeeID FROM NonmedicalEmployees WHERE NonmedicalEmployees.firstName = 'George' AND NonmedicalEmployees.lastName = 'O''Malley'),
    '2021-04-05'),
    (29, 
    (SELECT clientID FROM Clients WHERE firstName = "Meredith" AND lastName = "Grey"), 
    (SELECT serviceID FROM NonmedicalServices WHERE NonmedicalServices.name = 'Prenatal Nutrition'),
    (SELECT employeeID FROM NonmedicalEmployees WHERE NonmedicalEmployees.firstName = 'Jo' AND NonmedicalEmployees.lastName = 'Wilson'), 
    '2021-04-12'),
    (30, 
    (SELECT clientID FROM Clients WHERE firstName = "Meredith" AND lastName = "Grey"), 
    (SELECT serviceID FROM NonmedicalServices WHERE NonmedicalServices.name = 'Gestational Diabetes Nutrition'),
    (SELECT employeeID FROM NonmedicalEmployees WHERE NonmedicalEmployees.firstName = 'Jo' AND NonmedicalEmployees.lastName = 'Wilson'),
    '2021-04-13');



-- enable foreign key checks and commit
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
