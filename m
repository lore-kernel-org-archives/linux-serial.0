Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D245C71A
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699199; cv=none; b=G5FdN+LoyHnkBW1aNPAsMzdGMHpsaKQRFrPbjZMCR+RXeG+roz0cHf3tbgAS+k1sYokfxOzLAmRGFCXDjZziYXk4JVE20R5RC6OqTMpVrrOMuC7YNZAsYqxywZuydn0ixpIJLzHimhvD4alumKeEzOlcFpQDyVE5c6J3aMuMLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699199; c=relaxed/simple;
	bh=B0hyRg6SFBi4I7J+00dwIsyuLQTakRVhZSTprV+T5Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7e4OA9kINh1ks8S2a9nkM0pCPIp8VdvKU7XAOJueHnbBTkQgVm1aKwp5pSdYdOKO0ownL6GgTUF2GT9t6KkC7ZSCWOsol12aPEmDHNKisvnjLAh9+ACkKJuRIeYQ9SYbDHq+RA/+m4g6HyNKK4S2IOX4WPFbqE0dL1fnxsWHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hP3rn60d; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hP3rn60d"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4798bea72f9so482118f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699194; x=1787303994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNFeMWmv+NMrZw4pQd0HP59/wbeuN2eBHRitJa7/Q2M=;
        b=hP3rn60dfgjAbAViLOAwBJi0MPkGFn562xbp7+0zlhpeDsWzNTm/X6PoZpweBmBx9u
         5gG+hb3tb66IfaaOVxgVLDhSTZEVhMqmnXCW/Bn5T9mzt5ONk+t1ioppEb8uhKC9ozQI
         nm+KsLxjcYd5mXWzqq0No30+9LP38qYFl/9YuShvNW9tTEhzBSbOqKy8kQQ4spXPFuUF
         Thv7Fwdvab9viGttVH+QSLpyXWQJySbAWkgYjdL0HQILGxT2iCQeKBAi1dYe8xNCwr3i
         3FHtki4spLpCfXYsqRaZm/36LEv/2UoEo4h2ISsTnK4cyzyUvk/7DuTX8gDFtCUEiq8O
         c5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699194; x=1787303994;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNFeMWmv+NMrZw4pQd0HP59/wbeuN2eBHRitJa7/Q2M=;
        b=YYGyVB3Qvv5tm1Hl30764TGFHlnP6UkbzCYxUYZrF8JgTAhkRwoxvmmeJJD1w5vddh
         ws2dwJtly8SftY3UDV11rRUbKmlmC/9OmM9NBt69C9jZbqLPLf8OTuOW0F6JW91yNbkJ
         R+73TE0qeX9wCkvVKNKK2gKE+5hImlPKEiWYH6nzDyym6FMdi45WBmGcLpSROsGNSGDr
         WBpTWckNHv/Du+yHPZI56jtDtc07auO0vxzl0MSDIXWqv1CPpojPgYFLXecaaKYeCtNQ
         g/5+zE6uqsXKjmtv5KC0uGOaajHVXrqFwCmZ6QwWr+bLOJiMhqKhZiRbVmzij993na8+
         bjuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOyTMD4fSKrhM2B5EVz8322s1M9O+CBz0NZkTWFXQIplhUSZMi+QPnG+neqFRHcNAPBLNgb5PW+52x7DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNHvQzJxKUq5SuG32t5G5vqgqs47a7Wbkn6cWZBjOpfx7W1IJ
	6ySe+/69RnpPwInMLljGfX4Pnlskt+1LZeEDTG5ycGsNGV2JJvh1gzK/tjFma/6CHEY=
X-Gm-Gg: AR+sD11erFVhSY6AUlZsiu178wax1SM4GKJgJMJB9ShFuutfthM/CGs2c5VFWYoAba2
	yVlAf+nRxKnHTUwzhTGR8ST0euGMSRup+t/u9Cx9h436E9RllPz1+JGZdGm+xIu7TxVNLhZEQSR
	cnjlz7ucXTayopBSj4hD45OAKHtunZhHe0AppD3jZVujmvhcR6L9EeKO6U7ge9ZPCUfZfKdcCzK
	ATGoJPZfVqRBtVOBDhEZ24Yr+s3AAJ6Sv33ZKAkMmYKrQA906GXEUiFJyhG8aSOml9YE9lUfAkJ
	W8cnjTr6bU6rSdmPXW2cX3EBgvMIdyipG9IcjaC/nZ+uMJip4m9w1ULZ04VeIv/El05FFTuZ2Vc
	xWlLVFRGDR07H8Km45+X9DQRuT5GPsAZuoecjajCsH2rgHbKG9kBj4vgagYmVbR+KjsJ+mf7hn/
	x/VvEqqEzDl+Ilvtr9qJDw6zGZTyNednLa2MtM6TZcZLXXw1mv2JNco7uLBYk6fbMQ0jfZA8gum
	KGOyn5FAmO/kwrvGHoKdXFe5VI3coYiBjsVJndeuHY5MQrtUsqP
X-Received: by 2002:a05:6000:2588:b0:47f:97f6:d39a with SMTP id ffacd0b85a97d-48160799ccemr6465996f8f.17.1786699194189;
        Fri, 14 Aug 2026 02:19:54 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815f21a31dsm6965832f8f.9.2026.08.14.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:19:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/7] serial: txx9: Drop noop probe function and dangerous remove callback
Date: Fri, 14 Aug 2026 11:19:27 +0200
Message-ID:  <cd4fce2cef14907ebe4713c147f8896924380e44.1786697789.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3918; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=B0hyRg6SFBi4I7J+00dwIsyuLQTakRVhZSTprV+T5Uo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqft2jybxHqf0a1w9LvKFG+VYlXe6SVBgm1L+/w zlz4nZyL6CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCan7dowAKCRCPgPtYfRL+ TspCCACYF7opJX/K1T2ZMtOngChkkQfRZQHXw2ooDb95aHFGig/MRZhKwGrdbv78HLh6q/wvsp6 wteg9r7QdAHTULqArGu+Sv0/8/vghcHVMERW7V7Fn2fHDMUssa5e5Zb1sr7atCEGoPXt5SwxEq0 Z672evxL/i0kR0by+pwTz+pPwcjLLVjnx8Adx3TEW2Fdwflrqz4GcaEdO4rF6YAvz3f0SsHQ7dV +GxPGB2Negt9yVNm6l/LYV4BnfKPwdEHEXYg+3/wmuFPO6LZPSPljPxfdjAXN6VVziSWC5642ea JGpOCMCDhe5GmSd9FpZV9dOIggUinu5C9pOXJGDShhgWjrPw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The only platform device that can be bound to the driver is allocated by
the driver itself. That device doesn't have platdata, so the probe
function only consists of a loop that is never run and thus can be
dropped without loss of functionality.

The remove function then should better not undo things that were not
done in the first place. That happens because serial_txx9_init() calls
serial_txx9_register_ports() with the created platform device and so
up->dev == &dev->dev evaluates to true and uart_remove_one_port() is
called twice for each port.

So let serial_txx9_exit() undo exactly what serial_txx9_init() does and
remove the useless respectively wrong functions.

Fixes: 0970769aceb9 ("[SERIAL] serial_txx9 driver update")
Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/serial_txx9.c | 55 ++------------------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 4ae9a45c8e3a..ef56979321b9 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1009,7 +1009,8 @@ static void serial_txx9_unregister_port(int line)
 	struct uart_port *uart = &serial_txx9_ports[line];
 
 	mutex_lock(&serial_txx9_mutex);
-	uart_remove_one_port(&serial_txx9_reg, uart);
+	if (uart->iobase || uart->mapbase)
+		uart_remove_one_port(&serial_txx9_reg, uart);
 	uart->flags = 0;
 	uart->type = PORT_UNKNOWN;
 	uart->iobase = 0;
@@ -1019,52 +1020,6 @@ static void serial_txx9_unregister_port(int line)
 	mutex_unlock(&serial_txx9_mutex);
 }
 
-/*
- * Register a set of serial devices attached to a platform device.
- */
-static int serial_txx9_probe(struct platform_device *dev)
-{
-	struct uart_port *p = dev_get_platdata(&dev->dev);
-	struct uart_port port;
-	int ret, i;
-
-	memset(&port, 0, sizeof(struct uart_port));
-	for (i = 0; p && p->uartclk != 0; p++, i++) {
-		port.iobase	= p->iobase;
-		port.membase	= p->membase;
-		port.irq	= p->irq;
-		port.uartclk	= p->uartclk;
-		port.iotype	= p->iotype;
-		port.flags	= p->flags;
-		port.mapbase	= p->mapbase;
-		port.dev	= &dev->dev;
-		port.has_sysrq	= IS_ENABLED(CONFIG_SERIAL_TXX9_CONSOLE);
-		ret = serial_txx9_register_port(&port);
-		if (ret < 0) {
-			dev_err(&dev->dev, "unable to register port at index %d "
-				"(IO%lx MEM%llx IRQ%d): %d\n", i,
-				p->iobase, (unsigned long long)p->mapbase,
-				p->irq, ret);
-		}
-	}
-	return 0;
-}
-
-/*
- * Remove serial ports registered against a platform device.
- */
-static void serial_txx9_remove(struct platform_device *dev)
-{
-	int i;
-
-	for (i = 0; i < UART_NR; i++) {
-		struct uart_port *up = &serial_txx9_ports[i];
-
-		if (up->dev == &dev->dev)
-			serial_txx9_unregister_port(i);
-	}
-}
-
 #ifdef CONFIG_PM
 static int serial_txx9_suspend(struct platform_device *dev, pm_message_t state)
 {
@@ -1096,8 +1051,6 @@ static int serial_txx9_resume(struct platform_device *dev)
 #endif
 
 static struct platform_driver serial_txx9_plat_driver = {
-	.probe		= serial_txx9_probe,
-	.remove		= serial_txx9_remove,
 #ifdef CONFIG_PM
 	.suspend	= serial_txx9_suspend,
 	.resume		= serial_txx9_resume,
@@ -1251,9 +1204,7 @@ static void __exit serial_txx9_exit(void)
 	platform_driver_unregister(&serial_txx9_plat_driver);
 	platform_device_unregister(serial_txx9_plat_devs);
 	for (i = 0; i < UART_NR; i++) {
-		struct uart_port *up = &serial_txx9_ports[i];
-		if (up->iobase || up->mapbase)
-			uart_remove_one_port(&serial_txx9_reg, up);
+		serial_txx9_unregister_port(i);
 	}
 
 	uart_unregister_driver(&serial_txx9_reg);
-- 
2.55.0.11.g153666a7d9bb

