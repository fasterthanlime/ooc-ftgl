
use sdl
import sdl/Core

use glew
import glew

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
    ftgl: Ftgl

    init: func {
	(width, height) = (640, 480)
	SDL init(SDL_INIT_EVERYTHING)
	screen := SDL setMode(width, height, 16, SDL_OPENGL)
	SDL wmSetCaption("SDL glew ftgl example", null)

	reshape(width, height)
	ftgl = Ftgl new(80, 72, "Sansation_Regular.ttf")
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

	gluOrtho2D(0, width, height, 0)
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
	glClearColor(0.9, 0.9, 0.9, 1.0)
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

	begin2D()
	glColor3f(0.2, 0.2, 0.2)
	ftgl render(20, 40, 0.4, true, "SDL + glew + FTGL demo")
	end2D()

	SDL glSwapBuffers()
    }

}

