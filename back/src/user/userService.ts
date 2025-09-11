import { db, auth } from "../firebase/firebase";
import { FieldValue } from "firebase-admin/firestore";

export const createUser = async ( Token: string ) => {
    const decoded = await auth.verifyIdToken(Token);

    const uid = decoded.uid;
    const name = decoded.name || '未設定';

    const userRef = db.collection("users").doc(uid);
    const userSnap = await userRef.get();

    if (!userSnap.exists) {
        await userRef.set({
            name,
            create_at: FieldValue.serverTimestamp(),
            update_at: FieldValue.serverTimestamp(),
            tickets: [],
        });
        return { message: "新規登録完了"};
    } else {
        await userRef.update({
            update_at: FieldValue.serverTimestamp(),
        });
    }
};

export const updateName = async ( Token: string, newName:string ) => {
    const decoded = await auth.verifyIdToken(Token);
    const uid = decoded.uid;

    return await db.collection('users').doc(uid).update(
        { name: newName }
    );
}
