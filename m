From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] serial: bfin_uart: Delete an error message for a failed
 memory allocation in bfin_serial_probe()
Date: Sat, 9 Dec 2017 22:11:35 +0100
Message-ID: <6d49e768-0b26-991c-ec4a-ed9226f4da05@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Dec 2017 22:05:54 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/bfin_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 4755fa696321..558f6ebc4f01 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -1221,11 +1221,9 @@ static int bfin_serial_probe(struct platform_device *pdev)
 	if (bfin_serial_ports[pdev->id] == NULL) {
 
 		uart = kzalloc(sizeof(*uart), GFP_KERNEL);
-		if (!uart) {
-			dev_err(&pdev->dev,
-				"fail to malloc bfin_serial_port\n");
+		if (!uart)
 			return -ENOMEM;
-		}
+
 		bfin_serial_ports[pdev->id] = uart;
 
 #ifdef CONFIG_EARLY_PRINTK
-- 
2.15.1
