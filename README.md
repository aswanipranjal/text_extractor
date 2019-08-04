# text_extractor
A simple service to extract text out of receipts

This project is a part of the whole project created to compete in Bootstrap Paradox hackathon


To set up the text extracting part, please do the following:
- We suggest that you create a virtual environment for this project so as to contain the dependencies:
```
$ git clone https://github.com/aswanipranjal/text_extractor.git
$ virtualenv --python=<any python 3 version> text_extractor
$ cd text_extractor
$ source bin/activate
```
- We are using Google's vision API to detect text in images, so to run the project, you'll need to go through this document to get the
required credentials: [https://cloud.google.com/vision/docs/before-you-begin](https://cloud.google.com/vision/docs/before-you-begin)
- We are using `libpostal` to detect addresses, so you'll also need to install [libpostal](https://github.com/openvenues/libpostal)
- Then download the required packages to run this:
```
pip install -r requirements.txt
```
- Once the above all steps are done, run the app using:
```
python app.py
```
- You can upload the files by opening the [https://github.com/aswanipranjal/text_extractor/blob/master/frontend/index.html](https://github.com/aswanipranjal/text_extractor/blob/master/frontend/index.html)
HTML page

-------------

What happens when you upload an image:
- The image is sent to the google vision API and the whole text which could be detected by that model is returned
- We parse the text and try to extract out Store name by extracting the address from the text (store name = house)
- We also have a dictionary of `food` and `grocery` words which we load at the start
- Once the store name has been identified, we then go through each sentence (split using `\n`) and separate the sentences containing words in the dictionary
- Once store and items have been identified, we return a json file containing the same

--------------

### What the ideal flow should've been:
- The user uploads an image
- That image is processed and the text in that image is returned as explained above
- The user is then shown the text and asked if they want to change/modify any sentence/word
- Once the user is satisfied with the output for the image, they submit the data
- That data is then stored in the catalog ready to be searched on the basis of items or stores
