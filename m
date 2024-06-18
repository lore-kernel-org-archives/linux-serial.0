Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B433987;
	Tue, 18 Jun 2024 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718686544; cv=none; b=qsr9m7GWu9m9XUrh0/lqvfRcOtWyCXc7vBe3SqONzlRUs7CRLzL97qdhH1SyZILESy266Osh+CO95afUxTik9DIHHZI9hrQccxAdWspzF5p+KBGKsAdHE2EJB9mS+ONfoPqHFCjpKIYOUaD4SYuk4I8pEMYKeNx/CSLRQ4Yx/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718686544; c=relaxed/simple;
	bh=o6ukNG1uFMlN+wMsdfJhh/d4ANa/v4iREsteg6C/Kn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iViIZInV45xiNWwCFmHIPfJlmTNt+gBFa/IoL6Rn0B3+m/nmYbMZF2UmBsJUxXbW6JcEl/jBTk2xv5k7sJTsU7PtZAEmIJntyeDbq9r8qr6bwwBjMoiMXUR9FQjpInwsRaDrAWieiLSj1YJitjVr5V9fcsw2MSovvQ4T0/Ouboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAz28KRA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAz28KRA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718686543; x=1750222543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6ukNG1uFMlN+wMsdfJhh/d4ANa/v4iREsteg6C/Kn4=;
  b=AAz28KRAYLXEF7e16h8eoR8IJbGJXyjDp2Jwm2kHq+MCOxhHtHrRyi+u
   QcfySXj8SjWPmdGFS7Qqfjoy0ca3ZO+5buyjcUb8HikxF0LoWhSlFlxUJ
   pv4hrIO3V5W/Mpz4Af0+PVBim6CWElrhby5qE335AJ1ubio/lSD3Calzi
   qPPEA1hdfTNkHvA6KMOD5Nz+mBaMVx9XTt/MQvcZDB3Mv3bEIFEC2F1tJ
   LsG7vTDvhUXdjh2lHQPQR4RPn/uCIzYaEhlel27/NzY3BGbuDjRZiPGrw
   +rukUoIG3HzHSkyElHRuWWOXv6XV3RJrAlGJR8B0TDbIMVYwoZTwuaNH+
   g==;
X-CSE-ConnectionGUID: uVKlq61VTxOxHBgoYdSnQA==
X-CSE-MsgGUID: +2eCEEfbT2CqpMDuy9Pt/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="38062814"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="38062814"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:55:43 -0700
X-CSE-ConnectionGUID: cGjUpZAVTlOGqT9EhAt4MA==
X-CSE-MsgGUID: x5pOJKYJTHq3YjdhNcNAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41507407"
Received: from unknown (HELO tlindgre-MOBL1.intel.com) ([10.245.247.4])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:55:38 -0700
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
Subject: [PATCH v3 3/3] serial: core: Rename preferred console handling for match and update
Date: Tue, 18 Jun 2024 07:54:50 +0300
Message-ID: <20240618045458.14731-4-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are now matching and updating the preferred console, not adding it.
Let's update the naming accordingly to avoid confusion.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c  |  4 ++--
 drivers/tty/serial/serial_base.h     |  4 ++--
 drivers/tty/serial/serial_base_bus.c | 21 +++++++++++----------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ff15022369e4..3556fe42ec65 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -42,7 +42,7 @@
 
 #include <asm/irq.h>
 
-#include "../serial_base.h"	/* For serial_base_add_isa_preferred_console() */
+#include "../serial_base.h"	/* For serial_base_match_and_update_isa_preferred_console() */
 
 #include "8250.h"
 
@@ -564,7 +564,7 @@ static void __init serial8250_isa_init_ports(void)
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
 
-		serial_base_add_isa_preferred_console(serial8250_reg.dev_name, i);
+		serial_base_match_and_update_isa_preferred_console(serial8250_reg.dev_name, i);
 	}
 }
 
diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
index 743a72ac34f3..a5632eeda250 100644
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -68,12 +68,12 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
-int serial_base_add_isa_preferred_console(const char *name, int idx);
+int serial_base_match_and_update_isa_preferred_console(const char *name, int idx);
 
 #else
 
 static inline
-int serial_base_add_isa_preferred_console(const char *name, int idx)
+int serial_base_match_and_update_isa_preferred_console(const char *name, int idx)
 {
 	return 0;
 }
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 2cf86f1ff298..391d41ef5942 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -207,8 +207,9 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 
-static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
-				       int port_id)
+static int serial_base_match_and_update_one_prefcon(const char *match,
+						    const char *dev_name,
+						    int port_id)
 {
 	int ret;
 
@@ -237,7 +238,7 @@ static int serial_base_add_sparc_console(const char *dev_name, int idx)
 		return 0;
 	}
 
-	return serial_base_add_one_prefcon(name, dev_name, idx);
+	return serial_base_match_and_update_one_prefcon(name, dev_name, idx);
 }
 
 #else
@@ -249,7 +250,7 @@ static inline int serial_base_add_sparc_console(const char *dev_name, int idx)
 
 #endif
 
-static int serial_base_add_prefcon(const char *name, int idx)
+static int serial_base_match_and_update_prefcon(const char *name, int idx)
 {
 	const char *char_match __free(kfree) = NULL;
 	const char *nmbr_match __free(kfree) = NULL;
@@ -262,7 +263,7 @@ static int serial_base_add_prefcon(const char *name, int idx)
 		if (!nmbr_match)
 			return -ENODEV;
 
-		ret = serial_base_add_one_prefcon(nmbr_match, name, idx);
+		ret = serial_base_match_and_update_one_prefcon(nmbr_match, name, idx);
 		if (ret)
 			return ret;
 
@@ -277,7 +278,7 @@ static int serial_base_add_prefcon(const char *name, int idx)
 	if (!char_match)
 		return -ENOMEM;
 
-	return serial_base_add_one_prefcon(char_match, name, idx);
+	return serial_base_match_and_update_one_prefcon(char_match, name, idx);
 }
 
 /**
@@ -304,7 +305,7 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 	const char *port_match __free(kfree) = NULL;
 	int ret;
 
-	ret = serial_base_add_prefcon(drv->dev_name, port->line);
+	ret = serial_base_match_and_update_prefcon(drv->dev_name, port->line);
 	if (ret)
 		return ret;
 
@@ -314,7 +315,7 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 		return -ENOMEM;
 
 	/* Translate a hardware addressing style console=DEVNAME:0.0 */
-	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
+	return serial_base_match_and_update_one_prefcon(port_match, drv->dev_name, port->line);
 }
 
 #endif
@@ -326,9 +327,9 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
  * This should be only called from serial8250_isa_init_preferred_console(),
  * other callers are likely wrong and should rely on earlycon instead.
  */
-int serial_base_add_isa_preferred_console(const char *name, int idx)
+int serial_base_match_and_update_isa_preferred_console(const char *name, int idx)
 {
-	return serial_base_add_prefcon(name, idx);
+	return serial_base_match_and_update_prefcon(name, idx);
 }
 
 #endif
-- 
2.45.2

