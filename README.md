# Flutter-django-postgressql-Chat-Application

This is basic chat application developed with flutter and django with only basic chat features.This application have the feature of translating messages in some seleted languages.Also this app packs with a project management tool where users can create project by adding members,adding requirements,adding tasks reelated to requirements and assigning to members
## Features
1. Otp Authentication
2. Add friends 
3. Chat with friends
4. Accept or reject friend requests
5. Search for users
6. Translate messages in chatroom
7. Create project
8. Update tasks assigned
9. Review Project completion level


## How to Run?

### Setup backend server before running
1. Open backend folder in vscode.
2. Create a virtual environment for python.
3. Activate the virtual environment.
4. Hit “cd chatapp” and enter in vscode shell
5. Hit “pip install -r requirements.txt” and enter in vscode shell to add dependencies
6. Set up database(The app is configured for postgressql you can change it in settings.py)
7. Add username,password of your db in settings.py DATABASES variable(not needed if default database of django is using)
    8. Open account in twilio and get a free phone number.
    9. Add Twilio credentials in last portion of settings.py in already declared variables.(Twilio is used here to send otp you can obtain your twilio credentials from twilio account page).
    10. Hit “python3 manage.py runserver”.
### FrontEnd
1. run flutter

## Things to be remembered:

1. The frontend of this app is connected to backend using localhost you can change the root variables if planning to host the backend
2. Twilio and Translator uses internet connection so make sure you have a stable internet connection

## Screens
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/54d8cf1e-67e8-4c04-977f-089ac3cee24f" width=100px height=400px>



       
