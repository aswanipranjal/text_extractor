import glob
import io
from enum import Enum

import cv2
import numpy as np
from PIL import Image, ImageDraw
from google.cloud import vision
from google.cloud.vision import types

# [END vision_document_text_tutorial_imports]

in_folder = "/Users/pranjal/Halodoc/data/hackathon/Sharpen_bill12.jpeg"
out_folder = "/Users/pranjal/Halodoc/data/hackathon/hackday/{}/out/{}.jpeg"


class FeatureType(Enum):
    PAGE = 1
    BLOCK = 2
    PARA = 3
    WORD = 4
    SYMBOL = 5


def draw_boxes(image, bounds, color):
    """Draw a border around the image using the hints in the vector list."""
    draw = ImageDraw.Draw(image)

    for bound in bounds:
        draw.polygon([
            bound.vertices[0].x, bound.vertices[0].y,
            bound.vertices[1].x, bound.vertices[1].y,
            bound.vertices[2].x, bound.vertices[2].y,
            bound.vertices[3].x, bound.vertices[3].y], None, color)
    return image


def get_full_text_annotation(image_file):
    client = vision.ImageAnnotatorClient()
    with io.open(image_file, 'rb') as image_file:
        content = image_file.read()

    image = types.Image(content=content)

    response = client.document_text_detection(image=image)
    return response.full_text_annotation.text


def get_document_bounds(image_file, feature):
    # [START vision_document_text_tutorial_detect_bounds]
    """Returns document bounds given an image."""

    bounds = []

    document = get_full_text_annotation(image_file)

    # Collect specified feature bounds by enumerating all document features
    for page in document.pages:
        for block in page.blocks:
            for paragraph in block.paragraphs:
                for word in paragraph.words:
                    for symbol in word.symbols:
                        if (feature == FeatureType.SYMBOL):
                            bounds.append(symbol.bounding_box)

                    if (feature == FeatureType.WORD):
                        bounds.append(word.bounding_box)

                if (feature == FeatureType.PARA):
                    bounds.append(paragraph.bounding_box)

            if (feature == FeatureType.BLOCK):
                bounds.append(block.bounding_box)

        if (feature == FeatureType.PAGE):
            bounds.append(block.bounding_box)

    # The list `bounds` contains the coordinates of the bounding boxes.
    # [END vision_document_text_tutorial_detect_bounds]
    return bounds


def sharpen_image(image_file):
    cv2.startWindowThread()
    cv2.namedWindow("Original")
    cv2.namedWindow("Sharpen")

    # Load source / input image as grayscale, also works on color images...
    imgIn = cv2.imread(image_file, cv2.IMREAD_GRAYSCALE)
    cv2.imshow("Original", imgIn)

    # Create the identity filter, but with the 1 shifted to the right!
    kernel = np.zeros((9, 9), np.float32)
    kernel[4, 4] = 2.0  # Identity, times two!

    # Create a box filter:
    boxFilter = np.ones((9, 9), np.float32) / 81.0

    # Subtract the two:
    kernel = kernel - boxFilter

    # Note that we are subject to overflow and underflow here...but I believe that
    # filter2D clips top and bottom ranges on the output, plus you'd need a
    # very bright or very dark pixel surrounded by the opposite type.

    custom = cv2.filter2D(imgIn, -1, kernel)
    cv2.imwrite("Sharpen_{}.jpeg".format(bill), custom)


def render_doc_text(filein, fileout):
    image = Image.open(filein)
    bounds = get_document_bounds(filein, FeatureType.PAGE)
    draw_boxes(image, bounds, 'blue')
    bounds = get_document_bounds(filein, FeatureType.PARA)
    draw_boxes(image, bounds, 'red')
    # bounds = get_document_bounds(filein, FeatureType.WORD)
    # draw_boxes(image, bounds, 'yellow')

    if fileout is not 0:
        image.save(fileout)
    else:
        image.show()


if __name__ == '__main__':
    electronic_words = list()
    for in_file in glob.glob(in_folder.format("food")):
        file_name = in_file.split(".")[0].split("/")[-1]
        out_file = out_folder.format("food", file_name)
        print("parsing: ", in_file)
        # render_doc_text(in_file, out_file)
        words = get_full_text_annotation(in_file)
        print(words)
        break
        # electronic_words.append(words)
