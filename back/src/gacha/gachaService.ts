import { FieldValue, Timestamp, } from "firebase-admin/firestore";
import { db } from "../firebase/firebase";
import jwt from "jsonwebtoken";

export const gachapon = async (token: string) => {
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { uid: string, role: string };
        const uid = decoded.uid;

        const doc = await db.collection('users').doc(uid).get();

        const gachaAt = doc.get("gacha_at")?.toDate();
        const now = new Date();

        if (gachaAt) {
            const ms = now.getTime() - gachaAt.getTime();
            const hours = ms / (1000 * 60 * 60);

            if (hours < 24) {
                const remainingTime = Math.ceil(24 - hours)
                return { message: `あと${remainingTime}時間後にガチャを引けます` };
            }

            const storedb = db.collection("stores");
            const stores = await storedb.get();

            if (stores.empty) {
                return { message: "ストアデータがありません" };
            }

            const storeArray = stores.docs.map(doc => doc.id);
            const store_id = storeArray[Math.floor(Math.random() * storeArray.length)];

            const percent = await db.collection("stores").doc(store_id).get();
            const storePercent = percent.data()?.percent || 0;


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

            if (queryTickets.empty) {
                return { message: "該当ストアのチケットがありません" };
            }

            const tickets = queryTickets.docs.map(doc => doc.id);
            const selectTicket = tickets[Math.floor(Math.random() * tickets.length)];

            const Ticket = await db.collection("tickets").doc(selectTicket).get();
            const TicketInfo: any = Ticket.data();

            if (!TicketInfo) {
                return { message: "チケット情報の取得に失敗しました" };
            }

            const storeNameRef = await db.collection("stores").doc(store_id);
            const storeNameDoc = await storeNameRef.get();
            const store_name = storeNameDoc.data()?.name;


            const createUserTicket: any = await db.collection("userTicket").add({
                store_name: store_name,
                user_id: uid,
                prize: TicketInfo.prize,
                expiration_at: Timestamp.fromDate(new Date(TicketInfo.expiration_at)),
                effective: true
            });

            const userTicket_id = createUserTicket.id;

            await db.collection("users").doc(uid).update({
                gacha_at: Timestamp.fromDate(now),
                tickets: FieldValue.arrayUnion(userTicket_id)
            });

            return { result, userTicket_id: TicketInfo.prize, store_id };
        } else {
            // 初回ガチャの場合
            return { message: "初回ガチャです。24時間後に再実行してください。" };
        }
    } catch (error) {
        console.error('ガチャ実行エラー:', error);
        throw new Error(`ガチャ実行に失敗しました: ${error}`);
    }
}
