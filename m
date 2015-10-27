From: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH] tty: serial: sa1100.c: use UPIO_MEM rather than SERIAL_IO_MEM
Date: Tue, 27 Oct 2015 13:16:57 +0530
Message-ID: <1445932017-4136-1-git-send-email-saurabh.truth@gmail.com>
References: <saurabh.truth@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <saurabh.truth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>
List-Id: linux-serial@vger.kernel.org

use UPIO_MEM rather then SERIAL_IO_MEM.
both have the same value

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 drivers/tty/serial/sa1100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index fd3d132..283c7e0 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -579,7 +579,7 @@ sa1100_verify_port(struct uart_port *port, struct serial_struct *ser)
 		ret = -EINVAL;
 	if (sport->port.irq != ser->irq)
 		ret = -EINVAL;
-	if (ser->io_type != SERIAL_IO_MEM)
+	if (ser->io_type != UPIO_MEM)
 		ret = -EINVAL;
 	if (sport->port.uartclk / 16 != ser->baud_base)
 		ret = -EINVAL;
-- 
1.9.1
