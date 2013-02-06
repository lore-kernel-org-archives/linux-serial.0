From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH] ACPI / serial: Add UART change_pm support with ACPI power domain
Date: Wed,  6 Feb 2013 14:26:26 +0800
Message-ID: <69483f548e2d5476b8e1ce530e6910bfbf770d3d.1360131884.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41386 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab3BFG1i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 01:27:38 -0500
In-Reply-To: <cover.1354505471.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Krogerus Heikki <heikki.krogerus@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch enables ACPI power domain on UART user devices. With this
patch, Linux can achieve open/close based ACPI power manageability for
UART tty ports.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpi_uart.c         |   40 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c |    5 +++++
 include/linux/tty.h              |    4 ++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/acpi/acpi_uart.c b/drivers/acpi/acpi_uart.c
index c27fc7c..a6735b1 100644
--- a/drivers/acpi/acpi_uart.c
+++ b/drivers/acpi/acpi_uart.c
@@ -163,3 +163,43 @@ void acpi_uart_register_user_device(struct device *parent,
 	}
 }
 EXPORT_SYMBOL_GPL(acpi_uart_register_user_device);
+
+/**
+ * acpi_uart_user_change_pm - change pm for tty port
+ * @port: the tty port
+ * @power_on: whether or not power on the device
+ *
+ * Change PM for tty user device.
+ */
+void acpi_uart_user_change_pm(struct tty_port *port, bool power_on)
+{
+	acpi_handle handle;
+	struct acpi_device *adev;
+	struct acpi_device_physical_node *entry;
+	struct device *ldev;
+
+	BUG_ON(!port);
+	handle = ACPI_NODE_GET(port->acpi_node);
+	if (!handle)
+		return;
+	if (acpi_bus_get_device(handle, &adev))
+		return;
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return;
+
+	list_for_each_entry(entry, &adev->physical_node_list, node) {
+		ldev = get_device(entry->dev);
+		if (!ldev)
+			continue;
+		if (ldev->class == tty_class) {
+			if (power_on)
+				acpi_dev_pm_attach(ldev, true);
+			else
+				acpi_dev_pm_detach(ldev, false);
+			put_device(ldev);
+			return;
+		}
+		put_device(ldev);
+	}
+}
+EXPORT_SYMBOL_GPL(acpi_uart_user_change_pm);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c10bb4c..6ca4a5c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1901,10 +1901,15 @@ static void uart_change_pm(struct uart_state *state,
 			   enum uart_pm_state pm_state)
 {
 	struct uart_port *port = state->uart_port;
+	struct tty_port *tport = &state->port;
 
 	if (state->pm_state != pm_state) {
+		if (pm_state == UART_PM_STATE_ON)
+			acpi_uart_user_change_pm(tport, true);
 		if (port->ops->pm)
 			port->ops->pm(port, pm_state, state->pm_state);
+		if (pm_state == UART_PM_STATE_OFF)
+			acpi_uart_user_change_pm(tport, false);
 		state->pm_state = pm_state;
 	}
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5f17ab5..fbf8def 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -687,11 +687,15 @@ void acpi_uart_register_user_device(struct device *parent,
 		struct device *dev,
 		struct tty_driver *driver,
 		unsigned int index);
+extern void acpi_uart_user_change_pm(struct tty_port *port,
+		bool power_on);
 #else
 static inline void acpi_uart_register_user_device(struct device *parent,
 		struct device *dev,
 		struct tty_driver *driver,
 		unsigned int index) {}
+static inline void acpi_uart_user_change_pm(struct tty_port *port,
+		bool power_on) {}
 #endif
 
 #endif
-- 
1.7.10

