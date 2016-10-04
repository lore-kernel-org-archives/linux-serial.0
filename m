From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: [PATCH 2/2] tty: serial: Makefile: move kgdb to be initialized last
Date: Tue,  4 Oct 2016 15:46:17 +0300
Message-ID: <1475585177-28777-3-git-send-email-nicolae.rosia.oss@gmail.com>
References: <1475585177-28777-1-git-send-email-nicolae.rosia.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1475585177-28777-1-git-send-email-nicolae.rosia.oss@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Agner <stefan@agner.ch>, Stefan Golinschi <stefan.golinschi@gmail.com>, Jiri Slaby <jslaby@suse.com>, Nicolae Rosia <nicolae_rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nicolae Rosia <nicolae_rosia@mentor.com>

fsl_lpuart cannot be used with kgdb because the kgdb
initcall is called before the driver's init.
Move kgdb to be initialized after all serial drivers
have been inited.

Signed-off-by: Nicolae Rosia <nicolae_rosia@mentor.com>
Signed-off-by: Stefan Golinschi <stefan.golinschi@gmail.com>
---
 drivers/tty/serial/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 1278d37..8016ef9 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -62,13 +62,11 @@ obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
 obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
 obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
-obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
 obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
 obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_SERIAL_ST_ASC) += st-asc.o
 obj-$(CONFIG_SERIAL_TILEGX) += tilegx.o
-obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
 obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
 obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
@@ -96,3 +94,6 @@ obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
+
+obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
+obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
-- 
2.5.5
