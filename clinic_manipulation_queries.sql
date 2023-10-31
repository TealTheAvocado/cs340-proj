-- get all Provider IDs, firstNames, lastNames to populate the Provider dropdown
SELECT providerID, firstName, lastName FROM Providers

-- get all clients and their providers for the Clients page
SELECT Clients.clientID, firstName, lastName, Clients.providerID AS provider, 
FROM Clients INNER JOIN Clients ON provider = Providers.providerID

-- get a single client's data for the Update Client form
SELECT clientID, firstName, lastName, provider FROM Clients
WHERE clientID = :client_ID_selected_from_browse_client_page

-- add a new client
INSERT INTO Clients 
(firstName, lastName, providerID) 
VALUES 
(:firstName, :lastName, :provider_id_from_dropdown_Input)

-- update a client's data based on submission of the Update Client form 
UPDATE Clients SET firstName = :fnameInput, lastName= :lnameInput, 
provider = :provider_id_from_dropdown_Input
WHERE id= :client_ID_from_the_update_form

-- delete a client
DELETE FROM Clients 
WHERE id = :client_ID_selected_from_browse_client_page

-- get all providers for the Providers page
SELECT Provider.providerID, firstName, lastName, FROM Providers 

-- get a single provider's data for the Update Provider form
SELECT providerID, firstName, lastName FROM Providers
WHERE providerID = :provider_ID_selected_from_browse_provider_page

-- add a new client
INSERT INTO Providers 
(firstName, lastName, title) 
VALUES 
(:fnameInput, :lnameInput, :titleInput)

-- update a provider's data based on submission of the Update Provider form 
UPDATE Providers SET firstName = :fnameInput, lastName= :lnameInput, title= :titleInput
WHERE id= :provider_ID_from_the_update_form

-- delete a provider
DELETE FROM Providers 
WHERE id = :provider_ID_selected_from_browse_client_page