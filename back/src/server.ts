import express, { Request, Response }  from 'express';

const app  = express();
const port = 3000;

app.get("/", (req: Request, res: Response) => {
    res.send("テスト");
});

app.listen(port, () => {
    console.log(` サーバー起動: http://localhost:${port}`);
})