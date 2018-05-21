#Include Gdip_All.ahk
basePath := "Y:/"
PicPath := basePath . ""
imageFormat := "png"
filenameFormat := "yyyyMMdd_HHmmss"
rootPreix:="file:/"




^F1::
    ; 保存图片的位置和格式
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
        ImgWidth := Gdip_GetImageWidth(pBitmapAlpha)  ; 获取宽度，高度，可省略
        ImgHeight := Gdip_GetImageHeight(pBitmapAlpha)
 
        Gdip_SaveBitmapToFile(pBitmapAlpha, PicPath,"255") ;第三个参数控制图片质量
        Gdip_DisposeImage(pBitmapAlpha)
        
	Gdip_Shutdown(pToken) ; close gdi+
	Traytip, 截图完毕:, 宽: %ImgWidth% 高: %ImgHeight%`n保存为: %PicPath%
}



