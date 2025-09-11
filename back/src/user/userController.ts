import express, { Request, Response } from 'express';
import * as userService from './userService';

const router = express.Router();

//Googleログイン後のDB登録
router.post("/", async (req: Request, res: Response) => {
    const token = req.headers.authorization?.split('Bearer ')[1];

    if (!token) {
        return res.status(400).json({ message: 'tokenがありません'});
    }

    try {
        await userService.createUser(token);
        res.status(200).json({ message: 'user DB登録完了' });
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: 'user DB登録失敗' });
    }
});

//userName変更
router.patch("/", async (req: Request, res: Response) => {
    const { newName } = req.body;
    const token = req.headers.authorization?.split('Bearer ')[1];

    if (!token) {
        return res.status(400).json({ message: 'tokenがありません'});
    }

    if (!newName) {
        return res.status(400).json({ message: 'newNameがありません'});
    }

    try {
        await userService.updateName(token, newName);
        res.status(200).json({ message: 'userName変更完了'});
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: 'userName変更失敗'});
    }
});

export default router;