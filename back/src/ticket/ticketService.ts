import { db, auth } from "../firebase/firebase";
import jwt from "jsonwebtoken";

export interface ticketData  {
    rank_id: number,
    prize: string,
    expiration_at: Date,
}

export const createTicket = async ( token:string, data: ticketData ) => {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { id: string; email: string };
    const ticket = await db.collection('tickets').add({
        store_id: decoded.id,
        rank_id: data.rank_id,
        prize: data.prize,
        expiration_at: new Date(data.expiration_at),
        effective: true
    });
    return {
        ticket_id: ticket.id,
    };
}