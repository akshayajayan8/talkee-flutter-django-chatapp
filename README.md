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
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/54d8cf1e-67e8-4c04-977f-089ac3cee24f" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/154d45b7-a738-4f14-a55c-e7054ea7b486" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/0207ae6c-7735-4f41-9c9d-528e63e2b158" width=200px height=500px>

<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/64507efa-bd1e-4978-be66-5fb051911be3" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/2ff18d15-2ca4-44d7-b435-bf07e6c0ee2c" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/27c4e87c-aedc-426e-b657-b8891521c558" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/ec47eb3f-3239-4f5a-a8d8-ffeeaff29403" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/3936c524-61f5-4a96-9d3f-2576f449eec2" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/94129541-4fdd-4b34-8224-535636a375d9" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/d11a5257-3be3-4a70-a840-6f41a6c97b2c" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/e1f9f87d-4ffe-4d98-b335-e1bed65442be" width=200px height=500px>
<img src="https://github.com/akcoder8/talkee-flutter-django-chatapp/assets/146500418/d3a50050-a956-4ce1-84b7-4b7af37e2dbb" width=200px height=500px>





       
