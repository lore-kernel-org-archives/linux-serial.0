From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv2 2/5] serial: 8250_dw: Don't use UPF_FIXED_TYPE
Date: Mon,  3 Dec 2012 13:17:56 +0200
Message-ID: <1354533479-27306-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Allow 8250.c to determine the port type for us. This allows
the driver take advantage of FIFO on Designware UARTs that
have it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1d0dba2..ff83ea5 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -112,7 +112,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	uart.port.handle_irq = dw8250_handle_irq;
 	uart.port.type = PORT_8250;
 	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP |
-		UPF_FIXED_PORT | UPF_FIXED_TYPE;
+		UPF_FIXED_PORT;
 	uart.port.dev = &pdev->dev;
 
 	uart.port.iotype = UPIO_MEM;
-- 
1.7.10.4
