import express, { Request, Response } from 'express';
import * as ticketService from './ticketService';

const router = express.Router();

//チケットの新規追加
router.post("/", async ( req: Request, res: Response ) => {
    const authHeader = req.headers.authorization;
    const { rank_id, prize, expiration_at }  = req.body;

    if ( !rank_id || !prize || !expiration_at ) {
        return res.status(400).json({ message: "必要な情報が抜けてます"});
    }
    const data = { rank_id, prize, expiration_at: new Date(expiration_at) };

    if (!authHeader) {
        return res.status(401).json({ message: "Authorization ヘッダーがありません" });
    };

    const token = authHeader.split(" ")[1];
    if (!token) {
        return res.status(401).json({ message: "トークンが見つかりません" });
    };

    try {
        await ticketService.createTicket( token, data );
        res.status(200).json({ message: "チケットの新規追加成功"});
    } catch (error) {
        res.status(500).json({ message: "チケットの新規追加失敗"});
        console.log(error);
    }
});

export default router;