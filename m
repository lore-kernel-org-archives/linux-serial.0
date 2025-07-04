Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE842F7D0E;
	Fri,  4 Jul 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615715; cv=none; b=NuVF2B5VTDUeoUO/uVV3hRSFkE7ULxvT4CzPcPfWc0nvjUXYC6zncQFO0kXzdcCc+UpG5s0QTfRiIRvhIZZVyELTu4nQYP+y6qwKePmvAFTsUEj8e3LbncXLpJqpp8+ADg88k6dqbUNHZd7XnRvRfk69Dovxlfn/dB0eehQ9448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615715; c=relaxed/simple;
	bh=lzOBZYTBavsi2Z34vHlXoBrBjY0eNs9he5kt9Nk32kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdKJDKacAq09zqbByO9BcmpJ3fz9CApaOu44WxeNsVxxsVQ3pXt4GQhY85YJnElNKSJoqQL+LXG38tOfH2XDZCkIPdlo1yM0EuuDJo5ELuFVYNQKf0HWJdjNNK0L3DVVjHjaifNAuS0WJfPsK9jVOXS/N4IGn/Su87HIbTeA9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJ6NX9OS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJ6NX9OS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615713; x=1783151713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lzOBZYTBavsi2Z34vHlXoBrBjY0eNs9he5kt9Nk32kM=;
  b=NJ6NX9OSqK2yH49TGJ1/yVF+qy9VHM1ambFydZS4yn9Bd3bZbiKYVwRH
   DtatMdEV2epfEOmnZpNEBBgjG3+4FJJZ4nxHyVb8OX9gxKuL0RXAd2Fdf
   FdsWICNO2YZaZadK03b+oXEC7LTtqOZyUgLYdFwGY+Mu1oShnagil8qYe
   5U7dANefCWdvcduNUdv8BftpBtm0ZUhpzvwnUU/BlX+dRz62eoMuhxvlp
   CnerzDfDIQOfDV1byNO828Hs0iyzMo6TlZrsYqvPYsVQh7123/PDT4djy
   ZSik0Ijspc8Nad+6Hngl5mBEHNTN2c4pC6Nqv8dICEK5As+7FrnN1lChf
   A==;
X-CSE-ConnectionGUID: yASibvyJRiytjWs64v0WHw==
X-CSE-MsgGUID: oqHXpyHFQ8SRzHEhKU2g8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194328"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194328"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:55:03 -0700
X-CSE-ConnectionGUID: DyR3FIjPRPqQIAzc1rL3Jw==
X-CSE-MsgGUID: qJCH8EhASNmI9Sen5dGyBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616672"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:55 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id CFDC8447EB;
	Fri,  4 Jul 2025 10:54:52 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Michal Simek <michal.simek@amd.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Petr Mladek <pmladek@suse.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sean Anderson <sean.anderson@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 66/80] serial: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:52 +0300
Message-Id: <20250704075452.3222201-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/tty/serial/8250/8250_omap.c | 9 ---------
 drivers/tty/serial/8250/8250_port.c | 2 --
 drivers/tty/serial/fsl_lpuart.c     | 1 -
 drivers/tty/serial/serial_core.c    | 1 -
 drivers/tty/serial/uartlite.c       | 2 --
 drivers/tty/serial/xilinx_uartps.c  | 1 -
 6 files changed, 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6707f55bdbe7..091afea71b95 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -207,7 +207,6 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	__omap8250_set_mctrl(port, mctrl);
 
-	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 }
 
@@ -516,7 +515,6 @@ static void omap_8250_set_termios(struct uart_port *port,
 	omap8250_restore_regs(up);
 
 	uart_port_unlock_irq(&up->port);
-	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 
 	/* calculate wakeup latency constraint */
@@ -554,7 +552,6 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 
 	uart_port_unlock_irq(port);
 
-	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 }
 
@@ -773,7 +770,6 @@ static int omap_8250_startup(struct uart_port *port)
 
 	enable_irq(port->irq);
 
-	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 	return 0;
 }
@@ -811,7 +807,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
 	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 
-	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 }
 
@@ -827,7 +822,6 @@ static void omap_8250_throttle(struct uart_port *port)
 	priv->throttled = true;
 	uart_port_unlock_irqrestore(port, flags);
 
-	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 }
 
@@ -848,7 +842,6 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 	uart_port_unlock_irqrestore(port, flags);
 
-	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 }
 
@@ -1594,7 +1587,6 @@ static int omap8250_probe(struct platform_device *pdev)
 		goto err;
 	}
 	priv->line = ret;
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
 err:
@@ -1682,7 +1674,6 @@ static int omap8250_resume(struct device *dev)
 
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7eddcab318b4..22ad70117c44 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -519,7 +519,6 @@ static void serial8250_rpm_put(struct uart_8250_port *p)
 {
 	if (!(p->capabilities & UART_CAP_RPM))
 		return;
-	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
 
@@ -659,7 +658,6 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
 	rpm_active = xchg(&p->rpm_tx_active, 0);
 	if (!rpm_active)
 		return;
-	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c9519e649e82..79050a42cd1b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -825,7 +825,6 @@ lpuart_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate
 {
 	switch (state) {
 	case UART_PM_STATE_OFF:
-		pm_runtime_mark_last_busy(port->dev);
 		pm_runtime_put_autosuspend(port->dev);
 		break;
 	default:
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 86d404d649a3..f9fc9afcd845 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -159,7 +159,6 @@ static void __uart_start(struct uart_state *state)
 	 */
 	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
 		port->ops->start_tx(port);
-	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
 }
 
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 39c1fd1ff9ce..c21cd5f5be27 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -422,7 +422,6 @@ static void ulite_pm(struct uart_port *port, unsigned int state,
 		if (ret < 0)
 			dev_err(port->dev, "Failed to enable clocks\n");
 	} else {
-		pm_runtime_mark_last_busy(port->dev);
 		pm_runtime_put_autosuspend(port->dev);
 	}
 }
@@ -882,7 +881,6 @@ static int ulite_probe(struct platform_device *pdev)
 
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fe457bf1e15b..36afa2a8f158 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1240,7 +1240,6 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 {
 	switch (state) {
 	case UART_PM_STATE_OFF:
-		pm_runtime_mark_last_busy(port->dev);
 		pm_runtime_put_autosuspend(port->dev);
 		break;
 	default:
-- 
2.39.5

