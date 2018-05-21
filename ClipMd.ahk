#Include Gdip_All.ahk
basePath := "Y:/"
PicPath := basePath . ""
imageFormat := "png"
filenameFormat := "yyyyMMdd_HHmmss"
rootPreix:="file:/"




^F1::
    ; ����ͼƬ��λ�ú͸�ʽ
    old:=ClipboardAll
    FormatTime, currentFilenameFormat, A_Now, %filenameFormat%
    savePath := PicPath . currentFilenameFormat . "." . imageFormat
    saveHttpPath := rootPreix . PicPath . currentFilenameFormat . "." . imageFormat
   createPic(savePath)
   clipboard := "![image](" . saveHttpPath . ")"
   send, ^v
   clipboard:=old
return

F8::
 ExitApp
return

createPic(PicPath)
{
	pToken := Gdip_Startup() ; Start gdi+
        ; pBitmapAlpha := Gdip_CreateBitmapFromFile(PicPath)
        ;pBitmapAlpha := Gdip_BitmapFromScreen(0, "")

	;pBitmapAlpha := Gdip_BitmapFromScreen(x "|" y "|" width "|" height)
        pBitmapAlpha := Gdip_CreateBitmapFromClipboard()
        ImgWidth := Gdip_GetImageWidth(pBitmapAlpha)  ; ��ȡ��ȣ��߶ȣ���ʡ��
        ImgHeight := Gdip_GetImageHeight(pBitmapAlpha)
 
        Gdip_SaveBitmapToFile(pBitmapAlpha, PicPath,"255") ;��������������ͼƬ����
        Gdip_DisposeImage(pBitmapAlpha)
        
	Gdip_Shutdown(pToken) ; close gdi+
	Traytip, ��ͼ���:, ��: %ImgWidth% ��: %ImgHeight%`n����Ϊ: %PicPath%
}



