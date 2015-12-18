From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] serial: 8250: of: Fix the driver and actually compile the 8250_of
Date: Fri, 18 Dec 2015 15:00:49 +0200
Message-ID: <1450443649-31654-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The 8250_of never compiled since in the Kconfig we have SERIAL_OF_PLATFORM
but in the makefile we expect to have SERIAL_8250_OF...

When the 8250_of.c is actually compiled we will have two errors:
missing linux/nwpserial.h and 8250/8250.h.
Fix those as well at the same time when enable the compilation of the
driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Fixes: afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
CC: Arnd Bergmann <arnd@arndb.de>
---
Hi,

Changes since v1:
- Only update the Makefile

this is fixes linux-next. W/o the patch davinci devices are not booting in DT
mode for example.

Regards,
Peter

 drivers/tty/serial/8250/8250_of.c | 3 +--
 drivers/tty/serial/8250/Makefile  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index d66fd24f87cf..33021c1f7d55 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -18,10 +18,9 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/nwpserial.h>
 #include <linux/clk.h>
 
-#include "8250/8250.h"
+#include "8250.h"
 
 struct of_serial_info {
 	struct clk *clk;
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 4ecb80d3549a..b9b9bca5b6c3 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -28,6 +28,6 @@ obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
 obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
-obj-$(CONFIG_SERIAL_8250_OF)		+= 8250_of.o
+obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.6.4
