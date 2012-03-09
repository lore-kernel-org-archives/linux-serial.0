From: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 3/7] serial: sh-sci: restore big-endian operation.
Date: Fri, 9 Mar 2012 17:38:49 +0100
Message-ID: <1331311133-26937-3-git-send-email-thomas@codesourcery.com>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
Sender: linux-sh-owner@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

As of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
endianess-agnostic I/O accessor functions.

Tested on both litte-endian and big-endian sh7785lcr.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/sh-sci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index aff9d61..0b45258 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -332,9 +332,9 @@ static unsigned int sci_serial_in(struct uart_port *p, int offset)
 	struct plat_sci_reg *reg = sci_getreg(p, offset);
 
 	if (reg->size == 8)
-		return ioread8(p->membase + (reg->offset << p->regshift));
+		return __raw_readb(p->membase + (reg->offset << p->regshift));
 	else if (reg->size == 16)
-		return ioread16(p->membase + (reg->offset << p->regshift));
+		return __raw_readw(p->membase + (reg->offset << p->regshift));
 	else
 		WARN(1, "Invalid register access\n");
 
@@ -346,9 +346,9 @@ static void sci_serial_out(struct uart_port *p, int offset, int value)
 	struct plat_sci_reg *reg = sci_getreg(p, offset);
 
 	if (reg->size == 8)
-		iowrite8(value, p->membase + (reg->offset << p->regshift));
+		__raw_writeb(value, p->membase + (reg->offset << p->regshift));
 	else if (reg->size == 16)
-		iowrite16(value, p->membase + (reg->offset << p->regshift));
+		__raw_writew(value, p->membase + (reg->offset << p->regshift));
 	else
 		WARN(1, "Invalid register access\n");
 }
-- 
1.7.4.1

