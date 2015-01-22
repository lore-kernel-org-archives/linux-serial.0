From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 1/2] PNP: Allow console to override ACPI device sleep
Date: Thu, 22 Jan 2015 11:50:24 -0500
Message-ID: <1421945425-5326-2-git-send-email-peter@hurleysoftware.com>
References: <1421945425-5326-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421945425-5326-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

If the serial console is an ACPI PNP device, the PNP bus always powers
down the device at system suspend, even though the no_console_suspend
command line parameter is specified (eg., when debugging suspend/resume).

Add PNP_CONSOLE capability, which when set, prevents calling both the
->disable() and ->suspend() PNP protocol methods if console suspend
is disabled.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/pnp/driver.c |  2 +-
 include/linux/pnp.h  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index f748cc8..4e57d33 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -182,7 +182,7 @@ static int __pnp_bus_suspend(struct device *dev, pm_message_t state)
 			return error;
 	}
 
-	if (pnp_dev->protocol->suspend)
+	if (pnp_can_suspend(pnp_dev))
 		pnp_dev->protocol->suspend(pnp_dev, state);
 	return 0;
 }
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 195aafc..6512e9c 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
+#include <linux/console.h>
 
 #define PNP_NAME_LEN		50
 
@@ -309,15 +310,22 @@ struct pnp_fixup {
 #define PNP_DISABLE		0x0004
 #define PNP_CONFIGURABLE	0x0008
 #define PNP_REMOVABLE		0x0010
+#define PNP_CONSOLE		0x0020
 
 #define pnp_can_read(dev)	(((dev)->protocol->get) && \
 				 ((dev)->capabilities & PNP_READ))
 #define pnp_can_write(dev)	(((dev)->protocol->set) && \
 				 ((dev)->capabilities & PNP_WRITE))
-#define pnp_can_disable(dev)	(((dev)->protocol->disable) && \
-				 ((dev)->capabilities & PNP_DISABLE))
+#define pnp_can_disable(dev)	(((dev)->protocol->disable) &&		  \
+				 ((dev)->capabilities & PNP_DISABLE) &&	  \
+				 (!((dev)->capabilities & PNP_CONSOLE) || \
+				  console_suspend_enabled))
 #define pnp_can_configure(dev)	((!(dev)->active) && \
 				 ((dev)->capabilities & PNP_CONFIGURABLE))
+#define pnp_can_suspend(dev)	(((dev)->protocol->suspend) &&		  \
+				 (!((dev)->capabilities & PNP_CONSOLE) || \
+				  console_suspend_enabled))
+
 
 #ifdef CONFIG_ISAPNP
 extern struct pnp_protocol isapnp_protocol;
-- 
2.2.2
