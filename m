Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A744DB6B;
	Tue, 28 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398878; cv=none; b=XX2wLdKESdmo5Yvai7NmxjwiJmGhpP9uc7MwgoBzklGgU8baVYMx2Mt4o9Tj8JyCUNIyy2o0NL7PQn78bSKoxzad0DuD/GWWZPlGQUZhlfY6TtcCqhnRxNoFXOEtLk6ThSsiYKjNAMzrLrNFYXI0r2NQen5Kprmwki4eXxIxTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398878; c=relaxed/simple;
	bh=TLYDd+Yy/gHnM4LTrPqLjWEuY3pH1D3wpPYh7GiMDZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kY6xbyf8FhD6JGQbg73JiLBXyi0LSvTTdYSxW2t00eNYYJKKVY8TkhYvxqAnjS1A4wee7YoTOzBJsTcyOUgoRBRuj9LEofimibab+aPpZnAmwZKpHrMjaHeQkgEO2x5FgbK7tDluR/7ufvx1v2PHW3CFsV65wFFbaAtoyC1436k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=f3hxVY/W; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="f3hxVY/W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=NTgU9JuUtBjg1NMLiyaOg4aZowwK2cJ1L0NIxrv2fdY=; b=f3hxVY/WdUdrEI7K8Ld1T+9TJ7
	XkaWA9sDmJzgVmr76XDLck/JL7tn2nSVv0z8ueVMg4dDbTROifU2/ly4AOaoY6tOOm7lfcgNz4MO8
	/0kUcMegMae/0d6sHBxVlfWIcy22CyCqa8z22Z610tenv+GzAVUUDeWSc/cdCRKfa+iw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdg-000000004cz-0ZeR;
	Tue, 28 Apr 2026 13:54:28 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:47 -0400
Subject: [PATCH v2 01/15] serial: 8250_hub6: add hub6_match_port()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-tty-upio-v2-1-01c1857cf761@dimonoff.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
In-Reply-To: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Move the entire hub6 related match port check into its own function in
8250_hub6.c and add a stub for the case when hub6 code is not even built
into kernel.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/8250/8250.h      | 7 +++++++
 drivers/tty/serial/8250/8250_hub6.c | 6 ++++++
 drivers/tty/serial/serial_core.c    | 4 ++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 77fe0588fd6bd5c5baac0fa03b7c466742aa9432..9d1068d0489dc4285b1d30489926bd676bcbe60e 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -334,6 +334,13 @@ int fintek_8250_probe(struct uart_8250_port *uart);
 static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
 #endif
 
+#ifdef CONFIG_SERIAL_8250_HUB6
+bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2);
+#else
+static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
+{ return false; }
+#endif
+
 #ifdef CONFIG_ARCH_OMAP1
 #include <linux/soc/ti/omap1-soc.h>
 static inline int is_omap1_8250(struct uart_8250_port *pt)
diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index 273f59b9bca555e9fb035005d3df2089c5b0a039..eae32c924e29bcaf608d66988aca461b9a53dc91 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -41,6 +41,12 @@ static struct platform_device hub6_device = {
 	},
 };
 
+bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
+{
+	return port1->iobase == port2->iobase && port1->hub6 == port2->hub6;
+}
+EXPORT_SYMBOL_GPL(hub6_match_port);
+
 static int __init hub6_init(void)
 {
 	return platform_device_register(&hub6_device);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 89cebdd278410a5a97f3f5ee1b9c171715145067..7354f8af4853d34e5e819c2887f287970c653b69 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -33,6 +33,7 @@
 #include <linux/uaccess.h>
 
 #include "serial_base.h"
+#include "8250/8250.h" /* For hub6_match_port() */
 
 /*
  * This is used to lock changes in serial line configuration.
@@ -3198,8 +3199,7 @@ bool uart_match_port(const struct uart_port *port1,
 	case UPIO_PORT:
 		return port1->iobase == port2->iobase;
 	case UPIO_HUB6:
-		return port1->iobase == port2->iobase &&
-		       port1->hub6   == port2->hub6;
+		return hub6_match_port(port1, port2);
 	case UPIO_MEM:
 	case UPIO_MEM16:
 	case UPIO_MEM32:

-- 
2.47.3

