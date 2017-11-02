From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: mvebu-uart: drop incorrect memset
Date: Thu,  2 Nov 2017 12:34:24 +0100
Message-ID: <20171102113441.781447-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miquel Raynal <miquel.raynal@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Allen Yan <yanwei@marvell.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

gcc points out that the length passed into memset here is wrong:

drivers/tty/serial/mvebu-uart.c: In function 'mvebu_uart_probe':
arch/x86/include/asm/string_32.h:324:29: error: 'memset' used with length equal to number of elements without multiplication by element size [-Werror=memset-elt-size]

Moreover, the structure was allocated with kzalloc a few lines earlier,
so that memset is also unnecessary. Let's drop it to shut up the
compiler warning.

Fixes: 95f787685a22 ("serial: mvebu-uart: dissociate RX and TX interrupts")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/mvebu-uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 16b0a5aa14e2..85eb5c86d177 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -817,7 +817,6 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	}
 
 	/* Manage interrupts */
-	memset(mvuart->irq, 0, UART_IRQ_COUNT);
 	if (platform_irq_count(pdev) == 1) {
 		/* Old bindings: no name on the single unamed UART0 IRQ */
 		irq = platform_get_irq(pdev, 0);
-- 
2.9.0
