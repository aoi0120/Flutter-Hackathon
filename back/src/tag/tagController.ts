import express, { Request, Response } from 'express';
import * as tagService from './tagService';

const router = express.Router();

//タグ作成API
router.post("/", async (req:Request, res:Response) => {
    try {
        const { tagName,tagId } = req.body || {};
        if (!tagName ) {
            return res.status(400).json({ message: "タグの名前が有りません" })
        }
        if (!tagId) {
            return res.status(400).json({ message: "IDが有りません" })
        }
        await tagService.createTag(tagName,tagId); 
        res.status(200).json({ message: "タグ作成API成功"});
    } catch (error) {
        res.status(500).json({ message: "タグ作成APIエラー" });
        console.log(error);
    }
})

//タグ取得API
router.get("/", async (req:Request, res:Response) => {
    try {
        const tags = await tagService.getTag(); 
        res.status(200).json({ message: "タグ取得成功", tags});
    } catch (error) {
        res.status(500).json({ message: "タグ取得APIエラー" });
        console.log(error);
    }
})
export default router;