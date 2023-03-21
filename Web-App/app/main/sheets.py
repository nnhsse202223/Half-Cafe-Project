import os
from Google import Create_Service

CLIENT_SECRET_FILE = 'client_secret.json'
API_NAME = 'sheets'
API_VERSION = 'v4'
SCOPES = ['https://www.googleapis.com/auth/spreadsheets']

service = Create_Service(CLIENT_SECRET_FILE, API_NAME, API_VERSION, SCOPES)

spreadsheet_id = '1iHO2E2TJbnGLL6bYG4MeK9QbpPHs5B2Lc6bVeAPJ4RM/edit#gid=0'
mySpreadsheets = service.spreadsheets().get(spreadsheetId=spreadsheet_id).execute()

"""
values.pdate method
"""
worksheet_name = 'Half Caf Orders'
cell_range_insert = 'B2'
values = (
    ('Col A', 'Col B', 'Col C', 'Col D'),
    ('Apple', 'Orange', 'Watermelon', 'Banana')
)
value_range_body = {
    'majorDimension': 'ROWS',
    'values': values
}

service.spreadsheets().values().update(
    spreadsheetId=spreadsheet_id,
    valueInputOption='USER_ENTERED',
    range=worksheet_name + cell_range_insert,
    body=value_range_body
).execute()



service.spreadsheets().values().clear(
    spreadsheetId=spreadsheet_id,
    range='Half Caf Orders'
).execute()


worksheet_name = 'Half Caf Orders'
cell_range_insert = 'B2'
values = (
    ('Col A', 'Col B', 'Col C', 'Col D'),
    ('Apple', 'Orange', 'Watermelon', 'Banana')
)
value_range_body = {
    'majorDimension': 'COLUMNS',
    'values': values
}

service.spreadsheets().values().update(
    spreadsheetId=spreadsheet_id,
    valueInputOption='USER_ENTERED',
    range=worksheet_name + cell_range_insert,
    body=value_range_body
).execute()


"""
values.append
"""

worksheet_name = 'Half Caf Orders'
cell_range_insert = 'B2'
values = (
    ('Col E', 'Col F', 'Col G', 'Col H'),
    ('Toyota', 'Honda', 'Tesla', 'BMW')
)
value_range_body = {
    'majorDimension': 'COLUMNS',
    'values': values
}

service.spreadsheets().values().append(
    spreadsheetId=spreadsheet_id,
    valueInputOption='USER_ENTERED',
    range=worksheet_name + cell_range_insert,
    body=value_range_body
).execute()