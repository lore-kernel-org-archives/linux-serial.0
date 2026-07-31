Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E93B71DC;
	Fri, 31 Jul 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490788; cv=none; b=KwE/GgqTQQPKMtrzG+wixNawjeSvPEU3uWpszO1WzVpqbJqMfRcx08fitL712Xh8G7TAsenZd4Q5Ih3QBCjSZ/+h3nI4ZakspLicJEeok3KNyaVktCnvkmqyRXSyJ1NMftqROcGvVo4V0WjiQs0mMIq9qwP9HoTc+jbRbDWdNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490788; c=relaxed/simple;
	bh=uc/yvEK+VclM8tTXzAItkKWAjw0OBuiiRvd82pubQ38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yh88ri/iicF6gP+fcrE9+XrIxNNKHSrK1cHMpxX0g3H+2J3cqJVobT89j9w2go8AgSVZNOWiDar1llDl8phn5RIZtJXaDJcoxj46gau4Izx4TjWdwPIWt8qY1FA2DE2PcWmAwD2Yfa7DlB2/4dPO8nOo7JZ93fiAC9RofpLzrnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLVxeWZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLVxeWZC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 741661F000E9;
	Fri, 31 Jul 2026 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490786;
	bh=8N1pdeyofShmR8lA4oJSjBbnr6Z3a/P3MA5cJ8/nLKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLVxeWZCb6BG3kq7HZ2QuvreJ1IdgfRd6jk7Zk68gpQwBbg+HCgXdkjw9JgHjiyUS
	 2LFcnKCF67J0eyW8Ldy3tmnmEVzDYnBz+CtfcfAuDDeff5S0i+li0YHq+UmXYP9HRD
	 jU+XNBsc+uYU5l1uDadteZMmShlfY2rCERzqw3FYJbuFsBacjCSfryMGRVKivHQW4N
	 /f9I3T1wxXbQAmApSlsXPRcl5D6nHD4pYyihYGE0VRg/kzt9pP/q6bt1vdQ34BcI5h
	 BEiMl4NhHrbMcMRMMrs2OH0slVQcI9lRJE9s4nROhtS25e5rUQbb5jl+i4KNpwX3Q2
	 I35PlI04TiEug==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Gerhard Engleder <eg@keba.com>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 4/6] serial: 8250: Fix corner case for port matching
Date: Fri, 31 Jul 2026 11:39:07 +0200
Message-ID:  <7c105c23bcb12328536cda06d52e6c9cec7d7d22.1785489518.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785489518.git.ukleinek@kernel.org>
References: <cover.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4834; i=ukleinek@kernel.org; h=from:subject:message-id; bh=uc/yvEK+VclM8tTXzAItkKWAjw0OBuiiRvd82pubQ38=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqycXM8zNlZ3Ft5t3ryv/EDGL7uW51sjHyyUaJ6VXSt5u CBj1RG5TkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmIrqDg6FFn0npRze/xZof z5oj1dz2ht6LVdXetDnQ/li0s0JpgnaV1Pxq100H5r+tPhKwUOg9w/4LUefLt+wQWSeldivKW/a u5YSb3r12AX7zmr3215udXDdd8tgCrQP80+SvxipfUZN+dKX7cvD/9v1y8zZ+WuF+ml3NvrYs9b DkpqPxP84fFUyJe1yp8nq57EQNDzfHU9zOkrxez+UkRE0DjZ2b7S+0udlpszDqrs8XXR56NvnAH OfL3yI8JusneBswxrja3Ju9WIht2XLeFrVNswvs3FRygq/EqTovSPqvbq/RcYG1b0unnO/k7Z8W WIbslPPu0GH2UJWPu2jzifPzNd3DPfpBHLcCltzwVDsJAA==
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
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
index 5a0bc1fae11d..e8524d545de9 100644
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

