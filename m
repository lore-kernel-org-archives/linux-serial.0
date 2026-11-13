Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566341;
	b=wo6ziEMUbML/fY0pltd+QJeK18+pmAwhfEIDh+8VL1mt41MOAcDuxvnzB1j/E7OWSlNR
	 lMbY1w62TV9SjEqBpaR3mST/YvUKk+XETqpskZG9ZaTa9/yoGum/bhr/yznn8nhTpHai0
	 W4FnXzWRyI76WOcNRx9a+aB00XmMpAAPozhAYU6RlZ5G4O1W7vVbtOMyLphX9n68usGSz
	 eLalFp/nohhvRBMmUNytrwMwjPdpEsCcNMgaN8psvJJwOisbGIPOOp0QJBRM/fCnlnbZL
	 KKs2askJNrS7TbB2Y/46fUETW+z8XcXWOo8i5WHWQpgjsK398+QfpuHt7U3cUJJd6Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566341;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IPwZLeIkrltBjCvmAMLvA4gMkS7NWXVa2+Tprq7mcis=;
	b=dc4pzC4hX7GBkBk6f/yalXqDhbsoFHCUzxU2ironXfaBM5eph2V28WTChH6pJK00qsma
	 sSd13cZ2oeU6LgIWnF3sHGiP4eSH9NQyWJqa0iVBrMv96EEuX4ZNN0tVW1h1RZZNPWpnj
	 /OvpWtcd56GCQBStuK/rH8x7He6FQ36WwB72LYd9mNutN53irImcxknWJQiuPcB2EEdPz
	 0jPQevUKF3f8uf2gutR/ixfoJE0HeEoxLRfn6tM5Ib7dtD1J5tNqSETFrJSuSEhy8tKth
	 8ASNbpDdWI2kPiMZkka+e3A9ZVhEpD9dIP5KtaYafMfr+lq8RbkV/Nd/aidCFGWT/yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PXCJlt9n;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B3606A31C;
	Fri, 13 Nov 2026 10:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PXCJlt9n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PXCJlt9nMZ8tHD5aiuEJI5NWSUk5ByazpLr7Wh47kiSJeicuZJH4uhlr8W4uA5ZyfYx6+49SwaPmV
	 It6jhK4w0yscroaDniysiSkM3v8YjfvLczIb6pno2JSCXvLgflzJXcnNY64VwPFM9oABPu0YeSIT+q
	 yZ63PtjWmEkVF660=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af6e8b73f8-c79f4;
	Fri, 13 Nov 2026 18:38:56 +0800 (CST)
X-RM-TRANSID:2ee16af6e8b73f8-c79f4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af6e8beb6e-22467;
	Fri, 13 Nov 2026 18:38:56 +0800 (CST)
X-RM-TRANSID:2ee86af6e8beb6e-22467
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hugo@hugovil.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock frequency
Date: Fri, 13 Nov 2026 18:38:54 +0800
Message-ID: <20261113103855.2144-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sc16is7xx_probe() enables the clock with clk_prepare_enable() early
in the probe path.  If the resulting clock frequency cannot be
determined (neither from the clock itself, nor from the
"clock-frequency" property or platform data), the driver bails out
with -EINVAL, but it does so with a plain return, leaving the clock
prepared and enabled.

Switch to devm_clk_get_optional_enabled(), which drops the clock
reference and disables the clock automatically when the probe fails
and when the device is removed.  The manual clock management is no
longer needed: drop clk_prepare_enable(), the out_clk label and the
clk_disable_unprepare() call in sc16is7xx_remove().

Fixes: cb1b206cff46 ("serial: sc16is7xx: Use devm_clk_get_optional()")
Suggested-by: Hugo Villeneuve <hugo@hugovil.com>
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
Changes in v2:

- Rework the patch following Hugo Villeneuve's suggestion: switch to
  devm_clk_get_optional_enabled() so the clock is disabled
  automatically on probe failure and on remove, and remove the now
  unneeded manual clock management (clk_prepare_enable(), the
  out_clk label and the clk_disable_unprepare() call in
  sc16is7xx_remove()).  The -EINVAL path keeps its original plain
  return since devm handles the cleanup.

Link: https://lore.kernel.org/all/20261030085508.1882-1-laixiangwu@cmss.chinamobile.com
 drivers/tty/serial/sc16is7xx.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index fba588559..a69b71fb8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1605,14 +1605,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		dev_dbg(dev,
 			"No interrupt pin definition, falling back to polling mode\n");
 
-	s->clk = devm_clk_get_optional(dev, NULL);
+	s->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
 
-	ret = clk_prepare_enable(s->clk);
-	if (ret)
-		return ret;
-
 	freq = clk_get_rate(s->clk);
 	if (freq == 0) {
 		if (uartclk)
@@ -1631,10 +1627,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	kthread_init_worker(&s->kworker);
 	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
 				      "sc16is7xx");
-	if (IS_ERR(s->kworker_task)) {
-		ret = PTR_ERR(s->kworker_task);
-		goto out_clk;
-	}
+	if (IS_ERR(s->kworker_task))
+		return PTR_ERR(s->kworker_task);
+
 	sched_set_fifo(s->kworker_task);
 
 	ret = sc16is7xx_reset(dev, regmaps[0]);
@@ -1711,9 +1706,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 out_kthread:
 	kthread_stop(s->kworker_task);
 
-out_clk:
-	clk_disable_unprepare(s->clk);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sc16is7xx_probe);
@@ -1740,8 +1732,6 @@ void sc16is7xx_remove(struct device *dev)
 
 	kthread_flush_worker(&s->kworker);
 	kthread_stop(s->kworker_task);
-
-	clk_disable_unprepare(s->clk);
 }
 EXPORT_SYMBOL_GPL(sc16is7xx_remove);
 
-- 
2.50.1.windows.1



