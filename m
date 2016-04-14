From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] serial: doc: Low Level Serial API Documentation Improvements (take two)
Date: Thu, 14 Apr 2016 11:08:07 +0200
Message-ID: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri, Jon, Peter, Russell,

This patch series contains improvements to the low level serial driver
API documentation.

It is an incremental update (sort of v2) of "[PATCH 0/9] serial: doc:
Low Level Serial API Documentation Improvements", which was already
applied to the docs tree.

Thanks for your comments!

Geert Uytterhoeven (4):
  serial: doc: Re-add paragraph documenting uart_console_write()
  serial: doc: .(un)throttle() depends on hardware assisted flow control
  serial: doc: .(un)throttle() are serialized by the tty layer
  serial: doc: .break_ctl() may sleep

 Documentation/serial/driver | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
