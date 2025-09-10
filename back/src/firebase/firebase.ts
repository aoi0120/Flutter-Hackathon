import * as admin from "firebase-admin";
import dotenv from "dotenv";
import fs from "fs";

dotenv.config();

const serviceAccountPath = process.env.FIREBASE_KEY_PATH;

if (!serviceAccountPath) {
    throw new Error(".envにキーがない");
}

const serviceAccount = JSON.parse(
    fs.readFileSync(serviceAccountPath, "utf-8")
);

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

export const db = admin.firestore();
export const auth = admin.auth();