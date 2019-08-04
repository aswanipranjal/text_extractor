import json
import logging
import os

from flask import Flask, request
from werkzeug.utils import secure_filename

from utils import get_store_name_from_text, get_items, load_data, sharpen_image
from vision_api_sample import get_full_text_annotation

PROJECT_HOME = os.path.dirname(os.path.realpath(__file__))
UPLOAD_FOLDER = '{}/uploads/'.format(PROJECT_HOME)
PROJECT_HOME = os.path.dirname(os.path.realpath(__file__))

FOOD_WORDS = '{}/food_words_cleaned.txt'.format(PROJECT_HOME)
GROCERY_WORDS = '{}/grocery_words_cleaned.txt'.format(PROJECT_HOME)

file_handler = logging.FileHandler('server.log')

application = Flask(__name__)
application.logger.addHandler(file_handler)
application.logger.setLevel(logging.INFO)
application.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

data_dict = None


def init_data():
    global data_dict
    data_dict = load_data(FOOD_WORDS, "food")
    data_dict.update(load_data(GROCERY_WORDS, "grocery"))


def create_new_folder(local_dir):
    newpath = local_dir
    if not os.path.exists(newpath):
        os.makedirs(newpath)
    return newpath


def detect_entities(text, data_dict):
    entities = dict()
    entities['store'] = get_store_name_from_text(text)
    entities['items'] = get_items(text, data_dict)
    return entities


@application.route("/")
def hello():
    return "<h1 style='color:blue'>Hello There!</h1>"


@application.route('/upload', methods=['POST'])
def api_root():
    application.logger.info(PROJECT_HOME)
    if request.method == 'POST' and request.files['image']:
        application.logger.info(application.config['UPLOAD_FOLDER'])
        img = request.files['image']
        img_name = secure_filename(img.filename)
        create_new_folder(application.config['UPLOAD_FOLDER'])
        saved_path = os.path.join(application.config['UPLOAD_FOLDER'], img_name)
        application.logger.info("saving {}".format(saved_path))
        img.save(saved_path)
        sharpen_image(saved_path)
        # return send_from_directory(application.config['UPLOAD_FOLDER'], img_name, as_attachment=True)
        return json.dumps(detect_entities(get_full_text_annotation(saved_path), data_dict))
    else:
        return "Where is the image?"


if __name__ == '__main__':
    if not data_dict:
        init_data()
    application.run(host='0.0.0.0', debug=True)
