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

## Run Locally

1. Install Node.js 18 or newer, Flutter, and MongoDB. Start MongoDB locally or prepare a MongoDB Atlas connection.
2. Open a terminal in `server/` and install the API dependencies:

   ```bash
   cd server
   npm install
   ```

3. Create `server/.env`. Port `3006` matches the URL currently used by `client/lib/constants.dart`:

   ```dotenv
   NODE_ENV=development
   PORT=3006
   DATABASE=mongodb://127.0.0.1:27017/cpg
   JWT_SECRET=replace-with-a-long-random-value
   JWT_EXPIRE_IN=1d
   EmailMailer=your-smtp-host
   PORTMAILER=587
   USERMAILER=your-development-email
   PASSWORDMAILER=your-email-app-password
   ```

4. The package currently has no valid `start` script, so launch its real entry point directly:

   ```bash
   npx nodemon server.js
   ```

5. In `client/lib/constants.dart`, set `Kurl` to an address the device can reach. Use `http://10.0.2.2:3006` for an Android emulator, `http://localhost:3006` for desktop, or the computer's LAN IP for a physical phone.
6. Open another terminal and prepare the Flutter client:

   ```bash
   cd client
   flutter pub get
   flutter devices
   ```

7. Run the mobile application:

   ```bash
   flutter run
   ```

Keep credentials in `server/.env` and do not commit production secrets.
