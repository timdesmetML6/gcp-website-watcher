import os
import requests
from bs4 import BeautifulSoup
from mailjet_rest import Client

URL = os.environ.get('URL')
TARGET = os.environ.get('TARGET')
PUBLIC_KEY = os.environ.get('PUBLIC_KEY')
SECRET_KEY = os.environ.get('SECRET_KEY')
EMAIL = os.environ.get('EMAIL')

mailjet = Client(auth=(PUBLIC_KEY, SECRET_KEY), version='v3.1')


def hello_pubsub(event, context):
    page = requests.get(URL)
    soup = BeautifulSoup(page.content, 'html.parser')

    if TARGET not in str(soup):
        data = {
            'Messages': [
                {
                    "From": {
                        "Email": EMAIL,
                        "Name": EMAIL
                    },
                    "To": [
                        {
                            "Email": EMAIL,
                            "Name": EMAIL
                        }
                    ],
                    "Subject": "Your watcher has noticed a change!",
                    "TextPart": f"Website {URL} no longer contains: {TARGET}"
                }
            ]
        }

        result = mailjet.send.create(data=data)
        print(result.status_code)
    return 'OK'
