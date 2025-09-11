import { db } from "../firebase/firebase";
import bcrypt from "bcryptjs";
import { firestore } from "firebase-admin";
import jwt from "jsonwebtoken";

export const storeSginup = async (email: string, pass: string) => {
    const randomNum = 10;
    const hashPass = await bcrypt.hash(pass, randomNum)
    await db.collection('stores').add({
        email,
        pass: hashPass,
    });
};

export const storeLogin = async (email: string, pass: string) => {
    
    const checkEmail = await db.collection('stores').where("email","==",email).get();

    if (checkEmail.empty) {
        throw new Error("Emailが違います");
    };

    const doc = checkEmail.docs[0];
    const data = doc.data();
    
    const checkPass = await bcrypt.compare(pass, data.pass);
    if (!checkPass) {
        throw new Error("パスワードが違います");
    }

    const token = jwt.sign(
        { id: doc.id, email: data.email },
        process.env.JWT_SECRET!,
        {expiresIn: "1h"}           
    );

    return { token };
};

export interface storeUpdateData {
    name?: string;
    percent?: number;
    tag?: string[];
    position?: { latitude: number; longitude: number };
}

export const storeUpdate = async (token:string, data: storeUpdateData) => {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { id: string; email: string };
    const updateData: any = { ...data };
    if (data.position) {
        updateData.position = new firestore.GeoPoint(
            data.position.latitude,
            data.position.longitude
        );
    }
    return await db.collection('stores').doc(decoded.id).update(updateData);
}