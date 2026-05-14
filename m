Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A95425CD7
	for <linux-serial@vger.kernel.org>; Thu, 14 May 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769491; cv=none; b=Kuizp5oyQKFn1IYguuMRJoqedQPYsB/+2x9oDWG/mJcLAGdY6vCcbl4uN83ORNp3ipZBu6DAuAQXUt6ikeUJqqqCMhyOhZSDdosE3SCqt7pDjPIB75afbnU2OUQRWpulgd+k/0rGMA+6MmhH5f24iUxLsuoWESCwSl5kiPIFP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769491; c=relaxed/simple;
	bh=SGen0cAI8+jw73WuKJHAtUiwrOtLJHmirFzTJNCp9XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKUjOeMb8YbForOcUWj+YMtAEMmbMyL+jXImkcJVurtjYEAlTrOmeyl16GJfGw7ddu0Aqv0geOK/20vshJwPDXltlNSd12xGpO3qnpbG74mK4BYbD7LEgmVTvNm+Zcoh7kJmkURw3zU9Ng4/Gw8sx3liB3dC1lK+RHMFuM+hzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK7OB0ku; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK7OB0ku"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8985fe4e6so729394e87.0
        for <linux-serial@vger.kernel.org>; Thu, 14 May 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769486; x=1779374286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4W/+uaY1ucSCdVdyhDwD7Z4d6rSXxFokJhSb7BC4Ng=;
        b=kK7OB0kurzXg1SEyYIr1n5rfo/0IrVAiHsHp5jRbU0loUoWjxJHoyUCSqNexepnBoy
         UFO6FCZQ98vTK5ZvOXTcr0j4SWcmLf+dLmtsWzRsGjHRX7IDb7U2Ocb6xHNS5pcw5Xu1
         D3554HvV6IpZMYjFW2MWxjXEDb41/HPVPKqPBfHfW+v7Ti+ib0wMa4Y8/LLoKrNIO9WX
         1XyLWeTczzdaITU1uTyPiCPwLyVtideA1Qh4AsMFfPZo6CKwagavxEYKjZBFEPej97SD
         CZPzGdTSWfQomf9ZWRdSYUbZCVzbMurZhhclpHHdyOChJzR/eCQeCp4Na9eS2Rzl39xo
         iW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769486; x=1779374286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F4W/+uaY1ucSCdVdyhDwD7Z4d6rSXxFokJhSb7BC4Ng=;
        b=VVz4VyethiaQqFGGoBH121F8OBZODuSXUe+Y4JyG6c6dAron0pYhmia+nj86maW5VI
         Xvqaae6tonjGt4rS4p7GLuAJs87l7BKCjw7GFsXgixSr2ZzwSXk612l2BCLmaMUh0sJb
         6anMRan678R+3+Yyf8T7EW1gE4Wy2FjKcV8RsOb+XcbyauSobVIrEx4qaR57GPPs9GgS
         68nADHvaXhM04TVgKkqjFNKBsPL/ZpaM2LzlC2+V643cUtgXDnPXN/3XZfjetrf87gxr
         lQFetnvAJuaUNqFU1E7MEKT48+/raT1oCDrnua7e0zgF0Gd3g3qTmDIHfXCQrSpjeMgx
         PvRA==
X-Forwarded-Encrypted: i=1; AFNElJ9m12/pYxnK4N7F8eSGlYBLq+0nzKtfcRfHbgg7R+fVwvvwc0Wx5+AS+mG0R9QVBzkCLhGO07SJsUXMtYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kKyuhKr9CPEuNs4qALQVvnLtXrcLB2oMlS1iQoIS2mvCYiWL
	OWECypKZWa5PBvaTiq1UgEaEtWEELHo2/5r6Wk9CtMRKd4kxnED3Euy9
X-Gm-Gg: Acq92OGjjAIjXNDJ0TasnyFhGCYKlUjOdlezeTJq+lKrpCxgGLa2Dxb8v57Gysp1bIb
	mSnpgs2KNf2cBf5A7xFP3nWMX4BCfSXuuqgmhusA7mlAZax1V3+WdF5ny2y6NUhZkev+RXJvXLe
	Mo+OAxbgY9GCdqueeW7a0s+APg7FOH3IdnDqsl2lbdgZaL9eNtUCx8IzyKbVwSxTFPBkxZ5ojaY
	y039AjBTSwE1UCHbkD6CMGBEkQ6g3D2s4lrmHctPEMjesW2MhJ3GnaSsIohcR25tJ7OIkvPsBM6
	lH86mfMFMINp5QRp9TZ25848m4Y1mKK9L15s8Jaakf1TsAnojoYymP5AsUqdpNOQRoZJbNN4Jmx
	rM/H5Zil4wdxcGKRIVNBgiVyw/7UWJXBc50adp5fysNySTuPYb7MTvTIburnhif8ouJwCnkF4AN
	ONjDIsdU6D+t8FOHh3/5z1SXB5FkoORAOthDNE4YuDfQ4tT/r7OwteuggCAA==
X-Received: by 2002:a05:6512:39c2:b0:5a8:847a:dee2 with SMTP id 2adb3069b0e04-5a8ef9a9b90mr1051021e87.3.1778769486083;
        Thu, 14 May 2026 07:38:06 -0700 (PDT)
Received: from localhost.localdomain ([144.124.192.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c578sm518716e87.12.2026.05.14.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:38:05 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH 2/2] serial: 8250_dw: remove clock-notifier infrastructure
Date: Thu, 14 May 2026 19:37:46 +0500
Message-Id: <20260514143746.23671-3-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260514143746.23671-1-sozdayvek@gmail.com>
References: <20260514143746.23671-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock notifier and matching work_struct in dw8250_data were added
in 2020 for the Baikal-T1 SoC, whose multiple UART ports share a
single reference clock and need to be informed when another consumer
re-rates that clock.

Baikal SoC support has since been removed from the kernel (see e.g.
commit 5d6c477687ae ("clk: baikal-t1: Remove not-going-to-be-supported
code for Baikal SoC") and the matching removals across bus/, mtd/,
PCI/, hwmon/, memory/). No remaining in-tree user needs the
cross-device baudclk rate-change notification path: the only
configuration that wired up the notifier was Baikal-T1's shared
reference clock topology.

Drop the now-unused clock-notifier and its deferred-update worker:

  - struct dw8250_data fields clk_notifier and clk_work,
  - the clk_to_dw8250_data() and work_to_dw8250_data() helpers,
  - the dw8250_clk_work_cb() and dw8250_clk_notifier_cb() callbacks,
  - the INIT_WORK / notifier_call setup in dw8250_probe(),
  - the clk_notifier_register() / queue_work() in dw8250_probe(),
  - the matching clk_notifier_unregister() / flush_work() in
    dw8250_remove(),
  - the stale comment in dw8250_set_termios() about the worker
    blocking,
  - the linux/notifier.h and linux/workqueue.h includes that are
    no longer used.

dw8250_set_termios() keeps calling clk_set_rate() directly, which is
all the remaining single-UART configurations require.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 81 -------------------------------
 1 file changed, 81 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7dbd79a91..41c5abccd 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -19,13 +19,11 @@
 #include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
-#include <linux/workqueue.h>
 
 #include <asm/byteorder.h>
 
@@ -86,8 +84,6 @@ struct dw8250_data {
 	u32			msr_mask_off;
 	struct clk		*clk;
 	struct clk		*pclk;
-	struct notifier_block	clk_notifier;
-	struct work_struct	clk_work;
 	struct reset_control	*rst;
 
 	unsigned int		skip_autocfg:1;
@@ -102,16 +98,6 @@ static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
 	return container_of(data, struct dw8250_data, data);
 }
 
-static inline struct dw8250_data *clk_to_dw8250_data(struct notifier_block *nb)
-{
-	return container_of(nb, struct dw8250_data, clk_notifier);
-}
-
-static inline struct dw8250_data *work_to_dw8250_data(struct work_struct *work)
-{
-	return container_of(work, struct dw8250_data, clk_work);
-}
-
 static inline u32 dw8250_modify_msr(struct uart_port *p, unsigned int offset, u32 value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
@@ -484,46 +470,6 @@ static int dw8250_handle_irq(struct uart_port *p)
 	return 1;
 }
 
-static void dw8250_clk_work_cb(struct work_struct *work)
-{
-	struct dw8250_data *d = work_to_dw8250_data(work);
-	struct uart_8250_port *up;
-	unsigned long rate;
-
-	rate = clk_get_rate(d->clk);
-	if (rate <= 0)
-		return;
-
-	up = serial8250_get_port(d->data.line);
-
-	serial8250_update_uartclk(&up->port, rate);
-}
-
-static int dw8250_clk_notifier_cb(struct notifier_block *nb,
-				  unsigned long event, void *data)
-{
-	struct dw8250_data *d = clk_to_dw8250_data(nb);
-
-	/*
-	 * We have no choice but to defer the uartclk update due to two
-	 * deadlocks. First one is caused by a recursive mutex lock which
-	 * happens when clk_set_rate() is called from dw8250_set_termios().
-	 * Second deadlock is more tricky and is caused by an inverted order of
-	 * the clk and tty-port mutexes lock. It happens if clock rate change
-	 * is requested asynchronously while set_termios() is executed between
-	 * tty-port mutex lock and clk_set_rate() function invocation and
-	 * vise-versa. Anyway if we didn't have the reference clock alteration
-	 * in the dw8250_set_termios() method we wouldn't have needed this
-	 * deferred event handling complication.
-	 */
-	if (event == POST_RATE_CHANGE) {
-		queue_work(system_dfl_wq, &d->clk_work);
-		return NOTIFY_OK;
-	}
-
-	return NOTIFY_DONE;
-}
-
 static void
 dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
@@ -547,10 +493,6 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0) {
-		/*
-		 * Note that any clock-notifier worker will block in
-		 * serial8250_update_uartclk() until we are done.
-		 */
 		ret = clk_set_rate(d->clk, newrate);
 		if (!ret)
 			p->uartclk = rate;
@@ -783,9 +725,6 @@ static int dw8250_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->clk),
 				     "failed to get baudclk\n");
 
-	INIT_WORK(&data->clk_work, dw8250_clk_work_cb);
-	data->clk_notifier.notifier_call = dw8250_clk_notifier_cb;
-
 	if (data->clk)
 		p->uartclk = clk_get_rate(data->clk);
 
@@ -843,20 +782,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->data.line < 0)
 		return data->data.line;
 
-	/*
-	 * Some platforms may provide a reference clock shared between several
-	 * devices. In this case any clock state change must be known to the
-	 * UART port at least post factum.
-	 */
-	if (data->clk) {
-		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err) {
-			serial8250_unregister_port(data->data.line);
-			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
-		}
-		queue_work(system_dfl_wq, &data->clk_work);
-	}
-
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_enable(dev);
@@ -871,12 +796,6 @@ static void dw8250_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
-	if (data->clk) {
-		clk_notifier_unregister(data->clk, &data->clk_notifier);
-
-		flush_work(&data->clk_work);
-	}
-
 	serial8250_unregister_port(data->data.line);
 
 	pm_runtime_disable(dev);
-- 
2.43.0

