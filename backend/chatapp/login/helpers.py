from chatapp import settings
from twilio.rest import Client
import random


def send_otp_phone(phone_number):
        phone_number="+91"+phone_number
        client=Client(settings.TWILIO_ACC_SID,settings.TWILIO_AUTH_TOKEN)
        otp=str(random.randint(100000,999999))
        message=client.messages.create(
                from_=settings.TWILIO_PHONE,
                body="Your one time password for Talkee:"+otp,
                to=phone_number
        )
        print("Your one time password for Talkee:"+otp)
        return otp
        

