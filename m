Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F313D2BE;
	Wed,  3 Jul 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001208; cv=none; b=cZY3Mk8i4mhZaOlUOpYKQm70Z0QkiTCWtLSqQQZYC7Hqm0NK5XzNvo094SBlvvWeROAg/6V/nY1GLmtl2awy+9DYpC35iojFUt3FyS1crwyh0vawsazpYGLV6oaz5QzH6HT6PYHou+y0SWL5BUVp8LMLWJaJJaHGG/9pb02lcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001208; c=relaxed/simple;
	bh=eaqYx0tP7xE/NKkuA/s0zoqf+t488PDvb5zZwZQtox0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7nd7w8SSrNUn4uu1xFBFWkVZZDcI7kiphXb0qxftQ2JdCGw7tP7eE+8mCT5juJAv+x7/bb+cU4GAec63Ovq20vFubd4cb0PpOjL7I+arwO86wsuTnvZ5DwG/2eTsF4yJdbfAQ0eCJwt13EjoErViwMnhUNe/YtmxYsrLiYNVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIrHcnmR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIrHcnmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720001207; x=1751537207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaqYx0tP7xE/NKkuA/s0zoqf+t488PDvb5zZwZQtox0=;
  b=QIrHcnmRee2whOWm5p8CS6bS3CUgFCi93N/GqbL902y080axvX7R5yQD
   XVd+IWfnGsw0jFHuNk1tY5vC2/bgfmbOa3xIoCOLIWrzSvv22XXZ64s/o
   srL8XYS7HLmeC2L9vBlEsTgREBS8yeM2fKDoyeZI+CPPCivtT8EmFlJS6
   xAuY4SWrhQxEQHBAXQ4hCPtobwnp+7/j1CD4g8YOklP2MDiSKskM4BsHn
   FRpJ7M5yNXSfltmqw6tGvhimb4ihYpp1EBFo/Yv/tOtcE5Z/jMFkU05hs
   EnQ9UWkReFmlpTrLFoa3Hvo51ttgwuDq7v/0tQr6pIM7eK7f42sif7YZU
   w==;
X-CSE-ConnectionGUID: nDgnDkldSKihA8h68YzmNg==
X-CSE-MsgGUID: YPlLRyMcSt2P4/MfIgRaCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21093801"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="21093801"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:06:46 -0700
X-CSE-ConnectionGUID: HEWMSNoRQg+kEy2LcU9Eiw==
X-CSE-MsgGUID: r8ET8w7VTySEIY8hsocqrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="69385006"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO tlindgre-MOBL1.intel.com) ([10.245.244.185])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:06:41 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] serial: core: Add serial_base_match_and_update_preferred_console()
Date: Wed,  3 Jul 2024 13:06:09 +0300
Message-ID: <20240703100615.118762-3-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
References: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
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

