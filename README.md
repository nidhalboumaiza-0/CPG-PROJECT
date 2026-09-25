# CPG Internship Management

Full-stack internship management application created for CPG. It helps administrators manage interns, supervisors, institutes, assignments, and attendance from a Flutter client backed by an Express API.

## Features

- Administrator authentication
- Intern, supervisor, and institute management
- Assignment of interns to supervisors
- Attendance and absence tracking
- Profile image uploads

## Architecture

```text
client/  Flutter mobile application
server/  Node.js, Express, and MongoDB API
```

## Getting Started

Start the API:

```bash
cd server
npm install
npm test
```

Start the mobile client in another terminal:

```bash
cd client
flutter pub get
flutter run
```

Configure the server's MongoDB, JWT, mail, upload, and port values locally. Update the Flutter API endpoint for the machine or emulator running the backend.
