From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Mon, 21 Dec 2015 20:49:51 +0530
Message-ID: <20151221151904.GA23780@sudip-pc>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
 <20151220172841.GB8471@sudip-laptop>
 <20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 20, 2015 at 05:42:08PM +0000, One Thousand Gnomes wrote:
> > So then should I rewrite it as MFD or should it be like the way you
> > suggested in the other mail to have it as bool in the Kconfig and combine
> > the file with 8250_pci.c when the symbol is selected?
> 
> Yes although I'm really not sure which is the best approach of the two.

Hi Alan and Andy,
I was trying like:

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6412f14..ec3d287 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,3 +378,11 @@ config SERIAL_8250_MID
 	  Selecting this option will enable handling of the extra features
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
+
+config SERIAL_8250_EXAR_GPIO
+	bool "Support for GPIO pins on XR17V352/354/358"
+	depends on SERIAL_8250_PCI && GPIOLIB
+	select GPIO_SYSFS
+	help
+	  Selecting this option will enable handling of GPIO pins present
+	  on Exar XR17V352/354/358 chips.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index e177f86..1d0fce0 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -28,5 +28,8 @@ obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
 obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
+obj-$(CONFIG_SERIAL_8250_EXAR_GPIO)	+= exar_gpio.o
+exar_gpio-y				:= 8250_pci.o 8250_gpio.o
+
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt


But I am getting:
ERROR: "xr17v35x_gpio_exit" [drivers/tty/serial/8250/8250_pci.ko] undefined!
ERROR: "xr17v35x_gpio_init" [drivers/tty/serial/8250/8250_pci.ko] undefined!

I will need little hint for the Makefile, please. Its clear that i have
messed up.

regards
sudip
