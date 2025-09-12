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

export const addTicket = async ( token: string, ticketUuid:string ) => {
    const decoded = await auth.verifyIdToken(token);
    const uid = decoded.uid;

    return await db.collection('users').doc(uid).update({
        tickets:  FieldValue.arrayUnion( ticketUuid )
    });
};

export const userHaveTickets = async ( token: string,) => {
    const decoded = await auth.verifyIdToken(token);
    const uid = decoded.uid;

    const doc = await db.collection('users').doc(uid).get();

    const tickets: string[] = doc.get("tickets") || [] ;

    return tickets;
}

export const ticketsInfo = async ( userHaveTickets: string[] ) => {
    if (userHaveTickets.length === 0) {
        return ({ message: "所持チケットはありません" });
    }
    const getTickets = userHaveTickets.map( async (uuid: string) => {
        const ticketDoc = await db.collection('tickets').doc(uuid).get();
        if (ticketDoc.exists) {
            return [uuid, ticketDoc.data()];
        } else {
            return [uuid, null]; // 存在しなかった場合
        } 
    });

    const ticketsEntries = await Promise.all(getTickets);
      // Object に変換して返す
        const ticketsObject = ticketsEntries.reduce((acc, [uuid, data]) => {
            if (data) {
                acc[uuid as string] = data;
            }
            return acc;
        }, {} as Record<string, any>);

    return { message: "所持チケット取得成功", tickets: ticketsObject };
}
