import * as admin from "firebase-admin";
import dotenv from "dotenv";

dotenv.config();

const requiredEnvKeys = [
    "FIREBASE_TYPE",
    "FIREBASE_PROJECT_ID",
    "FIREBASE_PRIVATE_KEY_ID",
    "FIREBASE_PRIVATE_KEY",
    "FIREBASE_CLIENT_EMAIL",
    "FIREBASE_CLIENT_ID",
    "FIREBASE_AUTH_URI",
    "FIREBASE_TOKEN_URI",
    "FIREBASE_AUTH_PROVIDER_X509_CERT_URL",
    "FIREBASE_CLIENT_X509_CERT_URL",
    "FIREBASE_UNIVERSE_DOMAIN",
];

const missing = requiredEnvKeys.filter((k) => !process.env[k]);
if (missing.length > 0) {
    throw new Error(`環境変数が不足しています: ${missing.join(", ")}`);
}

const privateKeyRaw = process.env.FIREBASE_PRIVATE_KEY as string;
const privateKey = privateKeyRaw
    .replace(/\\n/g, "\n")
    .replace(/\r\n/g, "\n");

const serviceAccount = {
    type: process.env.FIREBASE_TYPE as string,
    project_id: process.env.FIREBASE_PROJECT_ID as string,
    private_key_id: process.env.FIREBASE_PRIVATE_KEY_ID as string,
    private_key: privateKey,
    client_email: process.env.FIREBASE_CLIENT_EMAIL as string,
    client_id: process.env.FIREBASE_CLIENT_ID as string,
    auth_uri: process.env.FIREBASE_AUTH_URI as string,
    token_uri: process.env.FIREBASE_TOKEN_URI as string,
    auth_provider_x509_cert_url: process.env.FIREBASE_AUTH_PROVIDER_X509_CERT_URL as string,
    client_x509_cert_url: process.env.FIREBASE_CLIENT_X509_CERT_URL as string,
    universe_domain: process.env.FIREBASE_UNIVERSE_DOMAIN as string,
};

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

export const db = admin.firestore();
export const auth = admin.auth();