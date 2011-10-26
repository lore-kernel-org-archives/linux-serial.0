From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 48/79] TTY: serial, fix includes in some drivers
Date: Wed, 26 Oct 2011 14:12:53 +0200
Message-ID: <1319631204-23262-48-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32802 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875Ab1JZMNu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:50 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

=46rom: Jiri Slaby <jslaby@suse.cz>

linux/tty_flip.h is included in linux/serial_core.h. But this may (and
will) change in the future. Then we would get build errors such as:
=2E../tty/serial/max3107.c: In function =E2=80=98put_data_to_circ_buf=E2=
=80=99:
=2E../tty/serial/max3107.c:149:2: error: implicit declaration of functi=
on =E2=80=98tty_insert_flip_string=E2=80=99

So fix all the drviers which call tty flip buffer helpers to really
include linux/tty_flip.h. And also make sure that those include
linux/tty.h when operating with struct tty_struct.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/apbuart.c                |    1 +
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    1 +
 drivers/tty/serial/dz.c                     |    1 +
 drivers/tty/serial/ioc3_serial.c            |    1 +
 drivers/tty/serial/ioc4_serial.c            |    1 +
 drivers/tty/serial/m32r_sio.c               |    1 +
 drivers/tty/serial/max3100.c                |    2 ++
 drivers/tty/serial/max3107.c                |    2 ++
 drivers/tty/serial/mpc52xx_uart.c           |    1 +
 drivers/tty/serial/msm_serial_hs.c          |    2 ++
 drivers/tty/serial/mux.c                    |    2 ++
 drivers/tty/serial/nwpserial.c              |    1 +
 drivers/tty/serial/pch_uart.c               |    2 ++
 drivers/tty/serial/sb1250-duart.c           |    1 +
 drivers/tty/serial/serial_ks8695.c          |    1 +
 drivers/tty/serial/serial_txx9.c            |    2 ++
 drivers/tty/serial/sn_console.c             |    1 +
 drivers/tty/serial/timbuart.c               |    2 ++
 drivers/tty/serial/uartlite.c               |    1 +
 drivers/tty/serial/ucc_uart.c               |    4 +++-
 drivers/tty/serial/xilinx_uartps.c          |    4 +++-
 drivers/tty/serial/zs.c                     |    1 +
 22 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.=
c
index 19a9436..77554fd 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -16,6 +16,7 @@
=20
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/serial.h>
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/=
serial/cpm_uart/cpm_uart_core.c
index 9488da7..b418947 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -31,6 +31,7 @@
=20
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/serial.h>
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index ddc487a..e3699a8 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -47,6 +47,7 @@
 #include <linux/serial_core.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
=20
 #include <linux/atomic.h>
 #include <asm/bootinfo.h>
diff --git a/drivers/tty/serial/ioc3_serial.c b/drivers/tty/serial/ioc3=
_serial.c
index ee43efc..758ff310 100644
--- a/drivers/tty/serial/ioc3_serial.c
+++ b/drivers/tty/serial/ioc3_serial.c
@@ -13,6 +13,7 @@
  */
 #include <linux/errno.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/circ_buf.h>
 #include <linux/serial_reg.h>
diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4=
_serial.c
index fcfe826..6b36c15 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -14,6 +14,7 @@
  */
 #include <linux/errno.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/circ_buf.h>
diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_si=
o.c
index 8e07517..0801893 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -32,6 +32,7 @@
=20
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.=
c
index 7b951ad..2af5aa5 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -47,6 +47,8 @@
 #include <linux/serial.h>
 #include <linux/spi/spi.h>
 #include <linux/freezer.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
=20
 #include <linux/serial_max3100.h>
=20
diff --git a/drivers/tty/serial/max3107.c b/drivers/tty/serial/max3107.=
c
index 750b4f6..47602a2 100644
--- a/drivers/tty/serial/max3107.c
+++ b/drivers/tty/serial/max3107.c
@@ -31,6 +31,8 @@
 #include <linux/device.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/freezer.h>
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc=
52xx_uart.c
index a0bcd8a..c395520 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -34,6 +34,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/sysrq.h>
 #include <linux/console.h>
diff --git a/drivers/tty/serial/msm_serial_hs.c b/drivers/tty/serial/ms=
m_serial_hs.c
index 624701f..60c6eb8 100644
--- a/drivers/tty/serial/msm_serial_hs.c
+++ b/drivers/tty/serial/msm_serial_hs.c
@@ -30,6 +30,8 @@
=20
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 9711e06..06f6aef 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -21,6 +21,8 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/console.h>
 #include <linux/delay.h> /* for udelay */
 #include <linux/device.h>
diff --git a/drivers/tty/serial/nwpserial.c b/drivers/tty/serial/nwpser=
ial.c
index de17367..9beaff1 100644
--- a/drivers/tty/serial/nwpserial.c
+++ b/drivers/tty/serial/nwpserial.c
@@ -15,6 +15,7 @@
 #include <linux/serial_reg.h>
 #include <linux/serial_core.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/irqreturn.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uar=
t.c
index 846dfcd..ecc8506 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -20,6 +20,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/dmi.h>
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1=
250-duart.c
index 6bc2e3f..0be8a2f 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -37,6 +37,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/types.h>
=20
 #include <linux/atomic.h>
diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/se=
rial_ks8695.c
index 2430319..5551f7a 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -13,6 +13,7 @@
  */
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/serial.h>
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/seri=
al_txx9.c
index 8e3fc19..34bd345 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -28,6 +28,8 @@
 #include <linux/pci.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
=20
 #include <asm/io.h>
=20
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_co=
nsole.c
index 377ae74..7320507 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -39,6 +39,7 @@
=20
 #include <linux/interrupt.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/module.h>
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuar=
t.c
index 1f36b7e..a4b63bf 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -23,6 +23,8 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlit=
e.c
index 8af1ed8..b908615 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -15,6 +15,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uar=
t.c
index c327218..97b6724 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -20,8 +20,10 @@
=20
 #include <linux/module.h>
 #include <linux/serial.h>
-#include <linux/slab.h>
 #include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xi=
linx_uartps.c
index 19cc1e8..8c03b12 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -12,9 +12,11 @@
  */
=20
 #include <linux/platform_device.h>
+#include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/console.h>
-#include <linux/serial.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/of.h>
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 0aebd71..b7455b5 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -63,6 +63,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/types.h>
=20
 #include <linux/atomic.h>
--=20
1.7.7

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
