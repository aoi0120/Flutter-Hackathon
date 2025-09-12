import { title } from "process";
import { db, auth } from "../firebase/firebase";
import { firestore } from "firebase-admin";
import { Timestamp } from "firebase-admin/firestore";

export const createAnnounce = async (announceName:string,announceSummary:number,event_at:string) => {
    //title,summaryが来た時点で自動作成
    //event_at(string)をDateに変換してタイムスタンプに
    const time_now = firestore.Timestamp.now();
    await db.collection('announcement').add({
        title: announceName,
        summary: announceSummary,
        created_at: time_now,
        event_at: Timestamp.fromDate(new Date(event_at)),
        updated_at: time_now,
    });    
}