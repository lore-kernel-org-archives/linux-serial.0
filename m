From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] serial: pch_uart: Improve a size determination in
 pch_uart_init_port()
Date: Fri, 8 Dec 2017 19:12:33 +0100
Message-ID: <db26819b-ac42-9e73-c95c-aecbbd96cd98@users.sourceforge.net>
References: <f8220e08-da4c-65d6-ecc7-9405cab6f375@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f8220e08-da4c-65d6-ecc7-9405cab6f375@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 18:53:21 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/pch_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 790a7aae331f..1c30309ef02c 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1747,7 +1747,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	board = &drv_dat[id->driver_data];
 	port_type = board->port_type;
 
-	priv = kzalloc(sizeof(struct eg20t_port), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
 		goto init_port_alloc_err;
 
-- 
2.15.1
