Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564E156887
	for <linux-serial@vger.kernel.org>; Fri,  4 Oct 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034915; cv=none; b=Tytnn04QZvx4+I+WHbwZKrWDJ8PNeHZpQbNQZJxxz5eO1qUBzq5HkWK5uh3+UyFNzGnm94+c8SVVn1mDLnaUq99xgVDvtsbqTbGmsC9ixWkxAVlUHUIJDADizGEzRkRy6GE/XeRHy7bweR/gqGRhsDxoGmQCC4uMgWXzFHm6Mww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034915; c=relaxed/simple;
	bh=R2oimzn8v8naEjhdUrAAt8wgvfhjJCbG6zjd4lBVPNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6zPlP7SezIRzOgzcPffzWa5Mh9SPmd0+CTnT3w6OfHORPEM/3fDpZGMT6LoJJent8ZBer9ZpJiiHGJEVlO/HGeNBtHDGXxY/zSD3CXJgy/FfBKki8u7Gs8szGIMhm0EbNwCSFQNE2guUhvWZIskh9oksQTMfPiQ9ygWUSvCxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYoNNeUe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYoNNeUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034914; x=1759570914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2oimzn8v8naEjhdUrAAt8wgvfhjJCbG6zjd4lBVPNE=;
  b=MYoNNeUeVn7NOYTBlzsLC/C3gT17tpejl+W6Mr74n7hGVPHYLBcX09i3
   7x+bhqHmXwVvFMDPf/80yLfc6B4T+iHmyMTcKoMkvFaAMU+SCbs6a1rLb
   +taABZJby1L16WRiKc1NV8H2J8HiZtsmB3+H1OtkXVCr5dq0zMzIX3NBg
   /lbeqrnCC9Sh4xvuw2R0X9t8nO6IBB3hGzES55DOh1y3Sm42HIJ2iqVU8
   gTneHE1S3SzmpV4vFHMtpVsp06MbygXAgEKFxyVMaXCtkTnzQWovrVnfw
   qRy+Msf+gHjNEGSKiwfptZpHcX8qtqgCeyQ16N8xGerqI61+5x4YqwhBi
   Q==;
X-CSE-ConnectionGUID: 6MDn88jQR1u/Xx/RpiIDOA==
X-CSE-MsgGUID: aL7E8SxPTrqe0NZZPKjeEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27136216"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27136216"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:52 -0700
X-CSE-ConnectionGUID: JbD/tz6nSb6QUdqg0GjzDQ==
X-CSE-MsgGUID: DL5cKpxwRsCJHBWfPMT7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="105492090"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:50 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 3144A120D8D;
	Fri,  4 Oct 2024 12:41:45 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoj-000TgX-0b;
	Fri, 04 Oct 2024 12:41:45 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-serial@vger.kernel.org
Subject: [PATCH 44/51] serial: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:45 +0300
Message-Id: <20241004094145.114099-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 +++++++++---------
 drivers/tty/serial/8250/8250_port.c |  4 ++--
 drivers/tty/serial/fsl_lpuart.c     |  2 +-
 drivers/tty/serial/serial_core.c    |  2 +-
 drivers/tty/serial/uartlite.c       |  4 ++--
 drivers/tty/serial/xilinx_uartps.c  |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 88b58f44e4e9..8bd8284e591e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -208,7 +208,7 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	__omap8250_set_mctrl(port, mctrl);
 
 	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	__pm_runtime_put_autosuspend(port->dev);
 }
 
 /*
@@ -510,7 +510,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 
 	uart_port_unlock_irq(&up->port);
 	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	__pm_runtime_put_autosuspend(port->dev);
 
 	/* calculate wakeup latency constraint */
 	priv->calc_latency = USEC_PER_SEC * 64 * 8 / baud;
@@ -548,7 +548,7 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 	uart_port_unlock_irq(port);
 
 	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	__pm_runtime_put_autosuspend(port->dev);
 }
 
 static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
@@ -767,7 +767,7 @@ static int omap_8250_startup(struct uart_port *port)
 	enable_irq(up->port.irq);
 
 	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	__pm_runtime_put_autosuspend(port->dev);
 	return 0;
 }
 
@@ -805,7 +805,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 
 	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	__pm_runtime_put_autosuspend(port->dev);
 }
 
 static void omap_8250_throttle(struct uart_port *port)
@@ -821,7 +821,7 @@ static void omap_8250_throttle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 
 	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	__pm_runtime_put_autosuspend(port->dev);
 }
 
 static void omap_8250_unthrottle(struct uart_port *port)
@@ -843,7 +843,7 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 
 	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	__pm_runtime_put_autosuspend(port->dev);
 }
 
 static int omap8250_rs485_config(struct uart_port *port,
@@ -1594,7 +1594,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 	priv->line = ret;
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
 err:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
@@ -1682,7 +1682,7 @@ static int omap8250_resume(struct device *dev)
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3509af7dc52b..a94f30fac856 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -510,7 +510,7 @@ void serial8250_rpm_put(struct uart_8250_port *p)
 	if (!(p->capabilities & UART_CAP_RPM))
 		return;
 	pm_runtime_mark_last_busy(p->port.dev);
-	pm_runtime_put_autosuspend(p->port.dev);
+	__pm_runtime_put_autosuspend(p->port.dev);
 }
 EXPORT_SYMBOL_GPL(serial8250_rpm_put);
 
@@ -654,7 +654,7 @@ void serial8250_rpm_put_tx(struct uart_8250_port *p)
 	if (!rpm_active)
 		return;
 	pm_runtime_mark_last_busy(p->port.dev);
-	pm_runtime_put_autosuspend(p->port.dev);
+	__pm_runtime_put_autosuspend(p->port.dev);
 }
 EXPORT_SYMBOL_GPL(serial8250_rpm_put_tx);
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 77efa7ee6eda..5bf0d6d6f417 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -825,7 +825,7 @@ lpuart_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate
 	switch (state) {
 	case UART_PM_STATE_OFF:
 		pm_runtime_mark_last_busy(port->dev);
-		pm_runtime_put_autosuspend(port->dev);
+		__pm_runtime_put_autosuspend(port->dev);
 		break;
 	default:
 		pm_runtime_get_sync(port->dev);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d94d73e45fb6..906254bed9fa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -159,7 +159,7 @@ static void __uart_start(struct uart_state *state)
 	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
-	pm_runtime_put_autosuspend(&port_dev->dev);
+	__pm_runtime_put_autosuspend(&port_dev->dev);
 }
 
 static void uart_start(struct tty_struct *tty)
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 68357ac8ffe3..a7ecdcbce6d3 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -423,7 +423,7 @@ static void ulite_pm(struct uart_port *port, unsigned int state,
 			dev_err(port->dev, "Failed to enable clocks\n");
 	} else {
 		pm_runtime_mark_last_busy(port->dev);
-		pm_runtime_put_autosuspend(port->dev);
+		__pm_runtime_put_autosuspend(port->dev);
 	}
 }
 
@@ -893,7 +893,7 @@ static int ulite_probe(struct platform_device *pdev)
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
 }
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 777392914819..a06afaa314d3 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1241,7 +1241,7 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 	switch (state) {
 	case UART_PM_STATE_OFF:
 		pm_runtime_mark_last_busy(port->dev);
-		pm_runtime_put_autosuspend(port->dev);
+		__pm_runtime_put_autosuspend(port->dev);
 		break;
 	default:
 		pm_runtime_get_sync(port->dev);
-- 
2.39.5

