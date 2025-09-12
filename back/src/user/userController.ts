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

//所持チケット追加
router.post("/:ticketUuid", async (req: Request, res: Response) => {
    const { ticketUuid } = req.params;
    const token = req.headers.authorization?.split('Bearer ')[1];

    if (!token) {
        return res.status(400).json({ message: 'tokenがありません'});
    }

    if (!ticketUuid) {
        return res.status(400).json({ message: 'ticketUuidがありません'});
    }

    try {
        const addTicket = await userService.addTicket( token, ticketUuid );
        res.status(200).json({ message: `チケットID:${ ticketUuid }を所持チケットに追加しました。`, addTicket })
    } catch (error) {
        res.status(500).json({ message: "チケット追加に失敗しました" })
    }
})

//所持チケット全表示
router.get("/", async ( req: Request, res: Response) => {
    const token = req.headers.authorization?.split('Bearer ')[1];

    if (!token) {
        return res.status(400).json({ message: 'tokenがありません'});
    }

    try {
        const userHaveTickets = await userService.userHaveTickets( token );
        if (!userHaveTickets) {
            return res.status(400).json({ message: 'ticketsデータがありません'});
        }
        const ticketsInfo = await userService.ticketsInfo(userHaveTickets);
        res.status(200).json({ message: "所持チケット全表示 成功", tickets: ticketsInfo.tickets });
    } catch (error) {
        res.status(500).json({ message: "所持チケット全表示 失敗" });
        console.log(error)
    }
})

export default router;