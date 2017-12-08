From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] serial: ioc4: Delete error messages for a failed memory
 allocation in two functions
Date: Fri, 8 Dec 2017 22:51:15 +0100
Message-ID: <d3a28c8f-b997-6f5c-8a08-d02d7ef3648f@users.sourceforge.net>
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
Date: Fri, 8 Dec 2017 22:15:53 +0100

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ioc4_serial.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index db5b979e5a0c..9524a6d3e1d8 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -1076,11 +1076,9 @@ static inline int ioc4_attach_local(struct ioc4_driver_data *idd)
 	for (port_number = 0; port_number < IOC4_NUM_SERIAL_PORTS;
 							port_number++) {
 		port = kzalloc(sizeof(struct ioc4_port), GFP_KERNEL);
-		if (!port) {
-			printk(KERN_WARNING
-				"IOC4 serial memory not available for port\n");
+		if (!port)
 			goto free;
-		}
+
 		spin_lock_init(&port->ip_lock);
 
 		/* we need to remember the previous ones, to point back to
@@ -2815,8 +2813,6 @@ ioc4_serial_attach_one(struct ioc4_driver_data *idd)
 	control = kzalloc(sizeof(struct ioc4_control), GFP_KERNEL);
 
 	if (!control) {
-		printk(KERN_WARNING "ioc4_attach_one"
-		       ": unable to get memory for the IOC4\n");
 		ret = -ENOMEM;
 		goto out2;
 	}
@@ -2825,9 +2821,6 @@ ioc4_serial_attach_one(struct ioc4_driver_data *idd)
 	/* Allocate the soft structure */
 	soft = kzalloc(sizeof(struct ioc4_soft), GFP_KERNEL);
 	if (!soft) {
-		printk(KERN_WARNING
-		       "ioc4 (%p): unable to get memory for the soft struct\n",
-		       (void *)idd->idd_pdev);
 		ret = -ENOMEM;
 		goto out3;
 	}
-- 
2.15.1
