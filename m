Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF7449997
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833916; cv=none; b=XwsqZyyhy3cwE5Q8dNeV5cDZ2y2AQVKoLuDbo2d0X0Kkt/YRzq5IZBb2lLyUnlhsdPAos5a5/sir7EKMz0eedt6N9y0QUAiaRMKebm/4yNSOcUp6sCevMMOyhSEQJy5vTd1NofHlcMa35reZK5JVXWhHRG4AcIKXqdF+p5CLOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833916; c=relaxed/simple;
	bh=g+evHTRP4g65gc5h55+HJoMYHW4T26WZDIbPM78rRDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNH9WvhB+Zh+jh3aP7Tf9rkPEfCA93FHDMVL6ZAn1PIgpBP353QAnj1GGl3gHJNEBcD7pJUEqo+4xgf3Ggp0d+1reUgOQkZ6UxFho1lgJWf/qkLYHEMxRGiNa8claeo4zS7kKcUfEkWn52MxXi9lUsJ6GqXaBV9Di/SFWoFgFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Fk2AuA7g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Fk2AuA7g"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso4940885e9.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833913; x=1786438713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nykDGsyVZBJ9u62/lqEhAC9qbabpwVZT+8aoHcWb4pE=;
        b=Fk2AuA7gBaoYzWXZaeKZ420UWVnQX0RUXqgQnJzWqw4KeKMI70TkjObAtfAxmo7m7O
         +GhSmU3Ivus/CnNr/aCeVorYewlP5GX6x5bObP05Y9J9OTJtak/jhGtxmoz0mBpojal8
         1Jia6mDZsEkXGLG8M+Jz3X6YL5wASwrzchEywVKr2unuEIyJsjknZj0E5N+OWAfuI3n9
         /i5lXo7W1QUcGBPzhZdwjGBaAL/7Mw1kNR4dJW++UbnrRyvUMr79QP5ujZ4kCh3QGEKX
         +tWNS6xkdvTWMqQrfJmvaVtJf0vAl2BHhotlEr2zjFTEm4kghZDOmI6jOILOJlXONsaY
         TyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833913; x=1786438713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nykDGsyVZBJ9u62/lqEhAC9qbabpwVZT+8aoHcWb4pE=;
        b=KMUa7Uihh7hmzq2g0G1tVy4d3CTvReKqXiRmM4LvnUSnhVkxuVbZvo+7okMXNetDQa
         CPvEIW4uOD8VDuLpNeV3YURSYzSEVy0LFoOwbMXoz3ksfFr/tQbiuVD3I2fxFQFecl2a
         +oVcpz1qHvZA/b0ixmt1K3ZJNWVbBwSMkOeu1dMzbLcIRdvppVDYy7thddCMOrBhXQpY
         smx9b1MDVvOw83ubHPMY8tHVq6JsQ+BOp0AId1DYV0INA6oSM/8JXv0KNhGR/or6KvDz
         X+Ofw3duyQD6P0OizWFmnsiLJ4e0NlKzUru432jPfMN41+pJ6zc2nQ1nfBkQ4lKNqeKK
         0wTA==
X-Forwarded-Encrypted: i=1; AHgh+RqBu8qmfRQKn9JnF1h54Q1YSYuOdK1DWtaf2tgjCPRvtQpLYQCYt4Zz+Fos16H5wdZOwy9bE/xhwk05wfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OwvRI9q6d350vnbxJ0CS4DLBbpmAbh62pj966wefEUthUfnw
	QXbTOsH7yQJ1mMHMBPNagA0efluzYXW64LXbXpXK5t7v6KILuchXcRgK027mbkiiLPA=
X-Gm-Gg: AR+sD12u9F7Euxo1fAtCQPyO48bhIfbtYIMU6zo9buGI9nD6ltpOTuxBwWRbHwfgWXg
	icEgDZtLeD2NTB1L1/gSr0q63VLTXS4jjA398yWKFyZ6EIcMi74iyTetdUwoSkK2HjRbvEQQivg
	NREXj4OHXh/E58L+yXEDmRQZeRo+0fBKmOTq6+sipGtcf/leiAC5TFlwqnfDFCbFraay7aTelaa
	2mXDjKrhRyAaswLi2svZlV2VoTr/ZFgN/m1/2A4tvKm6CccSyNFCaGqiayJrIbuhoHvqlSvq7oa
	Fm1l1KAcogW/qHAUuNj/KKqmdmN5NJmACirG1kpCt70xkoLu2lPX6ZcEOqfxTirZLOJ7GHZOeIO
	EWIB3k2hdL/Hq9e+xcErQNcbX2xLL8ad0SRV9SA4WmJHtmL+NRKMHNnofcNupuBxAc+jeWb83oS
	RfYHv1FJHQurL6Siq/NVfUKGtphScRIYMpE4aucL6To5AXmDj0pcFqaJQS2l7yPdfudR4XKcx0t
	nzAhxkAmyG10NMFMCjEXAhMadI/JYuqm65+xewD0x0PFu4EvUO7
X-Received: by 2002:a05:600c:4f86:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-4994a0fc5f1mr52353335e9.6.1785833913211;
        Tue, 04 Aug 2026 01:58:33 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49949fd0a08sm71408695e9.5.2026.08.04.01.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 6/8] serial: 8250: Fix corner case for port matching
Date: Tue,  4 Aug 2026 10:57:58 +0200
Message-ID:  <add1bde4fdc3bec5a4517dfc09131274b9fb951a.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4861; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=g+evHTRP4g65gc5h55+HJoMYHW4T26WZDIbPM78rRDo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcamgvTO+R6M3hvF4UpaLb/icPCTsWQDiX5j6+ bgs5RTmH7+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGpoAAKCRCPgPtYfRL+ TtRmB/9HfgsfngOin172tw2vfNWCrW+uvI4rv9WxeIg+d0g4o/1JVBrG/TLwq6Q+E+yGXIynw9Z x6OvvhiVTnLHQpfzeVCEQfypZIgfXsxLeUdgbb7o8KF5qsG9zeiBsUCoAHs3sOn94eMRRsoLi8o xDOVYTKfdM8lXGMUYQMuusGG3971A5vBeHqX771Qn9wB/va/7WJ8Cbd8T2OroJbscy36R3Vacne CnKIER4uryF0WhhImpW6eBWjw2MYASNV5LuYxry5DJ1B0lBCdJWJkpA02V/Tjc2X2Kv2USxu56h cqaBGmjG4ViOrZR0TCHUfu4rkraZMqjixIPKBNwznmJRIjJi
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
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250.h          | 8 +++++++-
 drivers/tty/serial/8250/8250_hub6.c     | 8 +-------
 drivers/tty/serial/8250/8250_platform.c | 4 ++++
 drivers/tty/serial/8250/Kconfig         | 4 ++--
 drivers/tty/serial/8250/Makefile        | 2 +-
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b62f88eec881..39d72f1480c0 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -315,6 +315,12 @@ static inline int serial8250_pnp_init(void) { return 0; }
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
@@ -335,7 +341,7 @@ int fintek_8250_probe(struct uart_8250_port *uart);
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
index fc3e58d62233..00c2ced12717 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -294,8 +294,8 @@ config SERIAL_8250_EXAR_ST16C554
 	  will be called 8250_exar_st16c554.
 
 config SERIAL_8250_HUB6
-	tristate "Support Hub6 cards"
-	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
+	bool "Support Hub6 cards"
+	depends on SERIAL_8250_MANY_PORTS && ISA
 	help
 	  Say Y here if you have a HUB6 serial board.
 
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 6d21402b4435..416c32e3aba2 100644
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

