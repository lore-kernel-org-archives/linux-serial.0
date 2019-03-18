From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference
Date: Mon, 18 Mar 2019 18:50:56 -0500
Message-ID: <20190318235056.10736-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

of_match_device on failure to find a matching device can return a NULL
pointer. The patch checks for such a scenrio and passes the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/tty/serial/mvebu-uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 231f751d1ef4..7e7b1559fa36 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -810,6 +810,9 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (!match)
+		return -ENODEV;
+
 	/* Assume that all UART ports have a DT alias or none has */
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (!pdev->dev.of_node || id < 0)
-- 
2.17.1
