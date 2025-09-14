import { FieldValue, Timestamp, } from "firebase-admin/firestore";
import { db } from "../firebase/firebase";
import jwt from "jsonwebtoken";

export const gachapon = async (token: string) => {
    try {
        console.log('=== ガチャ開始 ===');
        console.log('JWT_SECRET存在確認:', !!process.env.JWT_SECRET);

        const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { uid: string, role: string };
        const uid = decoded.uid;
        console.log('ユーザーID:', uid);

        const doc = await db.collection('users').doc(uid).get();
        console.log('ユーザードキュメント存在:', doc.exists);

        const gachaAt = doc.get("gacha_at")?.toDate();
        const now = new Date();
        console.log('ガチャ時刻:', gachaAt);
        console.log('現在時刻:', now);

        if (gachaAt) {
            const ms = now.getTime() - gachaAt.getTime();
            const hours = ms / (1000 * 60 * 60);
            console.log('経過時間（時間）:', hours);

            // if (hours < 24) {
            //     const remainingTime = Math.ceil(24 - hours)
            //     console.log('24時間以内 - 残り時間:', remainingTime);
            //     return { message: `あと${remainingTime}時間後にガチャを引けます` };
            // }

            console.log('ストアデータ取得開始');
            const storedb = db.collection("stores");
            const stores = await storedb.get();
            console.log('ストア数:', stores.size);

            if (stores.empty) {
                console.log('ストアデータが空');
                return { message: "ストアデータがありません" };
            }

            const storeArray = stores.docs.map(doc => doc.id);
            const store_id = storeArray[Math.floor(Math.random() * storeArray.length)];
            console.log('選択されたストアID:', store_id);

            const percent = await db.collection("stores").doc(store_id).get();
            const storePercent = percent.data()?.percent || 0;
            console.log('ストア当選確率:', storePercent);

            const rand = Math.random() * 100;
            let result;
            console.log('ランダム値:', rand);

            if (rand < storePercent) {
                result = "当たり";
                console.log('当たり！');
            } else {
                result = "外れ";
                console.log('外れ');
                return { message: "はずれ", result: "外れ" };
            }

            console.log('チケット検索開始 - ストアID:', store_id);
            const queryTickets = await db.collection("tickets")
                .where("store_id", "==", store_id)
                .get();

            console.log('該当チケット数:', queryTickets.size);

            if (queryTickets.empty) {
                console.log('該当ストアのチケットが空');
                return { message: "該当ストアのチケットがありません" };
            }

            const tickets = queryTickets.docs.map(doc => doc.id);
            const selectTicket = tickets[Math.floor(Math.random() * tickets.length)];
            console.log('選択されたチケットID:', selectTicket);

            const Ticket = await db.collection("tickets").doc(selectTicket).get();
            const TicketInfo: any = Ticket.data();
            console.log('チケット情報:', TicketInfo);

            if (!TicketInfo) {
                console.log('チケット情報がnull');
                return { message: "チケット情報の取得に失敗しました" };
            }

            const storeNameRef = await db.collection("stores").doc(store_id);
            const storeNameDoc = await storeNameRef.get();
            const store_name = storeNameDoc.data()?.name;
            console.log('ストア名:', store_name);

            console.log('ユーザーチケット作成開始');
            const expirationDate = new Date(TicketInfo.expiration_at);
            if (isNaN(expirationDate.getTime())) {
                console.log('無効な日付のため、30日後に設定');
                expirationDate.setTime(Date.now() + 30 * 24 * 60 * 60 * 1000);
            }

            const createUserTicket: any = await db.collection("userTicket").add({
                store_name: store_name,
                user_id: uid,
                prize: TicketInfo.prize,
                expiration_at: Timestamp.fromDate(expirationDate),
                effective: true
            });

            const userTicket_id = createUserTicket.id;
            console.log('ユーザーチケットID:', userTicket_id);

            console.log('ユーザー情報更新開始');
            await db.collection("users").doc(uid).update({
                gacha_at: Timestamp.fromDate(now),
                tickets: FieldValue.arrayUnion(userTicket_id)
            });

            console.log('ガチャ完了 - 結果:', result);
            return { result, userTicket_id: TicketInfo.prize, store_id };
        } else {
            console.log('初回ガチャ - gacha_atが存在しない');
            return { message: "初回ガチャです。24時間後に再実行してください。" };
        }
    } catch (error: any) {
        console.error('=== ガチャ実行エラー詳細 ===');
        console.error('エラー:', error);
        console.error('エラーメッセージ:', error.message);
        console.error('エラースタック:', error.stack);
        throw new Error(`ガチャ実行に失敗しました: ${error.message}`);
    }
}