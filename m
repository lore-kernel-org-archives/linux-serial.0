Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29AD445AE3
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833909; cv=none; b=ap9PJBrTWtVMCPgbQumYnyAozcnw7CFBy1QN1hDlhmD/bc+Qt82TzJeIIpZ7p7EXgIsS/z00hdA2VulwpRl/AF5SDjzyIIKNlpgkTmCN6YV/bgBkhTk91oBpKMZVv7hADhMPHf/QnoOAhcKuHbS5UblI8zojYn0YOgHtnXIseGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833909; c=relaxed/simple;
	bh=71axuqcdIWYyzTSqeq7Ho6eKIQvZa/VH/yJAtF1pi4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnqggI2du74pw239lrEuTqk4WDNXZTmDQZCwChT9lbHciGicahAmUVvO91KeUE+SYufLiu8x3hwwbWJlvg4OvaS4rToUBozoPAbsWFGRjMJKwPRNEU7wIbmL62awCqR+dNri5FQ+m2UsICsJL4k2eh9Qoy97olSr8OhXbJ9rmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=grUTPq8S; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="grUTPq8S"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso19539475e9.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833906; x=1786438706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qZlncH+fc7Qjn+MG/IiL0HUtec9ZDNYqZDynW85gEes=;
        b=grUTPq8SXzE0DSQkMMfjkwqLWgrPiDNCySqTCAHGEX664eP/rIpQJXUrHJ6dxFPWLc
         t/uvZlsyaMvE5XckmIhwj17ClVhbuhKN7Sqsr+OpEcnNVOW3XmBTTWnpidD7+jAzy6hn
         vvjo29Q/YkHjk6lqgSciq9trLyCs/Br3jH65j8hkYQuUFxE00VMCDaF0glTD694hJuVK
         qKrbwAZXCzedLCUSA7CL9FibQ/oZBXG9HfxxtBcH7dWf06Qww+MnDQ7uZpR+/xw3Sg05
         5ExJ1OP+k1xDCH/Wm/mufq2OkI3wvpq7Z5+2eQxVYCoCVjMO/bYBqu6avgxwHK/3udpB
         hhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833906; x=1786438706;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZlncH+fc7Qjn+MG/IiL0HUtec9ZDNYqZDynW85gEes=;
        b=G+UPoccDHboXJWnAQfPz1ENfWRL0HJ9LgjjcbltFzwkaazA/57LgpXpFkMt7KjTbVN
         4szEgqwBoHx748FJX2tVfg3Av6jq9ljjxVBsnK8PqjQeAw7ylrjod+A+8ABxlqXgovA9
         R0FJOePZHQQ5QI26VO4OjCI0YbEFL5e+7zCCSPcBttOnKnHfYeYWtnltTSJUwAZ6rFcL
         nNa+fjanPUTiyTjvhaaRN4yxSe8k+gqztOI4VIBIctvnDVkJdxnmciv1x1lTXwd49+Wt
         OBqZqG0FpMTUdzKUPT5aWtCWXHptwQrU6VqYFjm08GIHXZS+ttIexcj/FFvVZWXELhKd
         H1HQ==
X-Forwarded-Encrypted: i=1; AHgh+RqG1V2JqwGaPY+FBSculriyjYp2fwnYr6KRdvOGlpHax01RJLqFJr7KE/v/MtcFMz7eAm4G4/GTNQSRAqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZB9XPPCsHboJ1AAWsWUOWDcZdHEjDp6BVFVKfFwyz41/zYKF
	Oks4YvgDXFrGBquaxC9xppdOMQroxN5b47g5SDg86qslpDfZl04Xe1R+vR6G60zblq0=
X-Gm-Gg: AR+sD13gYCv9D7R+aNS+fEkMtJNF9k2zKYTfaBRoaPB81HC/0ANJ0CbigeBtdp2gRh+
	ATT4FuPgtyCRZ+ISRSsdempD/zeG85U4waP5IT7N4J/fZlgaa1ecgIxmjH1GNkBmTV+S51YBrB/
	fxXSGbabGQcstiRG/D0Tswt2hqTKewVuRFc+chXFZBd2BJSFx5VqgD6nzJklv+UOuULCN1D7jWC
	3NDuVaUGg3nkRwBV2TTccdCwf15Q6jo1xA0ti+uzxvejLem0ExTzuvL9rpgMopzaaCWJqg+5l8W
	7uzsIGSBjCYTFe6601zC5whFReYD/sHW9v+QHIIFdMwxbFTuPDMvdAjo2oSrxAT675W8OT2Aol+
	ZjjCRvZMfleaTna9v3Z/8bHzS8i1Sxh//sWi1FSrzzohtlLLgRhxuHmPQGgRngaOzqp9vNG6gFo
	uctIdCeTsfFuYKBvYhHU1u80VsQjto9//9ioFf+6suGwe63y3c5ElWVnORkAGrpXrmZ7KQxsTE7
	32GW8fY82KF8ZXg7PwLzvslxutMdW+Z2eNEvxMwjcA/Dx6pOBoFWl0bBXdUPpI=
X-Received: by 2002:a05:600c:19cf:b0:496:bbce:fd with SMTP id 5b1f17b1804b1-4980c66c73amr312828585e9.6.1785833905661;
        Tue, 04 Aug 2026 01:58:25 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49949fe2f4fsm80024315e9.10.2026.08.04.01.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Alan Cox <alan@redhat.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 1/8] serial: txx9: Drop noop probe function and dangerous remove callback
Date: Tue,  4 Aug 2026 10:57:53 +0200
Message-ID:  <2165469758f26f79c0267386bc6cd92379fb0e2c.1785832297.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3747; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=71axuqcdIWYyzTSqeq7Ho6eKIQvZa/VH/yJAtF1pi4Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcamUBn9d6xxzHZR29Wzep6BwAsgONGRDSv6dv JzcS96Gb1GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGplAAKCRCPgPtYfRL+ TtrSB/9HfkwZiuuKjzYm3o4SLkH6gd+MsJayTzE3p/ymmYqLKJMLN87mxU4USYadZWhBt+zQzRz WmlxDjLM+sJ16dteRlyIY6RReOr1VK+OvW4VrU0dxmD9LCgot1HbWKUcuCFaoL54DhIF3rFpqVz vdFBemEc7Vjq3xEspLiIR5vb9CdF2qs0SueY3HVoN9DuTY47qlUQuqmgXydOwIttpeXBdP3ZWpV fr7MmJvnbFQ4/kCYQTPbb6F+gB4LpJCAA0m+6fwKSvXj6fKR9Y5gLQMPuM5hig59vETVDMH+JTg yBC/3svog1Bff0WAz69VSWfufwnVIMdkyPY5jbB6V3N73y8J
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

