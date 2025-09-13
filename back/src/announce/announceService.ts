import { db, } from "../firebase/firebase";
import { firestore } from "firebase-admin";
import { Timestamp } from "firebase-admin/firestore";
import jwt from "jsonwebtoken";

export const createAnnounce = async (announceName:string,announceSummary:number,event_at:string, token: string) => {

    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { id: string; email: string };
    const email = decoded.id;

    if ( email !== "ishibashi@gmail.com" ) {
        return ({ message: "お知らせを作成する権限がありません"});
    }

    //title,summaryが来た時点で自動作成
    //event_at(string)をDateに変換してタイムスタンプに
    const time_now = firestore.Timestamp.now();
    await db.collection('announcement').add({
        title: announceName,
        summary: announceSummary,
        event_at: Timestamp.fromDate(new Date(event_at)),
        created_at: time_now,
        updated_at: time_now,
    });    
}

export const getAnnounce = async () => {
    //firebaseのannouncementのお知らせを収集
    const announceAll = await db.collection('announcement').get();
    if(announceAll.empty){
        return[];
    }
    const result:any = [];
    announceAll.forEach(doc => {
        result.push({
            title: doc.data().title,
            summary: doc.data().summary,
            event_at: doc.data().event_at,
            created_at: doc.data().created_at,
            updated_at: doc.data().updated_at,
        //他のがあれば追加
        });
    });
    return result;
}