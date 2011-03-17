From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [RFC PATCH 1/2] serial: 8250: Add a notifier chain for driver
	registration.
Date: Wed, 16 Mar 2011 18:26:06 -0700
Message-ID: <1300325167-26433-2-git-send-email-ddaney@caviumnetworks.com>
References: <1300325167-26433-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1300325167-26433-1-git-send-email-ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The 8250 driver is a bit weird in that in addition to supporting
platform devices, extra devices can be added by calling
serial8250_register_port().

The problem is that if we call serial8250_register_port() before the
driver is initialized Bad Things happen (we dereference NULL
pointers).

There doesn't seem to be a general way to know if a driver has been
initialized, so we add a notifier chain just for this driver.  When the
SERIAL8250_DRIVER_ADD notifier is called, we know it is safe to call
serial8250_register_port(), and we can add our devices.

Signed-off-by: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
---
 drivers/tty/serial/8250.c   |   20 ++++++++++++++++++++
 include/linux/serial_8250.h |   21 +++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 3975df6..229a1d2 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -3281,6 +3281,20 @@ void serial8250_unregister_port(int line)
 }
 EXPORT_SYMBOL(serial8250_unregister_port);
 
+static BLOCKING_NOTIFIER_HEAD(serial8250_notifier);
+
+int serial8250_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&serial8250_notifier, nb);
+}
+EXPORT_SYMBOL(serial8250_register_notifier);
+
+int serial8250_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&serial8250_notifier, nb);
+}
+EXPORT_SYMBOL(serial8250_unregister_notifier);
+
 static int __init serial8250_init(void)
 {
 	int ret;
@@ -3328,6 +3342,10 @@ unreg_uart_drv:
 	uart_unregister_driver(&serial8250_reg);
 #endif
 out:
+	if (ret == 0)
+		blocking_notifier_call_chain(&serial8250_notifier,
+					     SERIAL8250_DRIVER_ADD, NULL);
+
 	return ret;
 }
 
@@ -3335,6 +3353,8 @@ static void __exit serial8250_exit(void)
 {
 	struct platform_device *isa_dev = serial8250_isa_devs;
 
+	blocking_notifier_call_chain(&serial8250_notifier,
+				     SERIAL8250_DRIVER_REMOVE, NULL);
 	/*
 	 * This tells serial8250_unregister_port() not to re-register
 	 * the ports (thereby making serial8250_isa_driver permanently
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 97f5b45..2155c28 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SERIAL_8250_H
 #define _LINUX_SERIAL_8250_H
 
+#include <linux/notifier.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 
@@ -85,4 +86,24 @@ extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
 						unsigned short *capabilities));
 
+extern int serial8250_register_notifier(struct notifier_block *nb);
+extern int serial8250_unregister_notifier(struct notifier_block *nb);
+/*
+ * Notifiers get called to allow serial8250_register_port() after the
+ * driver is registered, and serial8250_unregister_port() to be called
+ * before it is unregistered.
+ */
+#define SERIAL8250_DRIVER_ADD 1
+#define SERIAL8250_DRIVER_REMOVE 2
+
+#define serial8250_notifier(fn, pri)				\
+({								\
+	static struct notifier_block fn##_nb = {		\
+		.notifier_call = fn,				\
+		.priority = pri					\
+	};							\
+								\
+	serial8250_register_notifier(&fn##_nb);			\
+})
+
 #endif
-- 
1.7.2.3
