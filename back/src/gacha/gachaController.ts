import express, { Request, Response } from 'express';
import * as gachaService from './gachaService';

const router = express.Router();

router.post("/", async (req: Request, res: Response) => {
    const token = req.headers.authorization?.split('Bearer ')[1];

    if (!token) {
        return res.status(400).json({ message: 'tokenがありません'});
    }

    try {
        const result = await gachaService.gachapon(token);
        res.status(200).json({ message: "ガチャポンAPIが正しく動作しました", result })
    } catch (error) {
        res.status(500).json({ message: "ガチャポンAPIが正しく動作しませんでした" });
        console.log( error );
    }

})

export default router;