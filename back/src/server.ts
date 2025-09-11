import express, { Request, Response }  from 'express';
import cors from 'cors';
import dotenv from "dotenv";
import routes from './routes';
dotenv.config();
const app  = express();
const port =  process.env.PORT || "3000";

app.use(cors());
app.use(express.json());

app.use('/api',routes)

app.listen(port, () => {
    console.log(` サーバー起動: http://localhost:${port}`);
});