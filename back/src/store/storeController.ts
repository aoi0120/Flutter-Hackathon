import express, { Request, Response } from 'express';
import * as storeService from './storeService';
import { firestore } from 'firebase-admin';

const router = express.Router();

//店アカウント作成（DBのパスワードハッシュ化したいだけやからフロント叩かなくていいよ）
router.post("/sgin", async (req: Request,res: Response) =>{
    const {email, pass} = req.body;

    if (!email) {
        return res.status(400).json({ message: "emailを入力してください"});
    };

    if (!pass) {
        return res.status(400).json({ message: "パスワードを入力してください"});
    };

    try {
        await storeService.storeSginup(email,pass);
        res.status(200).json({ message: "店アカウント作成成功",}); 
    } catch (error) {
        res.status(500).json({ message: "店アカウント作成失敗"},);
        console.log(error)
    }
});

//店アカウントログイン処理
router.post("/", async (req: Request,res: Response) =>{
    const {email, pass} = req.body;

    if (!email) {
        res.status(400).json({ message: "emailを入力してください"});
    };

    if (!pass) {
        res.status(400).json({ message: "パスワードを入力してください"});
    };

    try {
        const result = await storeService.storeLogin(email,pass);
        res.status(200).json({ message: "店アカウントログイン成功", token:result.token}); 
    } catch (error) {
        res.status(500).json({ message: "店アカウントログイン失敗"});
    }
});
//店アカウントの情報変更
router.patch("/", async (req: Request, res: Response) => {
    const authHeader = req.headers.authorization;
    const {name,percent,tag,position} = req.body;
    const data: any = {}
    if (name !== undefined) data.name = name;
    if (percent !== undefined) data.percent = percent;
    if (tag !== undefined) data.tag = tag;
    if (position !== undefined) {
        data.position = new firestore.GeoPoint(
            position.latitude,
            position.longitude
        );
    }

    if (!authHeader) {
        return res.status(401).json({ message: "Authorization ヘッダーがありません" });
    };

    const token = authHeader.split(" ")[0];
    if (!token) {
        return res.status(401).json({ message: "トークンが見つかりません" });
    };
    
    try {
        await storeService.storeUpdate(token,data);
        res.status(200).json({ message: "store情報更新完了"});
    } catch (error) {
        res.status(500).json({ message: "store情報更新失敗"});
    }
});

export default router;