## Avi's Updates

We're currently adding in two buttons to the leftButtonView of the input toolbar in order to display the camera and gallery icons. Using that, we're displaying a collectionView above the UITextField that displays a series of images the user has selected.

So far, the DemoJSQApp has basic functionality. We need to implement the same functionality for the mobileapp. 

## Things to do

- There seems to be an issue with the UICollectionView.xib file being loading in the mobileapp. Take a look into what needs to be fixed there. 
- There is no 'x' icon on the UICollectionView - that needs to be added in to the top right corner and given the respective functionality
- After importing this pod file, we need to link the fusuma pod that currently gets the images and pass that into the 'images' array that's present in the pod. Then call the collectionView.reloadData to show those images. 
- After that's done, add the functionaltiy to remove the image from the collectionView
- Make sure to hide the collectionView on display - right now it's showing right when the messages view opens up, need to set initial height of collection view to 0. 

Good luck with this feature - may the force be with you. 
