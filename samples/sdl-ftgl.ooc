
use sdl2
import sdl2/[Core, OpenGL]

use glu
import glu

use ftgl
import ftgl

main: func (argc: Int, argv: CString*) {

    app := Application new()
    app draw()

    SDL delay(2000)
    app quit()

}

Application: class {

    width, height: Int
    font: Font

    window: SdlWindow
    context:  SdlGlContext

    init: func {
	(width, height) = (640, 480)
	SDL init(SDL_INIT_EVERYTHING)
	window := SDL createWindow(
            "SDL glew ftgl example",
            SDL_WINDOWPOS_CENTERED,
            SDL_WINDOWPOS_CENTERED,
            width,
            height,
            0
        )

        context := SDL glCreateContext(window)
        SDL glMakeCurrent(window, context)

	reshape(width, height)
	font = Font new(80, 72, "Sansation_Regular.ttf")
    }

    quit: func {
	SDL quit()
    }

    reshape: func (width, height: Int) {
	h := height as Float / width as Float

	glViewport(0, 0, width as Int, height as Int)
	glMatrixMode(GL_PROJECTION)
	glLoadIdentity()
	glFrustum(-1.0, 1.0, -h, h, 5.0, 60.0)
	glMatrixMode(GL_MODELVIEW)
	glLoadIdentity()
    }

    begin2D: func {
	glDisable(GL_DEPTH_TEST)
	glEnable(GL_BLEND)
	glMatrixMode(GL_PROJECTION)
	glPushMatrix()
	glLoadIdentity()

	gluOrtho2D(0, width, 0, height)
	glMatrixMode(GL_MODELVIEW)
	glPushMatrix()
	glLoadIdentity()
    }

    end2D: func {
	glMatrixMode(GL_PROJECTION)
	glPopMatrix()
	glMatrixMode(GL_MODELVIEW)
	glPopMatrix()

	glEnable(GL_DEPTH_TEST)
	glDisable(GL_BLEND)
    }

    draw: func {
        SDL glMakeCurrent(window, context)
	glClearColor(0.9, 0.9, 0.9, 1.0)
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

	begin2D()
	glColor3f(0.2, 0.2, 0.2)
        glPushMatrix()
        glTranslatef(20, 40, 0)
        glScalef(0.4, 0.4, 0.4)
	font render("SDL + glew + FTGL demo")
        glPopMatrix()
	end2D()

        SDL glSwapWindow(window)
    }

}

