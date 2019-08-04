import cv2
import numpy as np
from postal.parser import parse_address


def load_data(file_name, category):
    with open(file_name) as file:
        data = file.readlines()
    data_dict = dict()
    for item in data:
        data_dict[item.lower().strip()] = category
    return data_dict


def get_store_name_from_text(text):
    address = parse_address(text)
    for item, kind in address:
        if kind == "house":
            return item


def get_items(text, data_dict):
    text_data = text.lower().split("\n")
    tagged_sentences = list()
    for sentence in text_data:
        for word in sentence.split(" "):
            if word in data_dict.keys():
                tagged_sentences.append({"entity": sentence, "category": data_dict[word]})
                break
    return tagged_sentences


def sharpen_image(image_file):
    # Linux window/threading setup code.
    cv2.startWindowThread()
    # Load source / input image as grayscale, also works on color images...
    imgIn = cv2.imread(image_file, cv2.IMREAD_GRAYSCALE)

    # Create the identity filter, but with the 1 shifted to the right!
    kernel = np.zeros((9, 9), np.float32)
    kernel[4, 4] = 2.0  # Identity, times two!

    # Create a box filter:
    boxFilter = np.ones((9, 9), np.float32) / 81.0

    # Subtract the two:
    kernel = kernel - boxFilter
    custom = cv2.filter2D(imgIn, -1, kernel)
    cv2.imwrite(image_file, custom)
