import express, { Request, Response }  from 'express';
import cors from 'cors';
import routes from './routes';
const app  = express();
const port = 3000;

app.use(cors());

app.use('/api',routes)

// app.get("/", (req: Request, res: Response) => {
//     res.send("テスト");
// });

app.listen(port, () => {
    console.log(` サーバー起動: http://localhost:${port}`);
});