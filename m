From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/05] serial: sh-sci: Fix default RTS handling
Date: Wed, 17 Dec 2014 21:52:55 +0900
Message-ID: <20141217125255.14480.64174.sendpatchset@w520>
References: <20141217125236.14480.78833.sendpatchset@w520>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141217125236.14480.78833.sendpatchset@w520>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix the default SCIF handling in case CTS/RTS is available
on the target board but disabled by user space. Without
this patch the RTS output value is not set.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/tty/serial/sh-sci.c |    5 ++++-
 include/linux/serial_sci.h  |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

--- 0004/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2014-12-16 14:31:53.000000000 +0900
@@ -522,9 +522,12 @@ static void sci_init_pins_default(struct
 	if (!reg->size || hwflow_enabled)
 		return;
 
+	/* Setup CTS/RTS in the case hardware flow is disabled by user space.
+	 * The CTS signal is setup as input and RTS as output with value 1.
+	 */
 	status = serial_port_in(port, SCSPTR);
 	status &= ~SCSPTR_CTSIO;
-	status |= SCSPTR_RTSIO;
+	status |= SCSPTR_RTSIO | SCSPTR_RTSDT;
 	serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
 }
 
--- 0001/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2014-12-16 14:25:40.000000000 +0900
@@ -57,6 +57,7 @@
 
 /* SCSPTR (Serial Port Register), optional */
 #define SCSPTR_RTSIO	(1 << 7)	/* Serial Port RTS Pin Input/Output */
+#define SCSPTR_RTSDT	(1 << 6)	/* Serial Port RTS Pin Data */
 #define SCSPTR_CTSIO	(1 << 5)	/* Serial Port CTS Pin Input/Output */
 #define SCSPTR_SPB2IO	(1 << 1)	/* Serial Port Break Input/Output */
 #define SCSPTR_SPB2DT	(1 << 0)	/* Serial Port Break Data */
