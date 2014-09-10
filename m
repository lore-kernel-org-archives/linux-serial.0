From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] tty: serial: serial_mctrl_gpio: Fix build error for !GPIOLIB
Date: Wed, 10 Sep 2014 10:06:58 +0200
Message-ID: <20140910080657.GC14260@distanz.ch>
References: <CA+r1ZhjCZBWjkxjoJz=PO-YZg6LbghQV75tGnpiSOrHM9CaygA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+r1ZhjCZBWjkxjoJz=PO-YZg6LbghQV75tGnpiSOrHM9CaygA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If SERIAL_MCTRL_GPIO is selected but GPIOLIB is not, the noop functions
from serial_mctrl_gpio.h are pulled in. However, serial_mctrl_gpio.c is
still compiled, leading to function redefinition build errors. Since all
drivers that include serial_mctrl_gpio.h also depend on
SERIAL_MCTRL_GPIO, let it depend on GPIOLIB as well remove the noop
functions alltogether.

Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/Kconfig             |  1 +
 drivers/tty/serial/serial_mctrl_gpio.h | 35 ----------------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8079f52..5f1ea62 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1575,5 +1575,6 @@ endmenu
 
 config SERIAL_MCTRL_GPIO
 	tristate
+	select GPIOLIB
 
 endif # TTY
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index 400ba04..5e4c96a 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -40,8 +40,6 @@ enum mctrl_gpio_idx {
  */
 struct mctrl_gpios;
 
-#ifdef CONFIG_GPIOLIB
-
 /*
  * Set state of the modem control output lines via GPIOs.
  */
@@ -74,37 +72,4 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx);
  */
 void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
 
-#else /* GPIOLIB */
-
-static inline
-void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
-{
-}
-
-static inline
-unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
-{
-	return *mctrl;
-}
-
-static inline
-struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
-				      enum mctrl_gpio_idx gidx)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline
-struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline
-void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
-{
-}
-
-#endif /* GPIOLIB */
-
 #endif
-- 
2.0.1
