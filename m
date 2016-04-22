From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: mctrl_gpio: Drop support for out1-gpios and out2-gpios
Date: Fri, 22 Apr 2016 17:10:14 +0200
Message-ID: <1461337814-29058-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Richard Genoud <richard.genoud@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The OUT1 and OUT2 pins present on some legacy UARTs are basically GPIOs.
It doesn't make much sense to emulate GPIOs using other GPIOs, hence
drop support for that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 02147361eaa94747..821ffa637eb630cb 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -43,8 +43,6 @@ static const struct {
 	{ "rng", TIOCM_RNG, false, },
 	{ "rts", TIOCM_RTS, true, },
 	{ "dtr", TIOCM_DTR, true, },
-	{ "out1", TIOCM_OUT1, true, },
-	{ "out2", TIOCM_OUT2, true, },
 };
 
 void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
-- 
1.9.1
