import { Router } from 'express';
const router = Router();

//userルートインポート
import userRoutes from './user/userController';
router.use('/user', userRoutes);

export default router;