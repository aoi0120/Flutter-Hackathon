import { db, auth } from "../firebase/firebase";
import { FieldValue, Timestamp } from "firebase-admin/firestore";

export const createUser = async ( Token: string ) => {
    const decoded = await auth.verifyIdToken(Token);

    const uid = decoded.uid;
    const name = decoded.name || '未設定';

    const userRef = db.collection("users").doc(uid);
    const userSnap = await userRef.get();

    const now = new Date();

    // 25時間前
    const gachaAt = new Date(now.getTime() - 25 * 60 * 60 * 1000);

    if (!userSnap.exists) {
        await userRef.set({
            name,
            create_at: FieldValue.serverTimestamp(),
            update_at: FieldValue.serverTimestamp(),
            tickets: [],
            gacha_at: Timestamp.fromDate(gachaAt),
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
        const ticketDoc = await db.collection('usersTicket').doc(uuid).get();
        if (ticketDoc.exists) {
            return [uuid, ticketDoc.data()];
        } else {
            return [uuid, null]; 
        } 
    });

    const ticketsEntries = await Promise.all(getTickets);
    const ticketsObject = ticketsEntries.reduce((acc, [uuid, data]) => {
        if (data) {
            acc[uuid as string] = data;
        }
        return acc;
    }, {} as Record<string, any>);

    const haveTicketsInfo = ticketsObject;
    return { haveTicketsInfo };
}

export const useTicket = async ( token: string, ticket_id: string ) => {
    const decoded = await auth.verifyIdToken(token);
    const uid = decoded.uid;

    const Ref = db.collection("userTickets").doc(ticket_id);
    const Doc = await Ref.get();

    if (Doc.data()?.uid !== uid ) {
        throw new Error("このチケットを使用する権限がありません");
    }

    return await Ref.update({
        effective: false
    });
}
