From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/6] serial: 8250: move of_serial code to 8250 directory
Date: Mon, 16 Nov 2015 16:48:14 +0100
Message-ID: <1447688894-2936779-7-git-send-email-arnd@arndb.de>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

As the of-serial driver is now 8250 specific, we can move the
file to a more appropriate place in teh 8250 subdirectory and
adapt the Kconfig help text and file name.

I'm leaving the CONFIG_SERIAL_OF_PLATFORM symbol unchanged
to avoid breaking user configuration files unnecessarily.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/{of_serial.c => 8250/8250_of.c} |  0
 drivers/tty/serial/8250/Kconfig                    |  9 +++++++++
 drivers/tty/serial/8250/Makefile                   |  1 +
 drivers/tty/serial/Kconfig                         | 10 ----------
 drivers/tty/serial/Makefile                        |  1 -
 5 files changed, 10 insertions(+), 11 deletions(-)
 rename drivers/tty/serial/{of_serial.c => 8250/8250_of.c} (100%)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/8250/8250_of.c
similarity index 100%
rename from drivers/tty/serial/of_serial.c
rename to drivers/tty/serial/8250/8250_of.c
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6412f1455beb..f8507d718dd4 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,3 +378,12 @@ config SERIAL_8250_MID
 	  Selecting this option will enable handling of the extra features
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
+
+config SERIAL_OF_PLATFORM
+	tristate "Devicetree based probing for 8250 ports"
+	depends on SERIAL_8250 && OF
+	help
+	  This option is used for all 8250 compatible serial ports that
+	  are probed through devicetree, including Open Firmware based
+	  PowerPC systems and embedded systems on architectures using the
+	  flattened device tree format.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index e177f8681ada..4ecb80d3549a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -28,5 +28,6 @@ obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
 obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
+obj-$(CONFIG_SERIAL_8250_OF)		+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a9c2200fd528..6879a5785be7 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1094,16 +1094,6 @@ config SERIAL_NETX_CONSOLE
 	  If you have enabled the serial port on the Hilscher NetX SoC
 	  you can make it the console by answering Y to this option.
 
-config SERIAL_OF_PLATFORM
-	tristate "Serial port on Open Firmware platform bus"
-	depends on OF
-	depends on SERIAL_8250
-	help
-	  If you have a PowerPC based system that has serial ports
-	  on a platform specific bus, you should enable this option.
-	  Currently, only 8250 compatible ports are supported, but
-	  others can easily be added.
-
 config SERIAL_OMAP
 	tristate "OMAP serial port support"
 	depends on ARCH_OMAP2PLUS
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index ee8893317433..b391c9b31960 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -63,7 +63,6 @@ obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
 obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
 obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
-obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
 obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
 obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
-- 
2.1.0.rc2
