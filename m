From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] 8250/fintek: rename IRQ_MODE macro
Date: Mon, 27 Jun 2016 11:21:10 +0200
Message-ID: <20160627092152.1430477-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Alan Cox <alan@linux.intel.com>, "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

A bugfix for the fintek driver required defining some macros, but
one of them clashes with a system header on ARM:

drivers/tty/serial/8250/8250_fintek.c:34:0: error: "IRQ_MODE" redefined [-Werror]
 #define IRQ_MODE 0x70

In file included from /git/arm-soc/arch/arm/include/asm/ptrace.h:13:0,
                 from /git/arm-soc/arch/arm/include/asm/irqflags.h:6,
                 from /git/arm-soc/include/linux/irqflags.h:15,
                 from /git/arm-soc/arch/arm/include/asm/bitops.h:27,
                 from /git/arm-soc/include/linux/bitops.h:36,
                 from /git/arm-soc/include/linux/kernel.h:10,
                 from /git/arm-soc/include/linux/list.h:8,
                 from /git/arm-soc/include/linux/module.h:9,
                 from /git/arm-soc/drivers/tty/serial/8250/8250_fintek.c:11:
arch/arm/include/uapi/asm/ptrace.h:55:0: note: this is the location of the previous definition

This renames the newly introduced 'IRQ_MODE' macro to FINTEK_IRQ_MODE.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4da22f1418cb ("serial: 8250_fintek: fix the mismatched IRQ mode")
---
 drivers/tty/serial/8250/8250_fintek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 737b4b3957b0..0facc789fe7d 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -31,7 +31,7 @@
 #define IO_ADDR2 0x60
 #define LDN 0x7
 
-#define IRQ_MODE	0x70
+#define FINTEK_IRQ_MODE	0x70
 #define IRQ_SHARE	BIT(4)
 #define IRQ_MODE_MASK	(BIT(6) | BIT(5))
 #define IRQ_LEVEL_LOW	0
@@ -195,7 +195,7 @@ static int fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool level_mode)
 	outb(LDN, pdata->base_port + ADDR_PORT);
 	outb(pdata->index, pdata->base_port + DATA_PORT);
 
-	outb(IRQ_MODE, pdata->base_port + ADDR_PORT);
+	outb(FINTEK_IRQ_MODE, pdata->base_port + ADDR_PORT);
 	tmp = inb(pdata->base_port + DATA_PORT);
 
 	tmp &= ~IRQ_MODE_MASK;
-- 
2.9.0
