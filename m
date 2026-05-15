Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3444E047
	for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848886; cv=none; b=Wh614ldbt3UnKuwmlo4xz6Bmk5sZH2T5F1YnsEyhOQInfBg4bWvuBCxvwozNTP/+WuBPzlL+vo0OEyxQVqoKVhO6We8bVJI4UuqVhuKhMBmmSWe7xDZAx79nGYKwwQ2lmrMcpLO2qSsVvD7V6s7vKrMrN0upvklO1KVBnm3/n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848886; c=relaxed/simple;
	bh=7TZ5vcA+GLdk6E7fGnm5v0lehUpocwQ4ZVzCnZFOHkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XjSsgvQJOEtWERRO3+dvs/wgKTJ7KZx32j1PwGO5wQwYsF0No1cKscob3yrF27l7EntMmP7tRgxQUf+u4Nba2uqlUDBu72d1d2bqFudMwfzhutC0SieG/f6cSiwYfKuVXYQpSrqrc33uaLgXrGvdmKcYdugRdNM2rPOPYWg917o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sGFycZSK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGFycZSK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488d2079582so91980175e9.2
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778848884; x=1779453684; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFHLfFog5+tJEOD6z3uXuJEqumNcdwRPWU/fZudPyJE=;
        b=sGFycZSK/yj9Ii47pbKAxiJsXnlz0zISKj5li3Qr0KJnBPVc8qVGTcRmnms051ZMfL
         xQe0eIux31D5e4lPG/ab9DWOCTUutJud16sFMFeAw2FGAil8X5c1azQLaN3GEtqVtGEz
         mTYoZhnLbQ+fJHVb7SR1B4PgjJudK2JDVC5PVFOhP3vmXDrXOKhJpb1BwL9rZEXaBt3F
         gg98IIim+FHn8ZFNbFzaNK0co9KNvvsVWYBTAAQ8wMsUu/gDdcIwZnzynRnQyPEC6sPF
         Db7Wm7d3ZNuopSiPkcFHHYrRT/rPRrZZMakywjnnVbZTQWzSbfWO78zLb3WA5YVJXLpK
         8VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848884; x=1779453684;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFHLfFog5+tJEOD6z3uXuJEqumNcdwRPWU/fZudPyJE=;
        b=Yurm5OjIMw+nOPnKAHIGt8+bgccx9YNIFHLSUNBEUWicYfcMB+FNuUtXYNHGx4TAML
         ZoXiHyMcZAQpA2KoNKAivrYYXkxmKiStkqM71lAo7xRNAVdoSH3k8da1ZSeb2xzWapN/
         Dxj8HXQpMz1wYkR3nRIdyF0cGdcPBc/GTvGPEfxkvJmgB7ddG2kHBvW2IJrH/4ZjzZO6
         0SzaVjCM31+JbLYWShQNlkJMpY+NzaVvj8PbOR3g79k1/2buET64TaTOJ/0q/zqElLAg
         LIBOrsJ4UIzFLjKAClFcfCCXew7HDz3PEM1dLznD01lhIACwB4/m2BjeKGIwodBeEuG/
         gzZA==
X-Forwarded-Encrypted: i=1; AFNElJ9koPzKpR2oxXkBRJcaDuOxb9EZla6YiEJAJNnFxkLS++dGot5at+NHISYutwxxITAzwHbaSQ9g/WoqT2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uy++Pf8w0SP51Ql2WiA8u7r2bDnbJTHb8taThUXK3NtXdQk0
	tOx0XunUvxls+VCcABwBT55B0gHPB6yDDUuQcBIpzDOOI/V37NkbE/YD69C4nC1M0I8=
X-Gm-Gg: Acq92OEDg4PH7pjG/GeZ2zDRz2jfKG9YsBhwhsxPbPpIfZDK5ByVPI45SgFS2JtDIoR
	KGxvTOd9NkH84YYZnMjotaErywEJWtvQNmbmUUS8YR0n1DpYITaDVf8fmRjI5XTea9MyE6K2Rti
	SmisiBwYI/y6yBLmKN7sb9Vt58vWGN0Z8rGMzYysW43Xa36onhAFVxudFKnRIryA5Nrg+7WC27I
	O/kl36RrsH7P3uz5AW8C51PJIGF08o0LtQ6UJkYNy3HxZNLqcKuT7FBBjC2ayf7f5J7E6w/yltU
	VJSoUHxf00ySFey5ucrYeMPKoFZ/xR4A66Dym2aZnfJVRIZjYocJBVFGsUpdhkh/ECAGfWiNhLZ
	J5N4f4tkKE617tP1Ao5MVQBvZfbIu9jp0kZytRopxNxJWXkEWjIw7Glft9Z7z5MgFGCGru5zl4a
	o/JkVVW3BhxZ5or/sENG2aCmMUWGUdBFH7bnOOAr2SyMrpIQ5XkmU+VSj6uiEFaOthJLI4xxd8v
	/H1J4mzWc+vovozkA==
X-Received: by 2002:a05:600c:a309:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48fe61f20a7mr44622645e9.15.1778848883620;
        Fri, 15 May 2026 05:41:23 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm15154969f8f.35.2026.05.15.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:41:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 15 May 2026 12:41:21 +0000
Subject: [PATCH] tty: serial: samsung: Remove redundant port lock
 acquisition in rx helpers
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-samsung-tty-flow-control-deadlock-v1-1-93255edbc9bc@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHAUB2oC/x3NQQrCMBBA0auUWTvQCW0FryIuYjKpwZiRTKqW0
 rs3uHyb/zdQLpEVLt0GhT9Ro+QGOnXgHjbPjNE3g+nN1I80otqXLnnGWlcMSb7oJNciCT1bn8Q
 9kfxgJjrTPQwErfMuHOLv/7je9v0Am3DCl3MAAAA=
X-Change-ID: 20260515-samsung-tty-flow-control-deadlock-1d426171bf41
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 john.ogness@linutronix.d, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778848883; l=2912;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7TZ5vcA+GLdk6E7fGnm5v0lehUpocwQ4ZVzCnZFOHkU=;
 b=HSB610k4svdM7RKtaunGgLw3+2VSD01p4S4EygS9OUnKmnC03b2/KyWCaywVndUgAybnnLZpV
 Iy911zmNlEdB3AXvSJIjtzoXHQPpTK2gU4xSiY6C6ROJ3/zU5kryg5R
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Sashiko identified a deadlock when the console flow is engaged [1].

When console flow control is enabled (UPF_CONS_FLOW),
s3c24xx_serial_stop_tx() calls s3c24xx_serial_rx_enable() and
s3c24xx_serial_start_tx() calls s3c24xx_serial_rx_disable().

The serial core framework invokes the .stop_tx() and .start_tx()
callbacks with the port->lock spinlock already held. Furthermore, all
internal driver paths that invoke stop_tx (such as the DMA TX
completion handler s3c24xx_serial_tx_dma_complete() or the PIO TX IRQ
handler s3c24xx_serial_tx_irq()) also acquire port->lock prior to
calling it. (Note that s3c24xx_serial_start_tx() is only invoked by the
serial core).

However, s3c24xx_serial_rx_enable() and s3c24xx_serial_rx_disable()
unconditionally attempt to acquire port->lock again using
uart_port_lock_irqsave(). Since spinlocks are not recursive, this
causes a deadlock on the same CPU when console flow control is engaged.

Remove the redundant lock acquisition from both rx helper functions.

Cc: stable@vger.kernel.org
Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
Reported-by: John Ogness <john.ogness@linutronix.de>
Closes: https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2f94fc798cff..63d0232dffc2 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -245,12 +245,9 @@ static bool s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	int count = 10000;
 	u32 ucon, ufcon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
 
@@ -263,23 +260,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	u32 ucon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 0;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)

---
base-commit: 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
change-id: 20260515-samsung-tty-flow-control-deadlock-1d426171bf41

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

