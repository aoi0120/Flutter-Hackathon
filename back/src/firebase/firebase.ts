import * as admin from "firebase-admin";
import { ServiceAccount } from "firebase-admin";

import serviceAccount from "../../flutterhack-83b12-firebase-adminsdk-fbsvc-acc6039fba.json";

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as ServiceAccount),
});

export const db = admin.firestore();
export const auth = admin.auth();