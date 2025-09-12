import { Router } from 'express';
const router = Router();

//userルートインポート
import userRoutes from './user/userController';
router.use('/user', userRoutes);

//storesルートインポート
import storeRoutes from './store/storeController';
router.use('/store', storeRoutes);

//tagルートインポート
import tagRoutes from './tag/tagController';
router.use('/tag', tagRoutes);

//ticketルートインポート
import ticketRoutes from './ticket/ticketController';
router.use('/ticket', ticketRoutes);

//announceルートインポート
import announceRoutes from './announce/announceController';
router.use('/announce', announceRoutes);

//gachaルートインポート
import gachaRoutes from './gacha/gachaController';
router.use('/gacha', gachaRoutes);


export default router;