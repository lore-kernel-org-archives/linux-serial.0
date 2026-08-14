Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B2A456DF2
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699201; cv=none; b=u/krWvCYos7XP/jAi9RRTsTNE/F2iKKFPTiVGD8QVnAHld8NANkEj8bj6NNSUpeo9WLYYfQMWcTnR1gOYbnDeOjQLP8b7CSulBE0KQVv41egP2t0+o8EVsLLTzAQjK5A3uyMbPrMmuXJW8IKS5LMNKWhlgcM3uuWmdiMDK1neXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699201; c=relaxed/simple;
	bh=2sNSyeHwlo1iJxAfsdit9RrWvURm4tpiXcynTe0rlZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abZrWHDZ5XxglRoLqe7c/cEBhSUurFM0bVQVSiu0RatmexhDsW5HgKwC0utWZlIBToNMVXlLsKDZtHsJwILmXY9bR1VfN2iO5PqZk/nTkomUySK6r/ytmnxRW0iXgwiB6xKbVyJ8RpI7HDADcQ6VpCM9a7m9lIZc+l1mAQ4qbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=I6MviUYU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="I6MviUYU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f84023916so690250f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699197; x=1787303997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DtoSRUtagmG4idUbZhP76t47NSwZbUeuCRMUScCpafc=;
        b=I6MviUYUxv0bpz2qHs7q+NgYqPfW0atSOJqn9rSI14rytPPDDHQZZGMoCCFzjMlxe4
         T9yyZ5id58O1Y9DidVVVdVzcgwFtIHHARQy57yQ9t9N7zXSCTZlnpaD9k37I/C1zd7KK
         EBhQiSCj0g08KzlRTMjv+KmliXqMRb/TaSsARdCWdDpjDX8XrLbVdsQiQHNZmyAU80FL
         tzHVF5vyZz5ycS/7aQX/XYJ5wdasC7gRiHsZjzmZvVpDq3KmNV/snwr3YOslZL6JlFMK
         w4Q1n9CkeQBEiT4BqcgqEaSWoQuJpZeBWUD9wcax3umsJG37lhdzKc32bcaDTyRF1GsM
         I72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699197; x=1787303997;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DtoSRUtagmG4idUbZhP76t47NSwZbUeuCRMUScCpafc=;
        b=FnMIGe2IHxFnySii8880zNNFXWTm+IUPEAK+Jz4asAWvPJUdLOD1DJ6LQbSti2LOJo
         6wD4B3GKZ3gXbsXUIg9AlyRvBrlunqV97Hb2N++pHJpwADA27zfm3MpqFJUKEjI+t5SU
         FpoUflERAXAbYOGWyCCNcmVo8CIbtOyIbNfRG4LRAolsbabnFfi3iFYE5FFqu6J0OyB5
         nr6iLurxLasptss+g9G3ztJ8/nPOUr4sB1UXNjU41fVUZrDQIsdEnaEh41m7yumF4O/R
         kik8YdRKz7KlMWNnTidQtzytjEkLB3rq4vDLkk4PGX2FWFMCGnSJuQTZLH1qsT/uOCTb
         b8Sg==
X-Forwarded-Encrypted: i=1; AHgh+RofMrXr8bfX4+0Hy1Oj4Zso0+oPW2zXCcHPIzTVAHrSuO6m5OA8l5HMLyhSd6FMGnp99tiuToQjEyDFn6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Pat5OqIBK5hieU9/qTdJ8/Fiwpb2V2bbneW8FutE2f8q+6EE
	5xlDkUT3RTadkaYGiMkwP7j9y4pIUtcljTjlgHnawOm6IGfK3gMwNoQj4CS5qx1pSAQ=
X-Gm-Gg: AR+sD10BuIPf+H6fSgi+uBDStRJ1fpcvt9u7xf0d5SVfYr0XwaFYVH5/vBVtnkFmjzf
	d0nijqZmUirB5Otd/rRZ+8J3l7Jv/kMxya8PRv6zGaDMTpX21kLlyBHw+Fs9erxqMlsXwZDXYFP
	0iIz6cF2R2QZeIEK7aFfkd64GPpQX22G7z/CpeO3wQNU4GcYtc3iJOYrCNmZHjV5BHjidTKrPk8
	xj9v92DPAa+1nHEAnTIW1oFcdJzMaiQC7h4xhDt6B0x1FaORcAP5TyILMIvMGzirDmHZS4XefhP
	8bvG11KNi6rNG5cFTb61Ys3v2v4skqjaSb43728g9DbJjkOuJy/dPBHkbUYls9kBJi5HVyKCbDf
	+bghWj4fCTJ2U2dd3YxwoTLwOaOiT/BwWTM6A1C/vTK1hFBmo2FecAOnuY7dzFSr+2/Bq0CKbYb
	RGGw+X5f+MQo/cne2F1FPtP/DVMsQ21snj/X4fnsgkiq2GSVP8IwpXYrAciSS1xCA2W7BaVLSax
	sshNG6Jhr0wB/io9WkhTQyXi2all/saW1AZavk3Upy7aZWEH8oHYNDnRsFQEhk=
X-Received: by 2002:a05:600c:364a:b0:499:8156:cd3f with SMTP id 5b1f17b1804b1-499879533dcmr42065965e9.8.1786699196972;
        Fri, 14 Aug 2026 02:19:56 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499899afae3sm14329385e9.3.2026.08.14.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:19:56 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Ogness <john.ogness@linutronix.de>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/7] serial: 8250: Make uart_match_port() a 8250 specific function
Date: Fri, 14 Aug 2026 11:19:29 +0200
Message-ID:  <be86d77ed317b0e77249c9a2f4d68780c1f60f90.1786697789.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5044; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2sNSyeHwlo1iJxAfsdit9RrWvURm4tpiXcynTe0rlZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqft2nVTAW4cKsaw0QBBZvU9e91i3V/p3V0GC55 arZnOgna3GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCan7dpwAKCRCPgPtYfRL+ Thj7B/9R0tQWGSjjBZByxpMi7NiBJSakjzGXj4jea+eqhNG7C3opAdsLL+b+2UicscEZci0jEGv kKNTV6WaaH2156OkJ8keS7g50MnygGTz1fpV5Db+BrMbmZCTQp94x/PVJ3G5g5MZdwh5LeU1cU8 lSm34dZgHneMekiwcCjOs5oinRgmwxqzVuEykxi+7VhNk/30FWnZ7arQ3qrE3+t8vR6gT8Y7v2i tplP3N/VTdkdR0goRnD+nQAMxKPJBVhv3I02B9+WX4faCWOE+tRJa8vdOiAVHlIS+cbH/WRuxaH GcUyRU7j6rBLubwtXUC26AvEDCPlkv4dWYJ4C5jHz2Ci/VGu
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The 8250 driver conglomerate is the only user of uart_match_port() and
in fact it already is 8250 specific as it uses hub6_match_port() which
is defined in drivers/tty/serial/8250/8250_hub6.c unless the dummy
implementation is in use.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
index b875d394796f..d8199c583830 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -673,6 +673,31 @@ EXPORT_SYMBOL(serial8250_resume_port);
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
@@ -681,7 +706,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
 	 * First, find a port entry which matches.
 	 */
 	for (i = 0; i < nr_uarts; i++)
-		if (uart_match_port(&serial8250_ports[i].port, port))
+		if (serial8250_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
 	/* try line number first if still available */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..ee75f53979bd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -33,7 +33,6 @@
 #include <linux/uaccess.h>
 
 #include "serial_base.h"
-#include "8250/8250.h" /* For hub6_match_port() */
 
 /*
  * This is used to lock changes in serial line configuration.
@@ -3233,32 +3232,6 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
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
index 904760876ca8..4eeb8253752a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1140,8 +1140,6 @@ int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_read_port_properties(struct uart_port *port);
 int uart_read_and_validate_port_properties(struct uart_port *port);
-bool uart_match_port(const struct uart_port *port1,
-		const struct uart_port *port2);
 
 /*
  * Power Management
-- 
2.55.0.11.g153666a7d9bb

