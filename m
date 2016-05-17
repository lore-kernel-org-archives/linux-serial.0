From: Purna Chandra Mandal <purna.mandal@microchip.com>
Subject: [PATCH 05/11] serial: pic32_uart: Fix double free of 'sport->irq_fault_name'.
Date: Tue, 17 May 2016 10:35:54 +0530
Message-ID: <1463461560-9629-5-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Purna Chandra Mandal <purna.mandal@microchip.com>, Jiri Slaby <jslaby@suse.com>, Alan Cox <alan@linux.intel.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Allocated memory for 'sport->irq_fault_name' is freed twice, first
in error check of 'if(!sport->irq_rx_name)' and other in fallback
handler.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

---

 drivers/tty/serial/pic32_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 62a43bf..7f8e99b 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -445,7 +445,6 @@ static int pic32_uart_startup(struct uart_port *port)
 				       sport->idx);
 	if (!sport->irq_rx_name) {
 		dev_err(port->dev, "%s: kasprintf err!", __func__);
-		kfree(sport->irq_fault_name);
 		ret = -ENOMEM;
 		goto out_f;
 	}
-- 
1.8.3.1
