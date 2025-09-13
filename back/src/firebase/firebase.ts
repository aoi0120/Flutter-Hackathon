import * as admin from "firebase-admin";
import dotenv from "dotenv";

dotenv.config();

const requiredEnvKeys = [
    "type",
    "project_id",
    "private_key_id",
    "private_key",
    "client_email",
    "client_id",
    "auth_uri",
    "token_uri",
    "auth_provider_x509_cert_url",
    "client_x509_cert_url",
    "universe_domain",
];

const missing = requiredEnvKeys.filter((k) => !process.env[k]);
if (missing.length > 0) {
    throw new Error(`環境変数が不足しています: ${missing.join(", ")}`);
}

const privateKeyRaw = process.env.private_key as string;
const privateKey = privateKeyRaw
    .replace(/\\n/g, "\n")
    .replace(/\r\n/g, "\n");

const serviceAccount = {
    type: process.env.type as string,
    project_id: process.env.project_id as string,
    private_key_id: process.env.private_key_id as string,
    private_key: privateKey,
    client_email: process.env.client_email as string,
    client_id: process.env.client_id as string,
    auth_uri: process.env.auth_uri as string,
    token_uri: process.env.token_uri as string,
    auth_provider_x509_cert_url: process.env.auth_provider_x509_cert_url as string,
    client_x509_cert_url: process.env.client_x509_cert_url as string,
    universe_domain: process.env.universe_domain as string,
};

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

export const db = admin.firestore();
export const auth = admin.auth();