import { FieldValue, Timestamp, } from "firebase-admin/firestore";
import { db, auth } from "../firebase/firebase";

export const gachapon = async (token: string) => {
    const decoded = await auth.verifyIdToken(token);
    const uid = decoded.uid;

    const doc = await db.collection('users').doc(uid).get();
    
    const gachaAt = doc.get("gacha_at")?.toDate();
    const now = new Date();

    if ( gachaAt ) {
        const ms = now.getTime() - gachaAt.getTime();
        const hours = ms /  (1000 * 60 * 60);

        if (hours < 24) {
            const remainingTime = Math.ceil(24 - hours)
            return { message: `あと${remainingTime}時間後にガチャを引けます`};
        }

        const storedb = db.collection("stores");
        const stores = await storedb.get();

        const storeArray = stores.docs.map(doc => doc.id);

        const store_id = storeArray[Math.floor(Math.random() * storeArray.length)];

        const percent = await db.collection("stores").doc(store_id).get();
        const storePercent = percent.data()?.percent;


        const rand = Math.random() * 100; 
        let result;

        if (rand < storePercent) {
            result = "当たり"; 
        } else {
            result = "外れ"; 
            return { message: "はずれ" };
        }

        const queryTickets = await db.collection("tickets")
            .where("store_id", "==", store_id)
            .get();

        const tickets = queryTickets.docs.map(doc => doc.id);

        const selectTicket = tickets[ Math.floor( Math.random() * tickets.length ) ];

        const Ticket = await db.collection("tickets").doc(selectTicket).get();
        const TicketInfo:any = Ticket.data();

        
        const createUserTicket: any = await db.collection("userTicket").add({
            store_id: store_id,
            user_id: uid,
            prize: TicketInfo.prize,
            expiration_at: Timestamp.fromDate( new Date( TicketInfo.expiration_at )),
            effective: true
        });

        const userTicket_id = createUserTicket.id;

        await db.collection("users").doc(uid).update({
            gacha_at: Timestamp.fromDate(now),
            tickets: FieldValue.arrayUnion(createUserTicket.id)
        });

        return { result, userTicket_id: TicketInfo.prize, store_id };
    };
}
