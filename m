Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C11AC799;
	Thu, 20 Jun 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887605; cv=none; b=VALYywVcHwfTU2nFPo0e4763Gex1mA+RWNUdZqzYmnSJypUAYCdRFRuCWgLx1+Ltih329z64mse6ChQfRwQnW8rZOVoz8htk7IUgYK+tAUiH76cLrRUqy1x8IG1e4XI7+N2SpfP+YCO52lzlfb2zm2HmmKd7UXQASw5DbuuLjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887605; c=relaxed/simple;
	bh=eaqYx0tP7xE/NKkuA/s0zoqf+t488PDvb5zZwZQtox0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2KlRqb4XPCFZKlQf/GqsCFSuKu8clk2RMbFYAde60rUyBDsV1tkDVXQkOw3vaL4t3EueAzD2dAfgy/8OYN2iqPpchPbZJ4rDCp3IUJ1w65/zNP+If5+8VGtL1EQceax2VbgsfWlmEf2xKcicGWpk0/Tb+BLAjoQC0Cr7EY9D6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnB1hhJd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnB1hhJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718887604; x=1750423604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaqYx0tP7xE/NKkuA/s0zoqf+t488PDvb5zZwZQtox0=;
  b=PnB1hhJdV7w2U1PpH3FAa+0a8UT6s8Ae1zOrtJ9Y76PKcfLbBniVtZzu
   ammVgYieepp8VTY7NRI8Nw5mUfD0ERzmMaRXNLMWV0uj7yZC/BvEtC6fH
   5OMGMpzHoSiBatxrDIa1V7GjIbF1EnLjk3bqmGSok2/7mFokVTTlROqIq
   /biSapXIB/kpeqGr+H33hQHpOHTGaEC0KD+FTPHV+sKaDHsOmsqU4xWTv
   RLJjRgQzkFJ7IGPA1KQOowRJ7+G3tW35nzE8huSV+ebuEREAPUZBUarmB
   /5T/lnxP03T40K0tysxVSJxxgNIo6FUPaZFkbj1fFx2I8GUsd0VR95pgn
   Q==;
X-CSE-ConnectionGUID: egMwXlQkSZOHDvJ5u4Aswg==
X-CSE-MsgGUID: GJDKnLGbR9GwaGXnqnLlDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26985698"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26985698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:46:43 -0700
X-CSE-ConnectionGUID: bKrI8d5JQ1CaEc9iGsMd9Q==
X-CSE-MsgGUID: K0oDnHn1T1msDYgNtXmxCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42888798"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO tlindgre-MOBL1.intel.com) ([10.245.247.35])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:46:39 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] serial: core: Add serial_base_match_and_update_preferred_console()
Date: Thu, 20 Jun 2024 15:45:29 +0300
Message-ID: <20240620124541.164931-5-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's add serial_base_match_and_update_preferred_console() for consoles
using DEVNAME:0.0 style naming.

The earlier approach to add it caused issues in the kernel command line
ordering as we were calling __add_preferred_console() again for the
deferred consoles.

Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 drivers/tty/serial/serial_base.h     | 16 ++++++++++++
 drivers/tty/serial/serial_base_bus.c | 37 ++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |  4 +++
 3 files changed, 57 insertions(+)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
index b6c38d2edfd4..0d50db5b660b 100644
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -49,3 +49,19 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
 
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
+
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+int serial_base_match_and_update_preferred_console(struct uart_driver *drv,
+						   struct uart_port *port);
+
+#else
+
+static inline
+int serial_base_match_and_update_preferred_console(struct uart_driver *drv,
+						   struct uart_port *port)
+{
+	return 0;
+}
+
+#endif
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 4df2a4b10445..d822499ba9d6 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -8,6 +8,7 @@
  * The serial core bus manages the serial core controller instances.
  */
 
+#include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/idr.h>
@@ -204,6 +205,42 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 	put_device(&port_dev->dev);
 }
 
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+/**
+ * serial_base_match_and_update_preferred_console - Match and update a preferred console
+ * @drv: Serial port device driver
+ * @port: Serial port instance
+ *
+ * Tries to match and update the preferred console for a serial port for
+ * the kernel command line option console=DEVNAME:0.0.
+ *
+ * Cannot be called early for ISA ports, depends on struct device.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int serial_base_match_and_update_preferred_console(struct uart_driver *drv,
+						   struct uart_port *port)
+{
+	const char *port_match __free(kfree) = NULL;
+	int ret;
+
+	port_match = kasprintf(GFP_KERNEL, "%s:%d.%d", dev_name(port->dev),
+			       port->ctrl_id, port->port_id);
+	if (!port_match)
+		return -ENOMEM;
+
+	ret = match_devname_and_update_preferred_console(port_match,
+							 drv->dev_name,
+							 port->line);
+	if (ret == -ENOENT)
+		return 0;
+
+	return ret;
+}
+
+#endif
+
 static int serial_base_init(void)
 {
 	int ret;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2a8006e3d687..9a18d0b95a41 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3422,6 +3422,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	if (ret)
 		goto err_unregister_ctrl_dev;
 
+	ret = serial_base_match_and_update_preferred_console(drv, port);
+	if (ret)
+		goto err_unregister_port_dev;
+
 	ret = serial_core_add_one_port(drv, port);
 	if (ret)
 		goto err_unregister_port_dev;
-- 
2.45.2

