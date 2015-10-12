From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: fix mctrl helper functions
Date: Mon, 12 Oct 2015 17:04:14 +0200
Message-ID: <5611419.Budt39N01Y@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, u.kleine-koenig@pengutronix.de
List-Id: linux-serial@vger.kernel.org

A recent patch to create common helper functions for modem control
lines created empty helper functions in a header file, but accidentally
did not mark them as 'static inline', which causes build errors:

drivers/tty/serial/mxs-auart.o: In function `mctrl_gpio_enable_ms':
mxs-auart.c:(.text+0x171c): multiple definition of `mctrl_gpio_enable_ms'
drivers/tty/serial/clps711x.o:clps711x.c:(.text+0x768): first defined here
drivers/tty/serial/mxs-auart.o: In function `mctrl_gpio_disable_ms':
mxs-auart.c:(.text+0x1720): multiple definition of `mctrl_gpio_disable_ms'
drivers/tty/serial/clps711x.o:clps711x.c:(.text+0x76c): first defined here

This adds the missing annotation, so the functions do not get placed
in each object file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ce59e48fdbad ("serial: mctrl_gpio: implement interrupt handling")

diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index 3c4ac9ae41f9..9716db283290 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -133,11 +133,11 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
 {
 }
 
-void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
+static inline void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 {
 }
 
-void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 {
 }
 
