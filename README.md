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
