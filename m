From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] serial: ioc4: Improve four size determinations
Date: Fri, 8 Dec 2017 22:52:12 +0100
Message-ID: <daff34f5-741d-d54c-81ce-aebd962d25c9@users.sourceforge.net>
References: <514232dd-7e91-00f9-b95c-3e8f740090ca@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <514232dd-7e91-00f9-b95c-3e8f740090ca@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pat Gefre <pfg@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 22:22:25 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ioc4_serial.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index 9524a6d3e1d8..6981ad2ca1b7 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -1075,7 +1075,7 @@ static inline int ioc4_attach_local(struct ioc4_driver_data *idd)
 	/* Create port structures for each port */
 	for (port_number = 0; port_number < IOC4_NUM_SERIAL_PORTS;
 							port_number++) {
-		port = kzalloc(sizeof(struct ioc4_port), GFP_KERNEL);
+		port = kzalloc(sizeof(*port), GFP_KERNEL);
 		if (!port)
 			goto free;
 
@@ -2797,7 +2797,7 @@ ioc4_serial_attach_one(struct ioc4_driver_data *idd)
 		ret = -ENODEV;
 		goto out1;
 	}
-	serial = ioremap(tmp_addr1, sizeof(struct ioc4_serial));
+	serial = ioremap(tmp_addr1, sizeof(*serial));
 	if (!serial) {
 		printk(KERN_WARNING
 			 "ioc4 (%p) : unable to remap ioc4 serial register\n",
@@ -2810,8 +2810,7 @@ ioc4_serial_attach_one(struct ioc4_driver_data *idd)
 				(void *)serial));
 
 	/* Get memory for the new card */
-	control = kzalloc(sizeof(struct ioc4_control), GFP_KERNEL);
-
+	control = kzalloc(sizeof(*control), GFP_KERNEL);
 	if (!control) {
 		ret = -ENOMEM;
 		goto out2;
@@ -2819,7 +2818,7 @@ ioc4_serial_attach_one(struct ioc4_driver_data *idd)
 	idd->idd_serial_data = control;
 
 	/* Allocate the soft structure */
-	soft = kzalloc(sizeof(struct ioc4_soft), GFP_KERNEL);
+	soft = kzalloc(sizeof(*soft), GFP_KERNEL);
 	if (!soft) {
 		ret = -ENOMEM;
 		goto out3;
-- 
2.15.1

