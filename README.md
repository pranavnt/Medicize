## Inspiration
We were inspired to build Medicize after reading a Washington Post article talking about the shortage of radiologists/pathologists in the United States (and the world). While smaller hospitals are able to take x-rays and get biopsies, many lack a qualified expert who can give a diagnosis based on the medical image (x-rays, CT scans).This shortage has had many detrimental impacts to the world, including false positives/negatives, increasing the wait-time in hospitals, and it overall has weakened the quality of healthcare throughout the world. To help strengthen the quality of healthcare during these turbulent times, our team developed Medicize.

## What it does
Medicize is a mobile application that uses Deep Learning (specifically Convolutional Neural Networks, also known as CNNs) to automate the analysis of medical images; specifically chest x-rays, biopsies, and microscopic slides. The user can take a picture of a medical image, and our program will process it and return whether the test was positive or negative. We developed 5 models (all CNNs) that we integrated into our application: COVID-19 diagnosis through a chest x-ray, pneumonia diagnosis through a chest x-ray, skin cancer diagnosis through a skin biopsy, malaria diagnosis through an image of a microscopic slide, and breast cancer diagnosis also through a biopsy. Our app enables doctors with access to medical technology but not trained pathologists to make a proper diagnosis.

## Why we chose a mobile platform
We chose to develop a mobile app as it is the most accessible and easy to use; a doctor can pull out their phone and take a picture of a medical image and Medicize will process it and give a diagnosis. Furthermore, a mobile platform enables any user, regardless of the quality of equipment they have, to use our technology.

## Control Flow
1. The user opens the app on their device
2. The user selects the the condition that they're testing for, and the app opens up a camera view.
3. The user takes a picture of the medical image, and our CNN (stored locally so the app can work in areas without reliable internet) makes a prediction on whether the test is positive or negative
4. The app alerts the user of the prediction, allowing them to take proper action.

## How we built it
We started off by finding medical datasets where it was hard to differentiate between a positive or negative test without proper training. After this, we performed necessary data augmentation using the CreateML framework for a few of our models. For our models where the data didn't require augmentation, we wrote the model in Python (using the keras library), and converted it to a CoreML format, which is what is compatible with apps in Swift. We then added our mlmodel to our project, and integrated it with our swift app.

## Challenges we ran into
The biggest challenge we ran into is that implementation in the real world is far different than the dataset that we're testing on. For example, a chest x-ray might be unclear in areas with lower-grade technology, it might be taken from a different angle, or it might be cropped. One of the biggest problems with AI in medical imaging is that the datasets used for training are far different that those used in the real world. To solve this challenge, we needed to perform data augmentation and train our CNN on the new augmented dataset. We initially spent a good amount of time trying to do that in Keras, however we ran into many issues, and chose to use Apple's CreateML framework when we were working with data augmentation. We then trained and tested our model on data that was cropped, rotated, and blurry to make our model work with data used in the real world.

## Accomplishments that we're proud of
1. We were able to connect a Convolutional Neural Network (CNN) written in Keras to CoreML, a framework compatible with Xcode.
2. We performed data augmentation to make our dataset match the use case, as we wanted our product development to be user-centered.
3. Four out of our five of our models had an F1 score which was greater than 0.85!
4. We had a fully functioning prototype in the end, that can be deployed and have a major social impact.

## What we learned
1. How to work as an effective team of students who live thousands of miles apart.
2. We learned about the biggest issues models face when entering production, and we learned how to perform data augmentation to avoid these issues.
3. We learned about metrics used to measure the accuracy of ML models relating to medicine; specifically the ROC curve and the F1 score.

## What's next for Medicize
There are three things that we want to do to accelerate Medicize.
1. We want to reach out to radiologists and pathologists and compare the accuracy of our model to that of radiologists. This will help us contextualize our model's accuracy.
2. We hope to publish this on the app store, so we can receive feedback on the app.
3. We want to add a segmentation model to the returned image, so a doctor can see which parts specifically are malignant. Doing this would increase trust in our program, as our model would explain "it's reasoning".

##Technologies Used
Programming Languages: Swift (for the application), Python (for one of our CNNs), and HTML/CSS/JS (for our landing page)
Libraries Used: Tensorflow, Keras, CoreML, Vision
IDEs: Xcode (Swift), Jupyter (Python), and VSCode (for the landing page)
Other Softwares Used: Photoshop (logo), Figma (UX design)
