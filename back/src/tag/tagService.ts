import { db, auth } from "../firebase/firebase";

export const createTag = async (tagName:string,tagId:number) => {
    //firebaseのtagsにタグを追加
    await db.collection('tags').add({
        name: tagName,
        tag_id: tagId,
    });    
} 