From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] serial: doc: More Low Level Serial API Documentation Improvements
Date: Wed, 11 May 2016 13:56:03 +0200
Message-ID: <1462967765-30871-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri, Jon, Peter, Russell,

This patch series (against next-20160511) contains improvements to the low
level serial driver API documentation.

Thanks for your comments!

Geert Uytterhoeven (2):
  serial: doc: Always refer to tty_port->mutex
  serial: doc: Use port->state instead of info

 Documentation/serial/driver | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
