Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99663386C25
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617940; cv=none; b=DyV+0ok6ka00igzXIzxct5BeJkF/xoVIjmJh5JwPtKj4DuMTUk+UJO+YnvRSexthM6WKKIZkDxPvkBdpnQZRMGyiwRCaca7fnDyHciOOd4ZA5vy+HZDRmsN1IuF9pF1QEEWyWBB18yykhAsRT6WVkpq0hErb/0oh9Ui/g/mbkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617940; c=relaxed/simple;
	bh=JTbnAtARgUQ4AFZJU9OHPxz7uBUe6OrzJYGrchxPvP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDWjj6Z66UeNJBvmMnfVefrnxmjWZ5xOt8wny5WLM794rlAoAFEZuXVdVzkSbY7Aw9WG4BSodMmC0UWOUNKvLh1SQgSce7GUb1IMGs/uTe95WaYv+hjt0Ntjovn9QvkVMATIT1NKHZbmIhvuUSdPR0zRkMXGXwt7zEKgsjnTYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBYTwpVt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBYTwpVt"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f6so2766595ad.0
        for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 21:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789617934; x=1790222734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtX/Qf6NK/20sK/bOaui84KkOiA6Sp6G7U7L/FiPWA0=;
        b=jBYTwpVt5Gk2BmxBp86oAxG+yLbCOEbJDABiddOhM+yxobsuSaDzazf90TaAZQWTFi
         tloJBuKMNcTgaEiJdxU1TVuUt+q7DQFO9WINLUbYK5yOFWZW0CzRrSYvXhIT+ah9pt+y
         NMabFUABPCyvQrdIb8nqNQ12pCiOO5rlQbazjaOu9ATKx/zYPKJQmySpk8K3K+ZQ3sfW
         2WsckDRlnckbFxcJ18lk0qGo6EI0ajJ26JKaMY7EiWJvEAqpUy8DoNOJtPjoHH+JssvW
         HULUbOBgAfFwkY2HweNg8ZXCh9eK1JljaNyxpw78uWfJl05zN0rigQROlPHqb6DvLaiC
         NKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789617934; x=1790222734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtX/Qf6NK/20sK/bOaui84KkOiA6Sp6G7U7L/FiPWA0=;
        b=IE5OE8wasQoI5ksAwyoLX9J11MD+KQ3C6TjLdBoODfSpxMU60iieNdIfAIDhwKq+FH
         1Bpq/CPajJoFa73eNTnPLqbD+DSDoRDJfdOvpTp2uj8OZCMEpdr2Mc8/3TAoAPgh6v3H
         IbSM5H0unc68CQUgE+0xN4896dY37sJi2bPiuAp7oTPP8hWsN//sekTgvkQWLr9+ppw+
         N7lKS8utC6IqdMdmEh3r6aicP4XsWHwpbMCpq8QqSySgsxEDCn/ZPj3Le9XrkqbXICFc
         fRESJSV63HFN4nuaCe0c6DaF2SfuWvbCSZGMXcQetvLs7zswBTslCKEInD72F36vKl1z
         GCag==
X-Forwarded-Encrypted: i=1; AKwUvBzPZVoynyEX/pYN/IhP1Yv4ht84DCXlSjzm8BlYzZHs0M0F9g3dtf9cMy45z/eZ/tsEvGXR+4J/2mUxXMU=@vger.kernel.org
X-Gm-Message-State: AFuF++nCvYij+HsgegG9SdwSr2pmtsH6IWsy02LsUL2kLIYX7ainAlkN
	GVuEsCc4ZfC2/JrNEibeUg58rXyggPLODKzqL3D5XirLs+K5jG+V62zg
X-Gm-Gg: AYBFou2t308/W97NEFeZCsLERWPnWZeR119OjpyrdGUBV595awAuJFFXsX2OJiNOex3
	mXYIHBEbt6sOJmeHbmYWnBmooEQDD+qtogx96SxmtgnUz0fglxYGACdlwiPPE14yd7jEaBmDvv1
	OUWaj0eP8A202VdLxz+KGrMt/Vr02yzQUgoMpczbQAupfGSiqhyP/HzsWLBeVHEluMeb3CZxcwb
	xFwmnMDOJJ2QtovRG7QeqzcRJ5iueTQ+JNbdtp9eEiVhkBqXOksNLYVMJsDh5b05T411NQz/sJr
	RtNrk4OPMwi4U1mfwgOl3CyVhtoXMyDxJnhKronrSczksmAm3/KRv+6rmQJMt9ix+h6DQhIOQY+
	rP8W7VgeD7Zh1HX4Yyjs5QzJ0OTZOc1rL9RtraIXQQNdF3uuCR3aYoKBAn2qCQeO1/gR3x0Vym0
	b1rlj6LJqXVGQjtP9SsBPjCFMTuYH7xjyQKMCdR56s7NZGoTE0tBQM+RRYVHq8jny4yitmwKzFX
	wqFNcMSA77EW9du1aANZzR1+mw+ctqMihto6Q==
X-Received: by 2002:a17:90b:4a51:b0:39d:ee20:1e28 with SMTP id 98e67ed59e1d1-39e1e510f73mr14802785a91.21.1789617934135;
        Wed, 16 Sep 2026 21:05:34 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cacce6sm10195833c88.1.2026.09.16.21.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 21:05:33 -0700 (PDT)
From: Malathi A <malathi.a2000@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Malathi A <malathi.a2000@gmail.com>
Subject: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
Date: Thu, 17 Sep 2026 04:05:09 +0000
Message-ID: <20260917040511.103232-1-malathi.a2000@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uniphier_uart_probe() enables priv->clk by hand and is then responsible
for disabling it again on every error path. It misses one: when
uart_read_port_properties() fails the function returns directly, leaving
the clock prepared and enabled. The neighbouring path, taken when
serial8250_register_8250_port() fails, does call clk_disable_unprepare(),
which shows the leak is an oversight rather than intent.

Rather than adding another manual unwind, switch to
devm_clk_get_enabled() so the clock is released by devres. That removes
the error path entirely, along with the explicit disables in the
register failure path and in uniphier_uart_remove().

The clock is still disabled and re-enabled by hand across system sleep,
which stays balanced: only SET_SYSTEM_SLEEP_PM_OPS is used, so the
device cannot be unbound while suspended and devres always sees an
enabled clock at detach.

Found by smatch:

  drivers/tty/serial/8250/8250_uniphier.c:232 uniphier_uart_probe() warn: 'priv->clk' from clk_prepare_enable() not released on lines: 205.

Fixes: 26e8349c0d76 ("serial: 8250_uniphier: Switch to use uart_read_port_properties()")
Signed-off-by: Malathi A <malathi.a2000@gmail.com>
---
Changes in v2:
- Use devm_clk_get_enabled() instead of adding a clk_disable_unprepare()
  to the failing path, as suggested in review. This also lets the
  explicit disables in the serial8250_register_8250_port() error path and
  in uniphier_uart_remove() go away.
- Reworded the commit message accordingly.

 drivers/tty/serial/8250/8250_uniphier.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index e3db60bf50c9..6fffac12277a 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -180,16 +180,12 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	memset(&up, 0, sizeof(up));
 
-	priv->clk = devm_clk_get(dev, NULL);
+	priv->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to get clock\n");
+		dev_err(dev, "failed to get and enable clock\n");
 		return PTR_ERR(priv->clk);
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
-
 	up.port.uartclk = clk_get_rate(priv->clk);
 
 	spin_lock_init(&priv->atomic_write_lock);
@@ -222,7 +218,6 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(dev, "failed to register 8250 port\n");
-		clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 	priv->line = ret;
@@ -237,7 +232,6 @@ static void uniphier_uart_remove(struct platform_device *pdev)
 	struct uniphier8250_priv *priv = platform_get_drvdata(pdev);
 
 	serial8250_unregister_port(priv->line);
-	clk_disable_unprepare(priv->clk);
 }
 
 static int __maybe_unused uniphier_uart_suspend(struct device *dev)
-- 
2.43.0

