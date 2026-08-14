Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549345FFC3
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699203; cv=none; b=drRILGChD/Gisa5UtUErcZZPIpea/nCnD9svxIotty3k786ko5HLraDNyPETNRKfzwQ0Wce9lpNGtCHup15GACe2l73F4Ezt8c/gX/qP8sYTzwpWDqWK1FPd4SqXOx6KB8foMzrP2vFvlPJoDlmBpuEnp5lNkTSCKJfGeF3Xj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699203; c=relaxed/simple;
	bh=QTuOizhRHoClmZYTKOw9cEJ+rMnns4nYIgpLTQdaR04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Elrd9VhL4iMJ2zostd6pTXrniP0UFxJce8IL6pNCWc/PjYnkLitrCuamDrmrDz3pPW2xs9bVinjiYVP3YLwABfc3lCY1BU2gz5I81iLITgtNp2A03CsRYXCayHOqRK8Mngbn5OuaDgpGI3mLFlIsDyjzJmFNSbZIAAgq/pVXvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ptxzl5Fl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ptxzl5Fl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-480001972b8so275505f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699200; x=1787304000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VMzgJV+k3ROB9Sa1xAtrYA5khAOy2hOXI1Okgba0+eI=;
        b=Ptxzl5FluFa0XQJx2qSjnj/MtBtp+Oo3fwSOpPdYhHRXmzMlQwGYbrJ8lu18fHrKGY
         sowjnJSfQAcDIXd5zd/dK6IOWi+hFJOtwh1T5AsXGHoC49EsBQajVkmuO5qhJo+8t6s4
         thUttEKLXTQ2NFnOU+Dc0mblGHaxVebSzmQNj5CmpKJyHhIORYk6wzGAQUdEdkiJWSTG
         SenjwGu2+RwCbwunsJYnFLrh0yInx7a2oCZBMfgaYHTbw6TYTKdpefKeMLq9wUpsCDAZ
         D4Nq2UgAl+rx8mDjyOb9Hac6DOVPAoI7yG50OpQUJnpYJDsoeEGBoVML0q0tlKMGFl+0
         ejQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699200; x=1787304000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMzgJV+k3ROB9Sa1xAtrYA5khAOy2hOXI1Okgba0+eI=;
        b=NBEiwJTeudKp2rkm0oZcVrnvwBgV2tKxkUW4CBwGbWLnkYfa+kNnu408/0bgqYAp7W
         rxPCfXl2WXRtEGjEmrI7DGzjjj0chl3Q7QTbuG/bPD+bUeZLnzswlaiP3/5OGnWlOTw9
         +Ej8R0e9X1q9tgRFr/Ti8xrawrDhX9WesCWepjrFnWlFv+5VGUdHk3gRTUUVJebwAuuD
         /bSqxN2+/oc2Ks/BYJ+m6r48KcM1bpcuSZMdqQLU5DQxf2UeQZezmryT9n37zT5j5lxV
         4gsHtM5sFgn0fmTUeiJmW9+wJbwcKSriDwDAHiPB5EB+26GNQkMyw56x+zSpVYOq/caG
         EfUw==
X-Forwarded-Encrypted: i=1; AHgh+Ro//0pZU7rpg5dTPqHkQTZyDkVs5O6FxC6BO29DNf/gxcLHtcmNPic9MPc8nh0fIzVpjLRgpC45gkmP7ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiKc0CWXUTKHmkkx3TB7md+cSzsFIatr8mxHsGAQLTnHg1qpI
	lqDJumsgVIaKdZ2Q/GCG9vvN+wpM4MJo517XEtnZVcbSQDQDc63vJNo+2MiibMq53UV/nYl1Oqc
	6ahMMrlE=
X-Gm-Gg: AR+sD11E49Anlxr8ySM0iyjthb6fb8MwA2gLKgKu9oIm1h0dyER60sbyNJHSnr1vv58
	GaMP6Z27FPGBwvh85znt91l7vK3l8/ntks//Z0lz94YePbKkrLxYmWkb6ii5bUocRMIyS+8f/ZD
	OOOMUH/SJk6SHqOQ8f9gLx7yVzTt2sOvar+bzau2C3l+6wE5LH3OaOPk4KJ1N3LZc1mJezx6hUl
	zv/8qmE+TOaDhdopxnqJH/p9fqtQTobVVXogUUEfQL4kizjQLTFnyl8mi8tJnVLkZ2OgTWy2vLj
	+YUcfqaiDDMtHhmXePthKzVOyl2rOOTnzZ8PAvOMhZoU5Sq8FhpU+RUgHs7cPue7XIZt0C1HBK5
	CptqgfI5taLK7C6+TjsRhRo/ZMIkwnHMaYwRRtw3RCzA1SmpKp1hJMIKsv5rxd1z6tZbkhqUAIl
	Vhz9V0QRcnYmW1o+NGNyNyZeV5N1hntKtriOJvNua5jKo+A4DQ2kFyvVDqDhOIFEcEK8/7D0oHB
	Ddke7xlcqWa2Dyd8eVPcYLup6B8Bo2Cd7K2y+6NdbpkXfJB+pDMqZk6W86V5ac=
X-Received: by 2002:a05:6000:2588:b0:47f:97f6:d39a with SMTP id ffacd0b85a97d-48160799ccemr6466977f8f.17.1786699199787;
        Fri, 14 Aug 2026 02:19:59 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815f2cc811sm6432734f8f.33.2026.08.14.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:19:59 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <eg@keba.com>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 5/7] serial: 8250: Fix corner case for port matching
Date: Fri, 14 Aug 2026 11:19:31 +0200
Message-ID:  <9ad6983ae584ce9d962f2a841f4d5e90c2012ceb.1786697789.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
References: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4924; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=QTuOizhRHoClmZYTKOw9cEJ+rMnns4nYIgpLTQdaR04=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqft2swfFzcYUUx6vh4ZvnCzAFXvSsotLVerHa6 8+xt3TmiIaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCan7drAAKCRCPgPtYfRL+ TqlWB/4gy/VvGhrzhpcWuR5oQLWBnFaVaIT0lz0/S6b85umczwGT0uN8lh+XDBsD4F+gcSa+EPn fxgDa/SU53riFERWU1lkBDioI3OYUgqfcuzmnQa2KhWDlk2cC8jUE3ZaxTGjc0mVx2whV5fFge/ SGPkHYxiTDSUI4Zb/D3wLkWKpF+l1+szklFJEh6ZgMPvg8nZbDVsAD46FVfve9h+ZT0LW7WJQlv u+Fpe37hLi2OJu40q91j80AKnSk5zr4CTVn8gBeePRPEf/1Z8TPPUtz9SVPYS/QLe9+bBYLAO19 KqMk5Vn8wnm9RUVKzkODWsCMNIDAOixDeNv4jcvvKHks/bkR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

In the case CONFIG_SERIAL_8250=y + CONFIG_SERIAL_8250_HUB6=m
hub6_match_port() evaluates statically to false in
serial8250_match_port() which is a bug and a change in behavior compared
to before commit 7ab80d1e7243 ("serial: 8250: fix compile error with
hub6_match_port() when compiled as a module").

To make the comparison correct, the dummy implementation of
hub6_match_port() must only be used if CONFIG_SERIAL_8250_HUB6 is
disabled. Then as there is a bidirectional dependency between
8250_hub6.c and 8250_core.c, put both in the same module.

Fixes: 7ab80d1e7243 ("serial: 8250: fix compile error with hub6_match_port() when compiled as a module")
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250.h          | 8 +++++++-
 drivers/tty/serial/8250/8250_hub6.c     | 8 +-------
 drivers/tty/serial/8250/8250_platform.c | 4 ++++
 drivers/tty/serial/8250/Kconfig         | 4 ++--
 drivers/tty/serial/8250/Makefile        | 2 +-
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 9337fec9394e..3fd25b7a7b81 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -316,6 +316,12 @@ static inline int serial8250_pnp_init(void) { return 0; }
 static inline void serial8250_pnp_exit(void) { }
 #endif
 
+#ifdef CONFIG_SERIAL_8250_HUB6
+int serial8250_hub6_init(void);
+#else
+static inline int serial8250_hub6_init(void) { return 0; }
+#endif
+
 #ifdef CONFIG_SERIAL_8250_RSA
 void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops);
 void rsa_enable(struct uart_8250_port *up);
@@ -336,7 +342,7 @@ int fintek_8250_probe(struct uart_8250_port *uart);
 static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
 #endif
 
-#if IS_REACHABLE(CONFIG_SERIAL_8250_HUB6)
+#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
 bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2);
 #else
 static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index b6767633c966..3e548530ec4e 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -49,13 +49,7 @@ bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port
 }
 EXPORT_SYMBOL_GPL(hub6_match_port);
 
-static int __init hub6_init(void)
+int __init serial8250_hub6_init(void)
 {
 	return platform_device_register(&hub6_device);
 }
-
-module_init(hub6_init);
-
-MODULE_AUTHOR("Russell King");
-MODULE_DESCRIPTION("8250 serial probe module for Hub6 cards");
-MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index af946d12e764..3a2dff9ce7b7 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -319,6 +319,10 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto unreg_uart_drv;
 
+	ret = serial8250_hub6_init();
+	if (ret)
+		goto unreg_pnp;
+
 	serial8250_isa_devs = platform_device_alloc("serial8250", PLAT8250_DEV_LEGACY);
 	if (!serial8250_isa_devs) {
 		ret = -ENOMEM;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index fa6f33303cb0..1d3f7e57e959 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -304,8 +304,8 @@ config SERIAL_8250_EXAR_ST16C554
 	  will be called 8250_exar_st16c554.
 
 config SERIAL_8250_HUB6
-	tristate "Support Hub6 cards"
-	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
+	bool "Support Hub6 cards"
+	depends on SERIAL_8250_MANY_PORTS && ISA
 	help
 	  Say Y here if you have a HUB6 serial board.
 
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 46adadcfe072..330dd6cf7c83 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o
 8250-y					:= 8250_core.o
 8250-y					+= 8250_platform.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
+8250-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 
 obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
 8250_base-y				:= 8250_port.o
@@ -35,7 +36,6 @@ obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
-obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
 obj-$(CONFIG_SERIAL_8250_KEBA)		+= 8250_keba.o
-- 
2.55.0.11.g153666a7d9bb

