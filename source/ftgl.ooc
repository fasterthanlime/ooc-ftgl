use glew
import glew

use ftgl
include FTGL/ftgl

FTGLFont: extern cover from FTGLfont
FTGL_RENDER_ALL: extern Int
ft_encoding_unicode: extern Int
ftglGetFontBBox: extern func(FTGLFont*, CString, Int, Float*)

FtglBBox: cover {
    llx,lly,llz,urx,ury,urz: Float
}

Ftgl: class {
    font: FTGLFont*
	
    init: func(x, y: Int, filename: String) {
        font = createTextureFont(filename)
        setFontFaceSize(font, x, y)
        setFontCharMap(font, ft_encoding_unicode)
    }
	
    render: func (text: String) {
        renderFont(font, text, FTGL_RENDER_ALL)
    }
	
    renderFont: extern(ftglRenderFont) static func(FTGLFont*, CString, Int)
    setFontFaceSize: extern(ftglSetFontFaceSize) static func(FTGLFont*, Int, Int)
    setFontCharMap: extern(ftglSetFontCharMap) static func(FTGLFont*, Int)
    createTextureFont: extern(ftglCreateTextureFont) static func(CString) -> FTGLFont*
    createPixmapFont: extern(ftglCreatePixmapFont) static func(CString) -> FTGLFont*
	
    getFontBBox: func (value: String) -> FtglBBox {
        bb := gc_malloc(6 * Float size) as Float*
        ftglGetFontBBox(font, value toCString(), value size, bb)
        ret : FtglBBox
        ret llx = bb[0]
        ret lly = bb[1]
        ret llz = bb[2]
        ret urx = bb[3]
        ret ury = bb[4]
        ret urz = bb[5]
        
        return ret
    }
}


