import secrets
import string

import jellyfish
from flask import Flask, request
from pymessenger.bot import Bot

ACCESS_TOKEN = 'EAAZAeEgcMLLsBAMymJYEFz6mtF3Qyz0hoUykZBIeYZAJjjteM7BZAeIBPLVozWsWDMZBadQwEEBi7keFPmTnBMfVJ83X5ZBwPmDStJVZAkLKMHkYNJ0geaqt25toPvx9Tf43L2lxdbYjCyBvwEO8pLBkztIu3bHTp4xLUifjHojez1bCxE0bRuDgHzA80MhkeUZD'  # Page Access Token
VERIFY_TOKEN = ''.join(
    secrets.choice(string.ascii_letters + string.digits) for _ in
    range(10))  # Verification Token

questions = (
    "The app if freezing after I click run button",
    "I don't know how to proceed with the invoice",
    "I get an error when I try to install the app",
    "It crash after I have updated it",
    "I cannot login in to the app",
    "I'm not able to download it"
)

answers = (
    "You need to clean up the cache. Please go to ...",
    "Please go to Setting, next Subscriptions and there is the Billing section",
    "Could you please send the log files placed in ... to ...",
    "Please restart your PC",
    "Use the forgot password button to setup a new password",
    "Probably you have an ad blocker plugin installed and it blocks the popup with the download link"
)

distance_threshold = 0.1

app = Flask(__name__)
bot = Bot(ACCESS_TOKEN)


@app.route("/", methods=['GET', 'POST'])
def receive_message():
    print("Received request: ")
    if request.method == 'GET':
        token_sent = request.args.get("hub.verify_token")
        return verify_fb_token(token_sent)
    output = request.get_json()
    for event in output['entry']:
        if 'messaging' in event:
            messaging = event['messaging']
            for message in messaging:
                if message.get('message'):
                    recipient_id = message['sender']['id']
                    text = message['message'].get('text')
                    if text:
                        response_sent_text = get_message(text)
                        send_message(recipient_id, response_sent_text)
            return "Message Processed"


def levenshtein_distance(sentence1, sentence2):
    distance = jellyfish.levenshtein_distance(sentence1, sentence2)
    normalized_distance = distance / max(len(sentence1), len(sentence2))
    return 1.0 - normalized_distance


def get_highest_similarity(customer_question):
    max_distance = 0
    highest_index = 0
    for question_id in range(len(questions)):
        current_distance = levenshtein_distance(customer_question,
                                                questions[question_id])
        if current_distance > max_distance:
            highest_index = question_id
            max_distance = current_distance
    if max_distance > distance_threshold:
        return answers[highest_index]
    print(
        "Unknown question " + customer_question + ", calculated max_distance: " + max_distance)
    return "The issues has been saved. We will contact you soon."


def verify_fb_token(token_sent):
    if token_sent == VERIFY_TOKEN:
        return request.args.get("hub.challenge")
    return 'Invalid verification token'


def get_message(message):
    print("Received msg: " + message)
    print("Predicated response: " + get_highest_similarity(message))
    response = get_highest_similarity(
        message)  # "Hi! Here is Greg, your advisor. How can I help you?"
    return response


def send_message(recipient_id, response):
    bot.send_text_message(recipient_id, response)
    return "success"


if __name__ == "__main__":
    print("Expected token: " + VERIFY_TOKEN)
    app.run(host="0.0.0.0", port=5000)
