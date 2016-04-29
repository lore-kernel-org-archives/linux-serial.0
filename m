From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] serial: mctrl_gpio: Drop support for out1-gpios and out2-gpios
Date: Fri, 29 Apr 2016 13:40:26 +0200
Message-ID: <1461930026-15783-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Richard Genoud <richard.genoud@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The OUT1 and OUT2 pins present on some legacy UARTs are basically GPIOs.
It doesn't make much sense to emulate GPIOs using other GPIOs, hence
drop support for that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
v2:
  - Add Reviewed-by,
  - Drop forgotten UART_GPIO_OUT[12] enum values.
---
 drivers/tty/serial/serial_mctrl_gpio.c | 2 --
 drivers/tty/serial/serial_mctrl_gpio.h | 2 --
 2 files changed, 4 deletions(-)

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
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index bcfad5d1db61decf..332a33ab0647cbe3 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -32,8 +32,6 @@ enum mctrl_gpio_idx {
 	UART_GPIO_RI = UART_GPIO_RNG,
 	UART_GPIO_RTS,
 	UART_GPIO_DTR,
-	UART_GPIO_OUT1,
-	UART_GPIO_OUT2,
 	UART_GPIO_MAX,
 };
 
-- 
1.9.1
