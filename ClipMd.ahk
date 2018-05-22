#Include Gdip_All.ahk
basePath := "Y:/"
PicPath := basePath . ""
imageFormat := "png"
filenameFormat := "yyyyMMdd_HHmmss"
rootPreix:="file:/"




^1::
    ; 保存图片的位置和格式
    old:=ClipboardAll
    FormatTime, currentFilenameFormat, A_Now, %filenameFormat%
    savePath := PicPath . currentFilenameFormat . "." . imageFormat
    saveHttpPath := rootPreix . PicPath . currentFilenameFormat . "." . imageFormat
    res := createPic(savePath)
    if(1=res){
    clipboard := "![image](" . saveHttpPath . ")"
    send, ^v
    clipboard:=old
    }else{
    clipboard:=old
    send, ^v
    }

return


F8::
 ExitApp
return

createPic(PicPath)
{
    try{
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
        return 1
    }catch e {
        DllCall("CloseClipboard")
        return 0
    }




}




Base64Encode(ByRef bin, n=0) {
  static table   ;table[0-->63]
  if !table {
    table:=[], Chars:="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      . "abcdefghijklmnopqrstuvwxyz0123456789+/"
    Loop, Parse, Chars
      table[A_Index-1]:=A_LoopField
  }
  bak:=A_BatchLines
  SetBatchLines, -1
  ;---------------------
  pos:=0, n:=(n ? n:StrLen(bin))<<!!A_IsUnicode
  m:=VarSetCapacity(bin), n:=IsByRef(bin)&&n>m ? m:n
  VarSetCapacity(out,Ceil(n/3)*4<<!!A_IsUnicode,0)
  Loop, % n//3
    b:= NumGet(bin,pos++,"UChar")<<16
      | NumGet(bin,pos++,"UChar")<<8
      | NumGet(bin,pos++,"UChar")
    ,out.=table[b>>18&63] . table[b>>12&63]
    . table[b>>6&63] . table[b&63]
  m:=Mod(n,3), b:=0
  Loop, %m%
    b|=NumGet(bin,pos++,"UChar")<<(24-8*A_Index)
  out.=m=0 ? "" : table[b>>18&63] . table[b>>12&63]
    . (m=1 ? "==" : table[b>>6&63] . "=")
  ;---------------------
  SetBatchLines, %bak%
  Return RegExReplace(out,".{40}","$0`r`n")
}


