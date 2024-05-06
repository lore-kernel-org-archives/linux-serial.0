Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C281722;
	Mon,  6 May 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004195; cv=none; b=dqBppGN4cKEnUL+E6Et67VMYciCH61fp4eiT6y7S9H2XIBrm0qocAZYqmjeZwLrki/QCFaMPGf/YQFPcETKzl/s//Rhwoe0e1KW8umiuTNl3hwqSox+K6TzBnPObJpWQ53Zed51lILPoz4Vaa/vXD6Y+jfLyoaGbzhrIWfx+bmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004195; c=relaxed/simple;
	bh=V5D5L9YVjE9xfzXMps6VNi7Pjkp2TVvkPcZOCbEYXLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pk596MvZZH3pH/rQkm7hGofi5tKWBDigP64Bo4L2qdSclYZDIDepSLCljJbxDwZoqEw/ZDQIxVdnZdVhmo+xWSTfpkbD0yprLUunkf3+dohheiEw+o2WYUXkJM3r22knNPqJMVPLTAPc1m9memHwu+58Vo8Y3WZPmTcRKqtVaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2hZrL1j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2hZrL1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715004194; x=1746540194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5D5L9YVjE9xfzXMps6VNi7Pjkp2TVvkPcZOCbEYXLM=;
  b=A2hZrL1jJH79ipxVVLDbFhIs3luS3Pjufxe4eH5FaE6mDtt+Yn3D7rxq
   ZGa6/80sxqyG3UM9Q26fwxNF0/ahcStFfKwZH+7ioxcgfN5XhWeox8e6r
   Z8IZUtO4pqBhldDfCsBAE5525qjik/qjlCWmC6XhJy/BcsL2uWtrIK5TK
   xcLDhYLBtZYTfAAI81YTrkoeLUThNLw2IwBPCnOq6FK+jUjy0FZYziBZJ
   vCPTsXm8wOItFw+pnlJuRjigNnDRVcxlqSspfKZuqgjBZaYtUVmSPhYSj
   meFrxEJK2YUYgHb8ajmNKwehRiCptPYkC0Je43jMo+RluV2rYlSNgMbRU
   A==;
X-CSE-ConnectionGUID: cRTNU3hbThmb8Se3TmEMiw==
X-CSE-MsgGUID: lHOX0/gBQz6HfxIVLnSMJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13696624"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="13696624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:03:13 -0700
X-CSE-ConnectionGUID: dkemRQMRQZmFEaRpxjXwXg==
X-CSE-MsgGUID: 2OinaE3KRAy2IDseIEW1dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="59044874"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 07:03:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B5AF468; Mon, 06 May 2024 17:03:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	unil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 1/2] serial: 8250: Extract RSA bits
Date: Mon,  6 May 2024 17:00:58 +0300
Message-ID: <20240506140308.4040735-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
References: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract RSA bits to a separate module for better maintenance
and to reduce a churn on 8250_core part changes when it's solely
related to the former. No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      |   7 ++
 drivers/tty/serial/8250/8250_core.c | 124 +-------------------------
 drivers/tty/serial/8250/8250_rsa.c  | 133 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Makefile    |   1 +
 4 files changed, 145 insertions(+), 120 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_rsa.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 6a7b286f6f5a..ac218412e54e 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -111,6 +111,7 @@ struct serial8250_config {
 
 #define SERIAL8250_PORT(_base, _irq) SERIAL8250_PORT_FLAGS(_base, _irq, 0)
 
+extern const struct uart_ops *univ8250_port_base_ops;
 
 static inline int serial_in(struct uart_8250_port *up, int offset)
 {
@@ -301,6 +302,12 @@ static inline int serial8250_pnp_init(void) { return 0; }
 static inline void serial8250_pnp_exit(void) { }
 #endif
 
+#ifdef CONFIG_SERIAL_8250_RSA
+void univ8250_rsa_support(struct uart_ops *ops);
+#else
+static inline void univ8250_rsa_support(struct uart_ops *ops) { }
+#endif
+
 #ifdef CONFIG_SERIAL_8250_FINTEK
 int fintek_8250_probe(struct uart_8250_port *uart);
 #else
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ff15022369e4..51432f89919c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -77,13 +77,6 @@ static const struct old_serial_port old_serial_port[] = {
 
 #define UART_NR	CONFIG_SERIAL_8250_NR_UARTS
 
-#ifdef CONFIG_SERIAL_8250_RSA
-
-#define PORT_RSA_MAX 4
-static unsigned long probe_rsa[PORT_RSA_MAX];
-static unsigned int probe_rsa_count;
-#endif /* CONFIG_SERIAL_8250_RSA  */
-
 struct irq_info {
 	struct			hlist_node node;
 	int			irq;
@@ -348,44 +341,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 		serial_unlink_irq_chain(up);
 }
 
-#ifdef CONFIG_SERIAL_8250_RSA
-static int serial8250_request_rsa_resource(struct uart_8250_port *up)
-{
-	unsigned long start = UART_RSA_BASE << up->port.regshift;
-	unsigned int size = 8 << up->port.regshift;
-	struct uart_port *port = &up->port;
-	int ret = -EINVAL;
-
-	switch (port->iotype) {
-	case UPIO_HUB6:
-	case UPIO_PORT:
-		start += port->iobase;
-		if (request_region(start, size, "serial-rsa"))
-			ret = 0;
-		else
-			ret = -EBUSY;
-		break;
-	}
-
-	return ret;
-}
-
-static void serial8250_release_rsa_resource(struct uart_8250_port *up)
-{
-	unsigned long offset = UART_RSA_BASE << up->port.regshift;
-	unsigned int size = 8 << up->port.regshift;
-	struct uart_port *port = &up->port;
-
-	switch (port->iotype) {
-	case UPIO_HUB6:
-	case UPIO_PORT:
-		release_region(port->iobase + offset, size);
-		break;
-	}
-}
-#endif
-
-static const struct uart_ops *base_ops;
+const struct uart_ops *univ8250_port_base_ops = NULL;
 static struct uart_ops univ8250_port_ops;
 
 static const struct uart_8250_ops univ8250_driver_ops = {
@@ -424,69 +380,6 @@ void serial8250_set_isa_configurator(
 }
 EXPORT_SYMBOL(serial8250_set_isa_configurator);
 
-#ifdef CONFIG_SERIAL_8250_RSA
-
-static void univ8250_config_port(struct uart_port *port, int flags)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	up->probe &= ~UART_PROBE_RSA;
-	if (port->type == PORT_RSA) {
-		if (serial8250_request_rsa_resource(up) == 0)
-			up->probe |= UART_PROBE_RSA;
-	} else if (flags & UART_CONFIG_TYPE) {
-		int i;
-
-		for (i = 0; i < probe_rsa_count; i++) {
-			if (probe_rsa[i] == up->port.iobase) {
-				if (serial8250_request_rsa_resource(up) == 0)
-					up->probe |= UART_PROBE_RSA;
-				break;
-			}
-		}
-	}
-
-	base_ops->config_port(port, flags);
-
-	if (port->type != PORT_RSA && up->probe & UART_PROBE_RSA)
-		serial8250_release_rsa_resource(up);
-}
-
-static int univ8250_request_port(struct uart_port *port)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-	int ret;
-
-	ret = base_ops->request_port(port);
-	if (ret == 0 && port->type == PORT_RSA) {
-		ret = serial8250_request_rsa_resource(up);
-		if (ret < 0)
-			base_ops->release_port(port);
-	}
-
-	return ret;
-}
-
-static void univ8250_release_port(struct uart_port *port)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	if (port->type == PORT_RSA)
-		serial8250_release_rsa_resource(up);
-	base_ops->release_port(port);
-}
-
-static void univ8250_rsa_support(struct uart_ops *ops)
-{
-	ops->config_port  = univ8250_config_port;
-	ops->request_port = univ8250_request_port;
-	ops->release_port = univ8250_release_port;
-}
-
-#else
-#define univ8250_rsa_support(x)		do { } while (0)
-#endif /* CONFIG_SERIAL_8250_RSA */
-
 static inline void serial8250_apply_quirks(struct uart_8250_port *up)
 {
 	up->port.quirks |= skip_txen_test ? UPQ_NO_TXEN_TEST : 0;
@@ -504,8 +397,8 @@ static struct uart_8250_port *serial8250_setup_port(int index)
 	up->port.port_id = index;
 
 	serial8250_init_port(up);
-	if (!base_ops)
-		base_ops = up->port.ops;
+	if (!univ8250_port_base_ops)
+		univ8250_port_base_ops = up->port.ops;
 	up->port.ops = &univ8250_port_ops;
 
 	timer_setup(&up->timer, serial8250_timeout, 0);
@@ -539,7 +432,7 @@ static void __init serial8250_isa_init_ports(void)
 		serial8250_setup_port(i);
 
 	/* chain base port ops to support Remote Supervisor Adapter */
-	univ8250_port_ops = *base_ops;
+	univ8250_port_ops = *univ8250_port_base_ops;
 	univ8250_rsa_support(&univ8250_port_ops);
 
 	if (share_irqs)
@@ -1312,10 +1205,6 @@ MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STR
 module_param(skip_txen_test, uint, 0644);
 MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
 
-#ifdef CONFIG_SERIAL_8250_RSA
-module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
-MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
-#endif
 MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
 
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
@@ -1338,11 +1227,6 @@ static void __used s8250_options(void)
 	module_param_cb(share_irqs, &param_ops_uint, &share_irqs, 0644);
 	module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
 	module_param_cb(skip_txen_test, &param_ops_uint, &skip_txen_test, 0644);
-#ifdef CONFIG_SERIAL_8250_RSA
-	__module_param_call(MODULE_PARAM_PREFIX, probe_rsa,
-		&param_array_ops, .arr = &__param_arr_probe_rsa,
-		0444, -1, 0);
-#endif
 }
 #else
 MODULE_ALIAS("8250_core");
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
new file mode 100644
index 000000000000..dfaa613e452d
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+
+#include "8250.h"
+
+#define PORT_RSA_MAX 4
+static unsigned long probe_rsa[PORT_RSA_MAX];
+static unsigned int probe_rsa_count;
+
+static int rsa8250_request_resource(struct uart_8250_port *up)
+{
+	unsigned long start = UART_RSA_BASE << up->port.regshift;
+	unsigned int size = 8 << up->port.regshift;
+	struct uart_port *port = &up->port;
+	int ret = -EINVAL;
+
+	switch (port->iotype) {
+	case UPIO_HUB6:
+	case UPIO_PORT:
+		start += port->iobase;
+		if (request_region(start, size, "serial-rsa"))
+			ret = 0;
+		else
+			ret = -EBUSY;
+		break;
+	}
+
+	return ret;
+}
+
+static void rsa8250_release_resource(struct uart_8250_port *up)
+{
+	unsigned long offset = UART_RSA_BASE << up->port.regshift;
+	unsigned int size = 8 << up->port.regshift;
+	struct uart_port *port = &up->port;
+
+	switch (port->iotype) {
+	case UPIO_HUB6:
+	case UPIO_PORT:
+		release_region(port->iobase + offset, size);
+		break;
+	}
+}
+
+static void univ8250_config_port(struct uart_port *port, int flags)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int i;
+
+	up->probe &= ~UART_PROBE_RSA;
+	if (port->type == PORT_RSA) {
+		if (rsa8250_request_resource(up) == 0)
+			up->probe |= UART_PROBE_RSA;
+	} else if (flags & UART_CONFIG_TYPE) {
+		for (i = 0; i < probe_rsa_count; i++) {
+			if (probe_rsa[i] == up->port.iobase) {
+				if (rsa8250_request_resource(up) == 0)
+					up->probe |= UART_PROBE_RSA;
+				break;
+			}
+		}
+	}
+
+	univ8250_port_base_ops->config_port(port, flags);
+
+	if (port->type != PORT_RSA && up->probe & UART_PROBE_RSA)
+		rsa8250_release_resource(up);
+}
+
+static int univ8250_request_port(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int ret;
+
+	ret = univ8250_port_base_ops->request_port(port);
+	if (ret == 0 && port->type == PORT_RSA) {
+		ret = rsa8250_request_resource(up);
+		if (ret < 0)
+			univ8250_port_base_ops->release_port(port);
+	}
+
+	return ret;
+}
+
+static void univ8250_release_port(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (port->type == PORT_RSA)
+		rsa8250_release_resource(up);
+	univ8250_port_base_ops->release_port(port);
+}
+
+void univ8250_rsa_support(struct uart_ops *ops)
+{
+	ops->config_port  = univ8250_config_port;
+	ops->request_port = univ8250_request_port;
+	ops->release_port = univ8250_release_port;
+}
+
+module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
+MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
+
+#ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
+#ifndef MODULE
+/*
+ * Keep the old "8250" name working as well for the module options so we don't
+ * break people. We need to keep the names identical and the convenient macros
+ * will happily refuse to let us do that by failing the build with redefinition
+ * errors of global variables.  So we stick them inside a dummy function to
+ * avoid those conflicts.  The options still get parsed, and the redefined
+ * MODULE_PARAM_PREFIX lets us keep the "8250." syntax alive.
+ *
+ * This is hacky. I'm sorry.
+ */
+static void __used rsa8250_options(void)
+{
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "8250_core."
+
+	__module_param_call(MODULE_PARAM_PREFIX, probe_rsa,
+		&param_array_ops, .arr = &__param_arr_probe_rsa,
+		0444, -1, 0);
+}
+#endif
+#endif
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 69ac00270547..96d97184d320 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250-y					:= 8250_core.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
+8250-$(CONFIG_SERIAL_8250_RSA)		+= 8250_rsa.o
 8250_base-y				:= 8250_port.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
-- 
2.43.0.rc1.1336.g36b5255a03ac

