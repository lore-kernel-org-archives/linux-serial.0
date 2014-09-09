From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: clps711x: Fix COMPILE_TEST build for target without GPIOLIB support
Date: Tue,  9 Sep 2014 08:14:36 +0400
Message-ID: <1410236076-6229-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.181.189]:45309 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaIIEO6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Sep 2014 00:14:58 -0400
Received: from smtp45.i.mail.ru (smtp45.i.mail.ru [94.100.177.105])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id 8C13A124C9D74
	for <linux-serial@vger.kernel.org>; Tue,  9 Sep 2014 08:14:53 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

The patch fixes the following build error of CLPS711X serial driver for
targets without GPIOLIB support:

>> drivers/tty/serial/serial_mctrl_gpio.c:44:6: error: redefinition of 'mctrl_gpio_set'
  void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
      ^
  In file included from drivers/tty/serial/serial_mctrl_gpio.c:23:0:
  drivers/tty/serial/serial_mctrl_gpio.h:80:6: note: previous definition of 'mctrl_gpio_set' was here
  void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
      ^

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 75cc59f..799cc1f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -204,7 +204,7 @@ config SERIAL_CLPS711X
 	tristate "CLPS711X serial port support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
 	select SERIAL_CORE
-	select SERIAL_MCTRL_GPIO
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  This enables the driver for the on-chip UARTs of the Cirrus
 	  Logic EP711x/EP721x/EP731x processors.
-- 
1.8.5.5

