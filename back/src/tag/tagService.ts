import { db, auth } from "../firebase/firebase";

export const createTag = async (tagName:string,tagId:number) => {
    //firebaseのtagsにタグを追加
    await db.collection('tags').add({
        name: tagName,
        tag_id: tagId,
    });    
} 

export const getTag = async () => {
    //firebaseのtagsのタグを収集
    
    const tagAll = await db.collection('tags').get();

    if(tagAll.empty){
        return[];
    }
    const tags:any = [];
    tagAll.forEach(doc => {
        tags.push({
            id: doc.id,
            name: doc.data().name,
            tag_id: doc.data().tag_id,
        //他のがあれば追加
        });
    });

    return tags;

} 