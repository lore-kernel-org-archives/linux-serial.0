From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] serial: exar: Fix stuck MSIs
Date: Mon, 24 Apr 2017 12:30:15 +0200
Message-ID: <b76259dc-42bf-4b3c-8122-04e0b0d217a2@siemens.com>
References: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
 <1493024379.24567.154.camel@linux.intel.com>
 <d227c786-24eb-5acb-777d-02bd28d14254@web.de>
 <1493027143.24567.155.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493027143.24567.155.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

After migrating 8250_exar to MSI in 172c33cb61da, we can get stuck
without further interrupts because of the special wake-up event these
chips send. They are only cleared by reading INT0. As we fail to do so
during startup and shutdown, we can leave the interrupt line asserted,
which is fatal with edge-triggered MSIs.

Add the required reading of INT0 to startup and shutdown. Also account
for the fact that a pending wake-up interrupt means we have to return 1
from exar_handle_irq. Drop the unneeded reading of INT1..3 along with
this - those never reset anything.

An alternative approach would have been disabling the wake-up interrupt.
Unfortunately, this feature (REGB[17] = 1) is not available on the
XR17D15X.

Fixes: 172c33cb61da ("serial: exar: Enable MSI support")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - mention removal of INT1..3 reading in commit log [Andy]
   (no functional changes)

 drivers/tty/serial/8250/8250_port.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6119516ef5fc..3a3667880fcf 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -47,6 +47,7 @@
 /*
  * These are definitions for the Exar XR17V35X and XR17(C|D)15X
  */
+#define UART_EXAR_INT0		0x80
 #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 #define UART_EXAR_DVID		0x8d	/* Device identification */
 
@@ -1869,17 +1870,13 @@ static int serial8250_default_handle_irq(struct uart_port *port)
 static int exar_handle_irq(struct uart_port *port)
 {
 	unsigned int iir = serial_port_in(port, UART_IIR);
-	int ret;
+	int ret = 0;
 
-	ret = serial8250_handle_irq(port, iir);
+	if (((port->type == PORT_XR17V35X) || (port->type == PORT_XR17D15X)) &&
+	    serial_port_in(port, UART_EXAR_INT0) != 0)
+		ret = 1;
 
-	if ((port->type == PORT_XR17V35X) ||
-	   (port->type == PORT_XR17D15X)) {
-		serial_port_in(port, 0x80);
-		serial_port_in(port, 0x81);
-		serial_port_in(port, 0x82);
-		serial_port_in(port, 0x83);
-	}
+	ret |= serial8250_handle_irq(port, iir);
 
 	return ret;
 }
@@ -2177,6 +2174,8 @@ int serial8250_do_startup(struct uart_port *port)
 	serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
+	if ((port->type == PORT_XR17V35X) || (port->type == PORT_XR17D15X))
+		serial_port_in(port, UART_EXAR_INT0);
 
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -2335,6 +2334,8 @@ int serial8250_do_startup(struct uart_port *port)
 	serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
+	if ((port->type == PORT_XR17V35X) || (port->type == PORT_XR17D15X))
+		serial_port_in(port, UART_EXAR_INT0);
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
-- 
2.12.0
