import { db, auth } from "../firebase/firebase";
import { FieldValue, Timestamp } from "firebase-admin/firestore";
import jwt from "jsonwebtoken";

export const createJwt = async (token: string) => {
    const decoded = await auth.verifyIdToken(token);
    const uid = decoded.uid;


    const userToken = jwt.sign(
        { uid, role: "user" },
        process.env.JWT_SECRET!,
        { expiresIn: "365d" },
    );

    return { userToken };
}

export const createUser = async (token: string) => {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { uid: string, role: string };

    const uid = decoded.uid;
    const name = '未設定';

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
        return { message: "新規登録完了" };
    } else {
        await userRef.update({
            update_at: FieldValue.serverTimestamp(),
        });
    }
};

export const updateName = async (token: string, newName: string) => {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { uid: string, role: string };
    const uid = decoded.uid;

    return await db.collection('users').doc(uid).update(
        { name: newName }
    );
}

export const userHaveTickets = async (token: string,) => {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { uid: string, role: string };
    const uid = decoded.uid;

    const doc = await db.collection('users').doc(uid).get();

    const tickets: string[] = doc.get("tickets") || [];

    return tickets;
}

export const ticketsInfo = async (userHaveTickets: string[]) => {
    if (userHaveTickets.length === 0) {
        return ({ message: "所持チケットはありません" });
    }
    const getTickets = userHaveTickets.map(async (uuid: string) => {
        const ticketDoc = await db.collection('userTicket').doc(uuid).get();
        if (ticketDoc.exists) {
            const data = ticketDoc.data();

            if (data?.expiration_at && typeof data.expiration_at.toDate === "function") {
                data.expiration_at = data.expiration_at.toDate().toISOString();
            }

            // 座標データの処理
            if (data?.point) {
                console.log('元の座標データ:', JSON.stringify(data.point));

                if (typeof data.point.latitude === "number" && typeof data.point.longitude === "number") {
                    // 既存の形式: {latitude: number, longitude: number}
                    console.log('既存形式で処理');
                    data.point = {
                        lat: data.point.latitude,
                        lng: data.point.longitude
                    };
                } else if (Array.isArray(data.point) && data.point.length === 2) {
                    // 新しい形式: [lat, lng] または [lat° N, lng° E]
                    console.log('配列形式で処理');
                    const latStr = data.point[0].toString();
                    const lngStr = data.point[1].toString();
                    console.log('lat文字列:', latStr, 'lng文字列:', lngStr);

                    // 度分秒形式をパース
                    const lat = parseFloat(latStr.replace(/°\s*[NS]/i, ''));
                    const lng = parseFloat(lngStr.replace(/°\s*[EW]/i, ''));
                    console.log('パース後 lat:', lat, 'lng:', lng);

                    data.point = {
                        lat: lat,
                        lng: lng
                    };
                } else {
                    console.log('未知の座標形式:', typeof data.point, data.point);
                }

                console.log('変換後座標:', JSON.stringify(data.point));
            } else {
                console.log('座標データが存在しません');
            }
            return [uuid, data];
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

export const useTicket = async (token: string, ticket_id: string) => {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { uid: string, role: string };
    const uid = decoded.uid;

    const Ref = db.collection("userTickets").doc(ticket_id);
    const Doc = await Ref.get();

    if (Doc.data()?.uid !== uid) {
        throw new Error("このチケットを使用する権限がありません");
    }

    return await Ref.update({
        effective: false
    });
}
