From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 02/05] serial: sh-sci: Fix default RTS handling
Date: Thu, 19 Mar 2015 10:49:53 +0900
Message-ID: <20150319014953.14235.86134.sendpatchset@little-apple>
References: <20150319014933.14235.44835.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150319014933.14235.44835.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, geert@glider.be, laurent.pinchart@ideasonboard.com, linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix the default SCIF handling in case CTS/RTS is available
on the target board but disabled by user space. Without
this patch the RTS output value is not set.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - When modem control is disabled, set RTS to zero to keep it asserted.

 drivers/tty/serial/sh-sci.c |    7 +++++--
 include/linux/serial_sci.h  |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

--- 0002/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2015-03-19 09:13:03.186797991 +0900
@@ -522,10 +522,13 @@ static void sci_init_ctsrts_default(stru
 	if (!reg->size || hwflow_enabled)
 		return;
 
+	/* Setup CTS/RTS in the case hardware flow is disabled by user space.
+	 * The CTS signal is setup as input and RTS as output with value 0.
+	 */
 	status = serial_port_in(port, SCSPTR);
-	status &= ~SCSPTR_CTSIO;
+	status &= ~(SCSPTR_CTSIO | SCSPTR_RTSDT);
 	status |= SCSPTR_RTSIO;
-	serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
+	serial_port_out(port, SCSPTR, status); /* Set RTS = 0 */
 }
 
 static void sci_init_pins(struct uart_port *port, unsigned int cflag)
--- 0001/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2015-03-19 09:11:14.936798380 +0900
@@ -57,6 +57,7 @@
 
 /* SCSPTR (Serial Port Register), optional */
 #define SCSPTR_RTSIO	(1 << 7)	/* Serial Port RTS Pin Input/Output */
+#define SCSPTR_RTSDT	(1 << 6)	/* Serial Port RTS Pin Data */
 #define SCSPTR_CTSIO	(1 << 5)	/* Serial Port CTS Pin Input/Output */
 #define SCSPTR_SPB2IO	(1 << 1)	/* Serial Port Break Input/Output */
 #define SCSPTR_SPB2DT	(1 << 0)	/* Serial Port Break Data */
