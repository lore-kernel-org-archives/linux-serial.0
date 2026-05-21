Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896C383987;
	Thu, 21 May 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387422; cv=none; b=gtyRDyF7JHDkvuk1r4iAg42kYz6pIQyDfj/3fpkohK2432ECxQ/kauJBwkn5DzuibtwblC5MY7i2WBQ6qSNEiHrHtXf+GJWuCl2rQqysmLAorZMp6GzXdcffV8V8saRp+II65CP0NFD0GPXgrym3CR6reMLZTdLoAjxj+4qb6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387422; c=relaxed/simple;
	bh=NQGPt56E/o5+7zH9da/9d5hBkf8Wne5C/W6JQO+QuQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkDKEmnUE+Z467ei3fIkmokEiHxP6pM3dDOQD9kx31ZxEW2RS90Fv6V32uliF5FNacOIuSL1FSLbku/5U9q272aoM/eAO38C3drVom1gCNftiphbkdg+1Yyn/7M8C2xmD5grRimQoeascwP3ApfTpoERaj8yI8mczvyg5xBPekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=z0dec9jH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="z0dec9jH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=T44N37CIX5+e9Q7CPVwpyuDmYPlxs4cUhzuBv7EI0PA=; b=z0dec9jHVxnnQE397BlCeAlRqQ
	LnJiBMD0QIveEczHlC/ORGledRp/ThW5BjeonEC7grOLAfiAs24I3VcQUSoNqydfdRLiAEteE8vO4
	mWgCidb3LX2tFkYPD0MeROuGdBM3vVn/q4N2+fohChvkvheeXN5r379CPrnAivLOJX1w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x4-000000001yA-1mP2;
	Thu, 21 May 2026 14:16:58 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:47 -0400
Subject: [PATCH v3 01/10] serial: 8250_hub6: add hub6_match_port()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-tty-upio-v3-1-bf74567994a0@dimonoff.com>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
In-Reply-To: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
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
index 075a69164aa7c56137a2f3d2245ef3eb1d2285de..05bebf666a5d5ce66a05181c69db48e7355fec42 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -33,6 +33,7 @@
 #include <linux/uaccess.h>
 
 #include "serial_base.h"
+#include "8250/8250.h" /* For hub6_match_port() */
 
 /*
  * This is used to lock changes in serial line configuration.
@@ -3194,8 +3195,7 @@ bool uart_match_port(const struct uart_port *port1,
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

