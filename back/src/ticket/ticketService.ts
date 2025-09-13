import { db, auth } from "../firebase/firebase";
import jwt from "jsonwebtoken";

export interface ticketData  {
    prize: string,
    expiration_at: Date,
}

export const createTicket = async ( token:string, data: ticketData ) => {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { id: string; email: string };

    const storeRef = await db.collection("stores").doc(decoded.id);
    const storeDoc = await storeRef.get();
    const storePosition  = storeDoc.get("position"); 
    const ticket = await db.collection('tickets').add({
        store_id: decoded.id,
        prize: data.prize,
        position: storePosition,
        expiration_at: new Date(data.expiration_at),
        effective: true
    });
    return {
        ticket_id: ticket.id,
    };
}