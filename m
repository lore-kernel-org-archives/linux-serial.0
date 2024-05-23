Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9B12881E
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506566; cv=none; b=N350ygHoNauCSfbAfCN4urBk+aALdGdaGoWg1OxCqFOWm+HhVoBlKyqdJOS96LM/Z4m7kWX4jlCCuMscDdpe43oLWcc55bCUABj+sAjJmKs7ibrf66tpH9y4kHj6DgploLbW6OJdKR8a/Zv2zcMyU4/0adNgNkWecuwh+bromN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506566; c=relaxed/simple;
	bh=kkkhBwgehEF7n1T23cL1CwSfbc9VolDpTC3FStnSsd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkigWDVHdR1HxPYmUvtr/MRcOwKJkX0RlI87MZjtWZUYG4eJmu5x6Stzw8qqVO1L25wXZs5v3Dked91BMEaP7sqdTvHuk7eSrfu+NXReWecFpQtc2RyiVMppPu6cE2x8uxNsYJjxtkrD8MCndlpPe7l/JK0PzERR8LMQWr97Ubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JX8RbgWd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JX8RbgWd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f44b4fcc3dso1985605ad.1
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716506563; x=1717111363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7fuT9Y1ix7BMb1d7jsMKipipzI5RerSwpQeO523sQw=;
        b=JX8RbgWdxgUBdtuKPPGK+oZTV6ybfM+6/iCINoVkpbj2AB7vEJLyrcpyttl/WMizyq
         HSnObBpNoFvOWinAynCsp9X4sIa75bhO8WDa3TjpR9oDiuzQsQe8PZnTmSRcitX+ouAN
         D6F12LawjqfHddl07AhKumoDrL0yXS2atYQ0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506563; x=1717111363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7fuT9Y1ix7BMb1d7jsMKipipzI5RerSwpQeO523sQw=;
        b=AAFP4sqbboBEdhtXZJjZGow+zyWpZ3VnnbfPN4bZLtP+Y69Opl7LWL59vTALS6GtQG
         L5nkt7npzFm+vC1jStVg+5qVppTgX2YCf30TLLY1BWmJsEIlWvL3NknNAo0OqCIofwG2
         ThvA1F820U496rJQWPfBV2c/GxSw5WVNuwH5MWSNq1elVkVqGzdMHjPTmBvu2QQ4XiN+
         BIa0DHzE163dT8tq43Tulw7hL0YgfU4nm//pPuQ1K8VtLQcO8vOmRolMNodUX5INxmmu
         y9s1bpT7hZOFNK6F+bKJchHV71tk15Tn+NmDB1wwU9o2bs0biB4qKdEmxuP7INbc8Y7U
         pNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7CBrB9YRZzBtbbG49jjtTlLcFe5qhQ/N2tP7Udk0GXrZ2oDOgmw4tqk6eISso/jqv46CyoCItGSp2M+FraGIvW8X+ZykTAJXEUMDJ
X-Gm-Message-State: AOJu0YzOOnfD/5vl494drIgh5sxTcYWQ2+rvnLD6G2eEH1Jho7sQ7F6a
	hEgzra72O8EgBNXyA7RejyYja0sD8f2aIkzbeNG6XSNasXQdaoHEq43SrOiWWg==
X-Google-Smtp-Source: AGHT+IGwLF6m50OvfMrgXu5OtjFWL8dtO9YTmydt+ZsukEMXxXhyqzG9PSYlm5popmEqsreBccc6Gg==
X-Received: by 2002:a17:902:c408:b0:1f3:29f1:76be with SMTP id d9443c01a7336-1f4497d8af4mr9107695ad.56.1716506562808;
        Thu, 23 May 2024 16:22:42 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b835:ba86:8e6d:41c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c797938sm1279545ad.64.2024.05.23.16.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:22:42 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-msm@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Douglas Anderson <dianders@chromium.org>,
	Guanbing Huang <albanhuang@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/2] serial: port: Don't block system suspend even if bytes are left to xmit
Date: Thu, 23 May 2024 16:22:12 -0700
Message-ID: <20240523162207.1.I2395e66cf70c6e67d774c56943825c289b9c13e4@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240523232216.3148367-1-dianders@chromium.org>
References: <20240523232216.3148367-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, suspend testing on sc7180-trogdor based devices has started
to sometimes fail with messages like this:

  port a88000.serial:0.0: PM: calling pm_runtime_force_suspend+0x0/0xf8 @ 28934, parent: a88000.serial:0
  port a88000.serial:0.0: PM: dpm_run_callback(): pm_runtime_force_suspend+0x0/0xf8 returns -16
  port a88000.serial:0.0: PM: pm_runtime_force_suspend+0x0/0xf8 returned -16 after 33 usecs
  port a88000.serial:0.0: PM: failed to suspend: error -16

I could reproduce these problem by logging in via an agetty on the
debug serial port (which was _not_ used for kernel console) and
running:
  cat /var/log/messages
...and then (via an SSH session) forcing a few suspend/resume cycles.

Tracing through the code and doing some printf debugging shows that
the -16 (-EBUSY) comes from the recently added
serial_port_runtime_suspend().

The idea of the serial_port_runtime_suspend() function is to prevent
the port from being _runtime_ suspended if it still has bytes left to
transmit. Having bytes left to transmit isn't a reason to block
_system_ suspend, though. The DEFINE_RUNTIME_DEV_PM_OPS() used by the
serial_port code means that the system suspend function will be
pm_runtime_force_suspend(). In pm_runtime_force_suspend() we can see
that before calling the runtime suspend function we'll call
pm_runtime_disable(). This should be a reliable way to detect that
we're called from system suspend and that we shouldn't look for
busyness.

Fixes: 43066e32227e ("serial: port: Don't suspend if the port is still busy")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/serial_port.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 91a338d3cb34..b781227cc996 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -64,6 +64,16 @@ static int serial_port_runtime_suspend(struct device *dev)
 	if (port->flags & UPF_DEAD)
 		return 0;
 
+	/*
+	 * We only want to check the busyness of the port if PM Runtime is
+	 * enabled. Specifically PM Runtime will be disabled by
+	 * pm_runtime_force_suspend() during system suspend and we don't want
+	 * to block system suspend even if there is data still left to
+	 * transmit. We only want to block regulator PM Runtime transitions.
+	 */
+	if (!pm_runtime_enabled(dev))
+		return 0;
+
 	uart_port_lock_irqsave(port, &flags);
 	if (!port_dev->tx_enabled) {
 		uart_port_unlock_irqrestore(port, flags);
-- 
2.45.1.288.g0e0cd299f1-goog

