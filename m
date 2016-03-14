From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/9] serial: doc: Low Level Serial API Documentation Improvements
Date: Mon, 14 Mar 2016 16:16:08 +0100
Message-ID: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Russell, Greg, Jiri, Jon,

This patch series contains improvements to the low level serial driver
API documentation.

Thanks for your comments!

Geert Uytterhoeven (9):
  serial: doc: Un-document non-existing uart_write_console()
  serial: doc: Un-document obsolete tmpbuf_sem
  serial: doc: Document .throttle()
  serial: doc: Document .unthrottle()
  serial: doc: Document .set_ldisc()
  serial: doc: .break_ctl() is called with port->mutex() held
  serial: doc: Spelling s/divsor/divisor/
  serial: doc: Grammar s/function are/functions are/
  serial: doc: Correct return type of mctrl_gpio_to_gpiod()

 Documentation/serial/driver | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
