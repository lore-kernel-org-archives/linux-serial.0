Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC3448B92
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833914; cv=none; b=q5BaPbfIMnO9lXkoVPKpCw09ZwNVp4yOwacIJYMydf6PVQNId5RZE6qjYfsnd0ekotOX0Lbc5v0Oe+R9LQd/hBkFfST22ZVRJJm+W+NTmACUlE2jSZAB/5V7YZGrnsKuVuycsw0Bavv/22g8RCqRorU0hI1SpFXcWDS4KKO2Uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833914; c=relaxed/simple;
	bh=MRGrhbWZVYwnSjvuiDXUp/YI+gfa7hnsqkfSWAXUbKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEFfuUnqXXv4qhYGSEN1cQmMVHW/ojLeUg950fM7j/zGuhTk1x/7dR71YvmnHRS9kt9VfULyihEVPS6ZFxnG5Qyqr48hcFuaU1Pd434O2WOgWgJoz+mEz0tYbSGY71NQbdh+QhDa5ovORrnY2pI8QEpAN4Sv0fXmvKsbW4Xpqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jo5CMF3y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jo5CMF3y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso25543305e9.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833911; x=1786438711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=haCHOmpHE5y8Tw1drV9culB8U3ivLBg4pq9M6KDTT1U=;
        b=jo5CMF3yj7wRiZmHNUd1/GU13xTbECXHkJb6VRE+5x6PhzDmju3a2djNnIoEOFQqEn
         EeGkJY0UYk5LPVZd0Nd8qOdqkcNsMi6uTokpvFVdnwx0afkMkcN5hVq9cN9Rl9WU5SEo
         HJFvf3fEED8aonzcg0BfhGL5fYx/Ji7S0pKrUKtMDgQJGHlOjuIumKT69xgfPVJUKh3k
         gyYr9qndBNtsmqQAXOjK6ZgQUEHDopO2zhavu4ielymgYTXhJ72pGDECrhGNST00Ow5a
         /3tzLXVtxzfMvwScIu7lj/Fuf7Am2S1EJgyQ7cYcvvXB88Olx6YFByccV2AtvAkO5CZN
         rmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833911; x=1786438711;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=haCHOmpHE5y8Tw1drV9culB8U3ivLBg4pq9M6KDTT1U=;
        b=b7TePJY5W/OjPZnUcpmAl72kjEuPFHn8v5ZrvpYVCMf2hjkNIjt58omlhRbK8ecRMp
         wgnfFeRHKeyOjyv31h3957nhEGcqjjIMm12xrRNGGfkIWi+cgxH6dEYdeH879u50TQ6o
         vS9cMRbUhFUNeWZKeiVh0moVB0gmqK/jm7GZAJbocO3+n24tg6J/hYWhKMWOo3yQ82KM
         zOPkZJKcRL1UaBdwK0E+Kx0rPTv7EOK5k9P811s32FKkv46Sw5UupIh2+CWAen6xPPYh
         OoFR4PPwYgu29gS0tdVpnuvCJyxFpqI34pKtdpKCRMghkcxORlOLXIZZ82MJpahtkuMJ
         V/fg==
X-Forwarded-Encrypted: i=1; AHgh+RptXgw4GLfCSJLgp1svMPWhKeJCEH8wsFd1/sn8A7FjGOJVDG9mNVKktagQJjfEUj8Iq/T+S9X3Wf0qsDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhZOFToRVWkBJqoamdM6+Nb6FzXarUop0PYsuZW75LqkUBPsN
	9N543fNxEBIk3hqSVhsQ3WCFU0m2BFApGqKJ/S9SDvlX+vSvQzMxPXisrblJ++p7U3Q=
X-Gm-Gg: AR+sD11vJapp5X+m+2lgy7gNfXYl0je9pDBGr23Z2WVkLe4lM2couJdBizM6vScPrap
	3d1mZncsLRTt6G0MwbqYDVo+M5As8B3AT8lpACrsDbiAYpH9uIogE1c+davTl1ZaRWGDRvG5GM6
	OA2M3OxJchqdGaau0veGPVZ7STbY0tDDVmbicR9DefsCvT3YowU3Bq+To5V1fFm2IvoZXLT5OnI
	IXmr/VG9SJ4JSTOvA0/NeZeY3T2jqZb5MfWCrCRHnO2/ruDA/iCtWe12eepmmhMmKrSnCxI/1d0
	+MZYy6kBwkPhDn4A6JkOEyNViLF/kKj07R1xYBXmSHW30LMgtmuRd9S6EUsOPfTPcey0b7LRl5l
	MbMVgfRG0A/OPJ/BPl0+UdI8MQHp5CQqesxncinRo+k9Fs38SdP1ykKSjXbCgixXmEI3KQtzOLq
	VOGfXJpuvINgRnZXODI7C+uyIfv4uGrDzim7ZoVX4RlQPKmWtLguAOrywGRzq2g9qoxagSAP1fy
	FhpUoHCiLw5FxCe6R5q3EWv943n3Oo211tZMB7hKREuRUFRyRyN
X-Received: by 2002:a05:600c:3151:b0:496:c378:6420 with SMTP id 5b1f17b1804b1-4980c66c843mr240856375e9.8.1785833910659;
        Tue, 04 Aug 2026 01:58:30 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4994a0fca55sm74111255e9.13.2026.08.04.01.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 4/8] serial: 8250: Make uart_match_port() a 8250 specific function
Date: Tue,  4 Aug 2026 10:57:56 +0200
Message-ID:  <378b78ace1bf46d384d9ec9f4aec6b49dfb5a0b5.1785832297.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4981; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=MRGrhbWZVYwnSjvuiDXUp/YI+gfa7hnsqkfSWAXUbKw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcamcgsluV0MNojtUH94tVM1pfVMSAK1PZgEaZ nb9AwvA6dOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGpnAAKCRCPgPtYfRL+ Tne/CACt23HYm6yxdW3XjMwYv+yy+90brIpRx7heHhWiX4bAYJ8Hqqc1HvPqIKBsJNfPP5KDAH/ /HJzTrXBuhHsegnkWLpBNxCfzE4E5wyQIeKQC4uGAu2kVtmKr8fR2lFy62lCw7hK2NCkdD10yJg rEGzV5FvRrWvUuyxSNqv37rmV7R5i72z+bgRFEtuXby26qj2YIJPYQRWf5/y4dD0D5nJ8KIQx6x PyhsTgl/JcVlwU1xk6nLHsFZ5ymDMeKMwGylsEkQV/ftQnkTPyhuG3oFWQWxLxwRq98a4Jh07Fu vpjQvJFPtzrQ6KxYiKoe/3D0uiGqzHLiJ3ZyhKI8KLf1+rpu
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The 8250 driver conglomerate is the only user of uart_match_port() and
in fact it already is 8250 specific as it uses hub6_match_port() which
is defined in drivers/tty/serial/8250/8250_hub6.c unless the dummy
implementation is in use.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 Documentation/driver-api/serial/driver.rst |  2 +-
 drivers/tty/serial/8250/8250_core.c        | 27 +++++++++++++++++++++-
 drivers/tty/serial/serial_core.c           | 27 ----------------------
 include/linux/serial_core.h                |  2 --
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index c1db6a1a67c4..975b0ba53e98 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -70,7 +70,7 @@ Other functions
 
 .. kernel-doc:: drivers/tty/serial/serial_core.c
    :identifiers: uart_update_timeout uart_get_baud_rate uart_get_divisor
-           uart_match_port uart_write_wakeup uart_register_driver
+           uart_write_wakeup uart_register_driver
            uart_unregister_driver uart_suspend_port uart_resume_port
            uart_add_one_port uart_remove_one_port uart_console_write
            uart_parse_earlycon uart_parse_options uart_set_options
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f49862d90eeb..3e53ef54ad7d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -630,6 +630,31 @@ EXPORT_SYMBOL(serial8250_resume_port);
  */
 static DEFINE_MUTEX(serial_mutex);
 
+/**
+ * serial8250_match_port - are the two ports equivalent?
+ * @port1: first port
+ * @port2: second port
+ *
+ * This utility function can be used to determine whether two uart_port
+ * structures describe the same port.
+ */
+static bool serial8250_match_port(const struct uart_port *port1,
+				  const struct uart_port *port2)
+{
+	if (port1->iotype != port2->iotype)
+		return false;
+	else if (port1->iotype == UPIO_PORT)
+		return port1->iobase == port2->iobase;
+	else if (port1->iotype == UPIO_HUB6)
+		return hub6_match_port(port1, port2);
+	else if (uart_iotype_mmio(port1->iotype))
+		return port1->mapbase == port2->mapbase;
+	else if (port1->iotype == UPIO_BUS)
+		return true;
+	else
+		return false;
+}
+
 static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_port *port)
 {
 	int i;
@@ -638,7 +663,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
 	 * First, find a port entry which matches.
 	 */
 	for (i = 0; i < nr_uarts; i++)
-		if (uart_match_port(&serial8250_ports[i].port, port))
+		if (serial8250_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
 	/* try line number first if still available */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index edd1e7be2a5c..8a6c53a9996e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -33,7 +33,6 @@
 #include <linux/uaccess.h>
 
 #include "serial_base.h"
-#include "8250/8250.h" /* For hub6_match_port() */
 
 /*
  * This is used to lock changes in serial line configuration.
@@ -3229,32 +3228,6 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	state->uart_port = NULL;
 }
 
-/**
- * uart_match_port - are the two ports equivalent?
- * @port1: first port
- * @port2: second port
- *
- * This utility function can be used to determine whether two uart_port
- * structures describe the same port.
- */
-bool uart_match_port(const struct uart_port *port1,
-		const struct uart_port *port2)
-{
-	if (port1->iotype != port2->iotype)
-		return false;
-	else if (port1->iotype == UPIO_PORT)
-		return port1->iobase == port2->iobase;
-	else if (port1->iotype == UPIO_HUB6)
-		return hub6_match_port(port1, port2);
-	else if (uart_iotype_mmio(port1->iotype))
-		return port1->mapbase == port2->mapbase;
-	else if (port1->iotype == UPIO_BUS)
-		return true;
-	else
-		return false;
-}
-EXPORT_SYMBOL(uart_match_port);
-
 static struct serial_ctrl_device *
 serial_core_get_ctrl_dev(struct serial_port_device *port_dev)
 {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c4cc4f66af4b..1659805e2233 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1137,8 +1137,6 @@ int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_read_port_properties(struct uart_port *port);
 int uart_read_and_validate_port_properties(struct uart_port *port);
-bool uart_match_port(const struct uart_port *port1,
-		const struct uart_port *port2);
 
 /*
  * Power Management
-- 
2.55.0.11.g153666a7d9bb

