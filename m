Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10721ACE73;
	Thu, 20 Jun 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887597; cv=none; b=stH8jvRiCRQesl4y+cqkv3nR7pGhNGQ0rRDHvkOIadZylnfAPl5J1nPotWPLJpCK8WW2nxTkHoraHicv7vHthPrUbaLy4vyYGPF3UC/gFtBG6+LyIGHTlIZ+085cp+aCkD6luXmsm+OV4pR3ns0BZx2J5qhEq8r2c5bQWRo8iOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887597; c=relaxed/simple;
	bh=wryTky+f8DBKHxvuyF6uPMNEDIH64K2MCv4fOtZirPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBeNgOoeqQNuCiJtdfP0RC8kdTbbiTXra67jVmnyhCMD4H6W/h7KjWmQfem5667k46NEw6SRAaz7bi+GBzkQ68xrMoi0seIz84w2G+aojhnFGx5R4LG1CaMkIx4iPwNOzyguGTUuklrHK/Sf4EOdez8Wi8Keu+sXe2b6q2XVjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1VtS8QX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1VtS8QX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718887596; x=1750423596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wryTky+f8DBKHxvuyF6uPMNEDIH64K2MCv4fOtZirPQ=;
  b=Z1VtS8QXYWaZLzz453LZBsD23xAELVmXoDkSy8sXgNc2LDzbYTIiHud1
   PgqpT8c7DLj4RzFHNAWibOgBA8yyUwZ7q3FamqsnNpZj0kV+Y/EC3dsZk
   FpF/gELnHkQGb7pHMY2PjzBA93YlrrnEbht7SCm4HW0YhMI8iuMBfyoY+
   G3sWNbUQ2kMMo2d0Uoo1w0nqD/cnM0tWpyZqVc/ZCoGET31m6Pi/8FmO9
   UsC/8rhpcQg/ZT96UFaIdS72gKjzLdh4Uiq7GwkWUiRzfefuP5X/grh8e
   w3Aq+bqUw/pGnKBkWvtaA+i5mTMoFd97RZqeAJguNE4re+gPPLqCcA8Rr
   Q==;
X-CSE-ConnectionGUID: ojvtZ+1ASv6X09UrLVYy6A==
X-CSE-MsgGUID: DD9wwq2eQwiQWGMeTWI8+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26985677"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26985677"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:46:36 -0700
X-CSE-ConnectionGUID: Dd1Dq2EbSJmy/Vc4WOIOCg==
X-CSE-MsgGUID: e50AX1CfQQWmnlEOUEaxvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42888747"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO tlindgre-MOBL1.intel.com) ([10.245.247.35])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:46:31 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] serial: core: Revert unusable console quirk handling
Date: Thu, 20 Jun 2024 15:45:28 +0300
Message-ID: <20240620124541.164931-4-tony.lindgren@linux.intel.com>
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

There is no point of trying to handle the console quirks in the serial
core instead of console_setup() currently.

With the console_setup() related changes, we are now deferring the
DEVNAME:0.0 style consoles based on the ":" naming only. So the serial
core console quirk handling would not do anything for the "ttyS" named
consoles as they are not deferred.

Also the earlier approach would have depended on further changes to be
able to drop the serial port quirk handling from console_setup().

Let's revert the following console quirk handling related serial core
commits:

b20172ca6bf4 ("serial: core: Fix ifdef for serial base console functions")
4547cd76f08a ("serial: 8250: Fix add preferred console for serial8250_isa_init_ports()")
a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_init_ports()")
a0f32e2dd998 ("serial: core: Handle serial console options")
787a1cabac01 ("serial: core: Add support for DEVNAME:0.0 style naming for kernel console")

Once the console quirk handling is gone, we add back the DEVNAME:0.0
functionality with a minimal patch.

Suggested-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/linux-serial/ZnGQ8JAu2OQf0GX8@pathway.suse.cz/
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c  |   5 --
 drivers/tty/serial/serial_base.h     |  30 -------
 drivers/tty/serial/serial_base_bus.c | 129 ---------------------------
 drivers/tty/serial/serial_core.c     |   4 -
 4 files changed, 168 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ff15022369e4..b0adafc44747 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
@@ -42,8 +41,6 @@
 
 #include <asm/irq.h>
 
-#include "../serial_base.h"	/* For serial_base_add_isa_preferred_console() */
-
 #include "8250.h"
 
 /*
@@ -563,8 +560,6 @@ static void __init serial8250_isa_init_ports(void)
 		port->irqflags |= irqflag;
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
-
-		serial_base_add_isa_preferred_console(serial8250_reg.dev_name, i);
 	}
 }
 
diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
index 743a72ac34f3..b6c38d2edfd4 100644
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -49,33 +49,3 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
 
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
-
-#ifdef CONFIG_SERIAL_CORE_CONSOLE
-
-int serial_base_add_preferred_console(struct uart_driver *drv,
-				      struct uart_port *port);
-
-#else
-
-static inline
-int serial_base_add_preferred_console(struct uart_driver *drv,
-				      struct uart_port *port)
-{
-	return 0;
-}
-
-#endif
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-
-int serial_base_add_isa_preferred_console(const char *name, int idx);
-
-#else
-
-static inline
-int serial_base_add_isa_preferred_console(const char *name, int idx)
-{
-	return 0;
-}
-
-#endif
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 2cf86f1ff298..4df2a4b10445 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -8,7 +8,6 @@
  * The serial core bus manages the serial core controller instances.
  */
 
-#include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/idr.h>
@@ -205,134 +204,6 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 	put_device(&port_dev->dev);
 }
 
-#ifdef CONFIG_SERIAL_CORE_CONSOLE
-
-static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
-				       int port_id)
-{
-	int ret;
-
-	ret = match_devname_and_update_preferred_console(match, dev_name, port_id);
-	if (ret == -ENOENT)
-		return 0;
-
-	return ret;
-}
-
-#ifdef __sparc__
-
-/* Handle Sparc ttya and ttyb options as done in console_setup() */
-static int serial_base_add_sparc_console(const char *dev_name, int idx)
-{
-	const char *name;
-
-	switch (idx) {
-	case 0:
-		name = "ttya";
-		break;
-	case 1:
-		name = "ttyb";
-		break;
-	default:
-		return 0;
-	}
-
-	return serial_base_add_one_prefcon(name, dev_name, idx);
-}
-
-#else
-
-static inline int serial_base_add_sparc_console(const char *dev_name, int idx)
-{
-	return 0;
-}
-
-#endif
-
-static int serial_base_add_prefcon(const char *name, int idx)
-{
-	const char *char_match __free(kfree) = NULL;
-	const char *nmbr_match __free(kfree) = NULL;
-	int ret;
-
-	/* Handle ttyS specific options */
-	if (strstarts(name, "ttyS")) {
-		/* No name, just a number */
-		nmbr_match = kasprintf(GFP_KERNEL, "%i", idx);
-		if (!nmbr_match)
-			return -ENODEV;
-
-		ret = serial_base_add_one_prefcon(nmbr_match, name, idx);
-		if (ret)
-			return ret;
-
-		/* Sparc ttya and ttyb */
-		ret = serial_base_add_sparc_console(name, idx);
-		if (ret)
-			return ret;
-	}
-
-	/* Handle the traditional character device name style console=ttyS0 */
-	char_match = kasprintf(GFP_KERNEL, "%s%i", name, idx);
-	if (!char_match)
-		return -ENOMEM;
-
-	return serial_base_add_one_prefcon(char_match, name, idx);
-}
-
-/**
- * serial_base_add_preferred_console - Adds a preferred console
- * @drv: Serial port device driver
- * @port: Serial port instance
- *
- * Tries to add a preferred console for a serial port if specified in the
- * kernel command line. Supports both the traditional character device such
- * as console=ttyS0, and a hardware addressing based console=DEVNAME:0.0
- * style name.
- *
- * Translates the kernel command line option using a hardware based addressing
- * console=DEVNAME:0.0 to the serial port character device such as ttyS0.
- * Cannot be called early for ISA ports, depends on struct device.
- *
- * Note that duplicates are ignored by add_preferred_console().
- *
- * Return: 0 on success, negative error code on failure.
- */
-int serial_base_add_preferred_console(struct uart_driver *drv,
-				      struct uart_port *port)
-{
-	const char *port_match __free(kfree) = NULL;
-	int ret;
-
-	ret = serial_base_add_prefcon(drv->dev_name, port->line);
-	if (ret)
-		return ret;
-
-	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
-			       port->ctrl_id, port->port_id);
-	if (!port_match)
-		return -ENOMEM;
-
-	/* Translate a hardware addressing style console=DEVNAME:0.0 */
-	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
-}
-
-#endif
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-
-/*
- * Early ISA ports initialize the console before there is no struct device.
- * This should be only called from serial8250_isa_init_preferred_console(),
- * other callers are likely wrong and should rely on earlycon instead.
- */
-int serial_base_add_isa_preferred_console(const char *name, int idx)
-{
-	return serial_base_add_prefcon(name, idx);
-}
-
-#endif
-
 static int serial_base_init(void)
 {
 	int ret;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0c4d60976663..2a8006e3d687 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3422,10 +3422,6 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	if (ret)
 		goto err_unregister_ctrl_dev;
 
-	ret = serial_base_add_preferred_console(drv, port);
-	if (ret)
-		goto err_unregister_port_dev;
-
 	ret = serial_core_add_one_port(drv, port);
 	if (ret)
 		goto err_unregister_port_dev;
-- 
2.45.2

