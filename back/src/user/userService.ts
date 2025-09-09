import { db, auth } from "../firebase/firebase";

export const createUser = async ( Token: string ) => {
    const decoded = await auth.verifyIdToken(Token);

    const uid = decoded.uid;
    const name = decoded.name || '未設定';

    return await db.collection('users').doc(uid).set(
        {
            name,
            create_at: new Date(),
            tickets: [],
        }
    );
};
