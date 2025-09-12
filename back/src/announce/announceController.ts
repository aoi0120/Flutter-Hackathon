import express, { Request, Response } from 'express';
import * as announceService from './announceService';

const router = express.Router();

//アナウンス作成
router.post("/", async (req:Request, res:Response) => {
    try {
        const { announceName,announceSummary,event_at} = req.body || {};
        if (!announceName) {
            return res.status(400).json({ message: "お知らせの名前が有りません" })
        }
        if (!announceSummary) {
            return res.status(400).json({ message: "概要が有りません" })
        }
        if (!event_at) {
            return res.status(400).json({ message: "開催時刻が有りません" })
        }
        await announceService.createAnnounce(announceName,announceSummary,event_at); 
        res.status(200).json({ message: "お知らせ作成API成功"});
    } catch (error) {
        res.status(500).json({ message: "お知らせ作成APIエラー" });
        console.log(error);
    }
})

export default router;