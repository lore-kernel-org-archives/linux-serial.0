From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 1/4] tty/serial: atmel: move atmel_serial header into driver
 directory
Date: Fri,  3 Mar 2017 15:13:44 +0100
Message-ID: <20170303141344.14122-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Richard Genoud <richard.genoud@gmail.com>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, Joe Perches <joe@perches.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

atmel_serial.h is only used by atmel_serial.c, so there's no need for
it to lie in include/linux.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 MAINTAINERS                                          | 2 +-
 drivers/tty/serial/atmel_serial.c                    | 2 +-
 {include/linux => drivers/tty/serial}/atmel_serial.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {include/linux => drivers/tty/serial}/atmel_serial.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad4f2ce991ca..d7b07cb23cbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8218,7 +8218,7 @@ MICROCHIP / ATMEL AT91 / AT32 SERIAL DRIVER
 M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
-F:	include/linux/atmel_serial.h
+F:	drivers/tty/serial/atmel_serial.h
 
 MICROCHIP / ATMEL DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index dcebb28ffbc4..ad6c2bdea481 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -38,7 +38,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/atmel_pdc.h>
-#include <linux/atmel_serial.h>
 #include <linux/uaccess.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/timer.h>
@@ -71,6 +70,7 @@
 #include <linux/serial_core.h>
 
 #include "serial_mctrl_gpio.h"
+#include "atmel_serial.h"
 
 static void atmel_start_rx(struct uart_port *port);
 static void atmel_stop_rx(struct uart_port *port);
diff --git a/include/linux/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
similarity index 100%
rename from include/linux/atmel_serial.h
rename to drivers/tty/serial/atmel_serial.h
