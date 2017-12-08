From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] serial: ioc4: Adjust three function calls together with a
 variable assignment
Date: Fri, 8 Dec 2017 22:53:26 +0100
Message-ID: <0256ab08-9330-26d6-19eb-e3c264c1ff1d@users.sourceforge.net>
References: <514232dd-7e91-00f9-b95c-3e8f740090ca@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <514232dd-7e91-00f9-b95c-3e8f740090ca@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pat Gefre <pfg@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 22:40:31 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ioc4_serial.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index 6981ad2ca1b7..ba95a4cb8130 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -1945,7 +1945,8 @@ static void handle_intr(void *arg, uint32_t sio_ir)
 			 * hasn't been delivered to the cpu yet anyway, even
 			 * though we see it as asserted when we read the sio_ir.
 			 */
-			if ((sio_ir = PENDING(port)) & hooks->intr_rx_high) {
+			sio_ir = PENDING(port);
+			if (sio_ir & hooks->intr_rx_high) {
 				if ((port->ip_flags & READ_ABORTED) == 0) {
 					port->ip_ienb &= ~hooks->intr_rx_high;
 					port->ip_flags |= INPUT_HIGH;
@@ -2902,16 +2903,18 @@ static struct ioc4_submodule ioc4_serial_submodule = {
  */
 static int __init ioc4_serial_init(void)
 {
-	int ret;
-
 	/* register with serial core */
-	if ((ret = uart_register_driver(&ioc4_uart_rs232)) < 0) {
+	int ret = uart_register_driver(&ioc4_uart_rs232);
+
+	if (ret < 0) {
 		printk(KERN_WARNING
 			"%s: Couldn't register rs232 IOC4 serial driver\n",
 			__func__);
 		goto out;
 	}
-	if ((ret = uart_register_driver(&ioc4_uart_rs422)) < 0) {
+
+	ret = uart_register_driver(&ioc4_uart_rs422);
+	if (ret < 0) {
 		printk(KERN_WARNING
 			"%s: Couldn't register rs422 IOC4 serial driver\n",
 			__func__);
-- 
2.15.1
