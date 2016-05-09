From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/7] tty: 8250, drop unused members from struct old_serial_port
Date: Mon,  9 May 2016 09:11:58 +0200
Message-ID: <1462777919-10367-6-git-send-email-jslaby@suse.cz>
References: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

hub6 and irqflags from struct old_serial_port are nowhere set. Drop
them from the structure and replace the reads by zeros.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/8250.h      | 2 --
 drivers/tty/serial/8250/8250_core.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 215a99237e95..563ccbe3612b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -53,11 +53,9 @@ struct old_serial_port {
 	unsigned int port;
 	unsigned int irq;
 	upf_t        flags;
-	unsigned char hub6;
 	unsigned char io_type;
 	unsigned char __iomem *iomem_base;
 	unsigned short iomem_reg_shift;
-	unsigned long irqflags;
 };
 
 struct serial8250_config {
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0fbd7c033a25..e938ac93743a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -546,10 +546,10 @@ static void __init serial8250_isa_init_ports(void)
 
 		port->iobase   = old_serial_port[i].port;
 		port->irq      = irq_canonicalize(old_serial_port[i].irq);
-		port->irqflags = old_serial_port[i].irqflags;
+		port->irqflags = 0;
 		port->uartclk  = old_serial_port[i].baud_base * 16;
 		port->flags    = old_serial_port[i].flags;
-		port->hub6     = old_serial_port[i].hub6;
+		port->hub6     = 0;
 		port->membase  = old_serial_port[i].iomem_base;
 		port->iotype   = old_serial_port[i].io_type;
 		port->regshift = old_serial_port[i].iomem_reg_shift;
-- 
2.8.2
