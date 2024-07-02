# Compfest SEA Salon

This is a project as the technical challange for Software Engineering Academy, Compfest, registration. This project is a salon website. 

In this website, you can view the services and leave a review in the home page. From there, you can either sign in, if you haven't already done it before, or login to your accounr from the database. After login or sign in, you will directed to your dascboard page where only after that you can make a reservation and look at you reservation histories. 

This project is using flutter as a frontend and firebase-firestore, database, service as the backend. 

## Visit the web

Link to the github pages -> https://nicolas5143.github.io/tugas_compfestsea/

Repo for the deployed web -> https://github.com/nicolas5143/tugas_compfestsea

## App preview

### Desktop 

homepage

<img width="908" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/40f6bab5-7164-47b2-8fea-5a862e2a27a0">
<img width="904" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/f7b41578-66e4-4414-9692-60f8c5735026">
<img width="958" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/ba1cc0a0-9154-4fa3-8c4a-f31d73c51b34">

login page

<img width="959" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/156fcc2a-ee0f-48d6-8bf1-bd9a79e8ba63">

sign in page

<img width="959" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/f2a98ba0-b857-478d-ab25-bf8b83e89230">

dashboard page

<img width="959" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/71c034c6-147d-4b10-ad13-a4108650397b">

### Mobile 

homepage

<img width="379" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/b3443e42-deaf-4316-a6a3-83a8a57dfa4d">
<img width="375" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/25a00c3b-54ee-4ab7-9a45-4f208d1a5861">
<img width="378" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/738defdc-a339-4139-a080-a77849520c06">

login page

<img width="374" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/6cc07a5b-228e-4e97-8ef9-9e88c9e82830">

sign in page

<img width="374" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/a65cf3e8-339a-4cd5-8309-ac4fa29c5569">

dashboard page

<img width="373" alt="image" src="https://github.com/nicolas5143/project_tugas_compfestsea/assets/140360591/2efd4743-11f2-418a-93c2-bda25bd8de1a">

## To run in your machine

You need to set flutter and firebase configuration:
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase project: [Set up a Firebase project](https://firebase.google.com/)

1. Clone the repository:
   ```sh
   git clone https://github.com/nicolas5143/project_tugas_compfestsea.git
2. Install dependencies for flutter:
   ```sh
   flutter pub get
3. Set up firebase configuration:
   - Go to your Firebase Console and create a new project (or use an existing one).
   - Add a web app to your Firebase project to get your Firebase configuration details.
4. Run the web:
   ```sh
   flutter run -d chrome
