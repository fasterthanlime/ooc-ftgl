use sdl2
import sdl2/[OpenGL]

use ftgl
include FTGL/ftgl

/**
 * A font loaded by FTGL, with a certain font size
 */
Font: class {

    _font: FTGLFont*
	
    init: func(x, y: Int, filename: String) {
        _font = ftglCreateTextureFont(filename)
        ftglSetFontFaceSize(_font, x, y)
        ftglSetFontCharMap(_font, ft_encoding_unicode)
    }
	
    render: func (text: String, mode := RenderMode all) {
        ftglRenderFont(_font, text, mode)
    }

    getLineHeight: func -> Float {
        ftglGetFontLineHeight(_font)
    }
	
    getBounds: func (value: String) -> AABB {
        ret := gc_malloc(Float size * 6) as Float*
        ftglGetFontBBox(_font, value toCString(), value size, ret)
        AABB new(ret)
    }

}

/**
 * An axis-align bounding box in 3D space
 */
AABB: cover {
    /* Lower-left */
    llx, lly, llz: Float

    /* Upper-right */
    urx, ury, urz: Float

    init: func@ (arr: Float*) {
        (llx, lly, llz) = (arr[0], arr[1], arr[2])
        (urx, ury, urz) = (arr[3], arr[4], arr[5])
    }

    getWidth: func -> Float {
        urx - llx
    }

    getHeight: func -> Float {
        ury - lly
    }
}

/* Low-level C functions */

FTGLFont: extern cover from FTGLfont

RenderMode: enum {
    front: extern(FTGL_RENDER_FRONT)
    back:  extern(FTGL_RENDER_BACK)
    side:  extern(FTGL_RENDER_SIDE)
    all:   extern(FTGL_RENDER_ALL)
}

ft_encoding_unicode: extern Int

ftglCreateTextureFont: extern func(CString) -> FTGLFont*
ftglCreatePixmapFont: extern func(CString) -> FTGLFont*

ftglRenderFont: extern func(FTGLFont*, CString, RenderMode)

ftglGetFontBBox: extern func(FTGLFont*, CString, Int, Float*)
ftglSetFontFaceSize: extern func(FTGLFont*, Int, Int)
ftglSetFontCharMap: extern func(FTGLFont*, Int)
ftglGetFontLineHeight: extern func(FTGLFont*) -> Float

