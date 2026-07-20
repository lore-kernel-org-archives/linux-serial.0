Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2E363C7C
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549867; cv=none; b=JBKTUcXSrQD7B/G3J90/iT2bq+qEkAOtNZ3MdqVdkCyD3s4m0cu0ONnkgfipdqt4LgwXjN58HGgvf9Yec9Yi20HsZRuyR5NFKvHOQW1h+GamT4b3KS0IjJ76z25tAaoeimKhYC9lH0HmCw3ZOJSISofPhdOQTeY38t/Xr1HC3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549867; c=relaxed/simple;
	bh=SkbJXrgR+xU1f+padaMdA1xrwbQRaOF6ywd5feLMNfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEyus1ilE/2Zd9pA2vrL7qMlZco2g5mRXseSrFBhwWqk4Ohd8LMnBrsgrbR4tGTf4rzXzJpxFe+8kBL3RYabtUWGhbZF6Ml8A+YKdmD3G4ucW+QcB1yxewl+9JOWOoou7APSxOiUBuX7Chbt2R4D5A0LWlbaBIzuQTx6WQkYf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiEF0gQi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiEF0gQi"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso16821075e9.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784549864; x=1785154664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5DpeRw08IKWDnhr0WGZW/+nJYReea/NZUdpWKyEn4c=;
        b=MiEF0gQiKy1YOVAJkd5WitSn+OoCIEHXsBf6J8D4QOv7QY2f8yaujCLYz7WSL1W1hO
         UZX6gglP+7uWrsN9wSB9tk/DjpQmtZeWBBSpClgWlcvkiq8Kh4o8HNCj+w7/9BXohGII
         zdDm2SgDdkxLB2kyKN+nXAmL+uBJM0uK6MFjrK3es0ycz3yR8OUK7q+44y0GsyqLXqwI
         9U+4Cq8/CtldOy2eWVVlbrTh/R5bjHiYxMpCstob8MUU5IqnYipk2bClz9oViqq8RoGP
         ESuuKfvs5YcHQihFfBab6l/HqIhmpkzBqkiv3g8xEuvU2fi8eB45wOEMQKwnY5Ja8xKy
         YH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549864; x=1785154664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5DpeRw08IKWDnhr0WGZW/+nJYReea/NZUdpWKyEn4c=;
        b=SJnYxHXomoWsnDH96z8tUZ1fH04su4CmcnigN8bGZD75ihAzkNgemZXqFEetzyF47h
         cqIC5oUqvuU/eafv2XiMMhgtLBPy1RRHhrgyCMBieAGik2pRoRUCRQK4eqhst6yL9Fgz
         SErzRuwPSdiCuhSSI827w5fqCPZyomMAUaFwrahFRFgl+IRB7hQwBMbHpxE7LSBQwfVR
         ZS2ToI+4SF6N5AzI8btNNGVnfZrSLXmRu0TZOKBqEAlIkCqlzmgXWI7dIHirfOOPoMtK
         qZvMUAgAEZMqxjwuZudCVNmi+ZzXn0bYmNd0ujkZjzN9hDrjej0M4bW+ZTH/7OOShF5e
         JtYg==
X-Forwarded-Encrypted: i=1; AHgh+RqC1usmNkm1LKMDG8Xn3OAhTitMGzlxVt2ypRNpk1Fxv1CTZMJFzWmKwuT61DPeJuPgDViyIFxV8bP1EpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNKpyXhaKUBdStsO7QZ4stTKnEYo2yPwKB8UseS/9ljSAexby
	2CE+Fq4g9VPHQJkmgfIqyrXjFjU1xTwaXAq01sq+Cp8zxynNcIWBHOc8
X-Gm-Gg: AfdE7cnlpdfKmQvIntXKhzPVB/7NeY7bthgsisv2IiVKaYKSFT0wTuOpaXl22R3Gh9Y
	O+1A6tT9QybcWF1wBn0Ylst9LEauK6MUlH69wUFKzjcO9vDPpWN5qKZJeliGHvPM0M2BH/hLvpv
	8Xx/qmJr1cLrTwfJeS2ZHsxr7b51/WbF/kodP1g4T/JkmScNiT3MCjYy9/7wzhrpP4hfxYp6i30
	oeVOkSo9eKLa20pcCz5m47VK9Py/EV3iX3xf+K76hAc3kF8pcXKMNszyu+sen6TIXMvxwJHaiyK
	0bvZde5rkfTlcyLZJIAVmj9lWlHv+ep5S0zui9Cr2GjM9Sojn0Gw6uGz83sIxMaL9TuK4XH/NvK
	rroSSpxx1y6d/OGyQt9XrYnSLyOHb3rgzcpdIjm+2Kg6CqjdEtLPyAAiv2/BWmb83Vy8YOVBlu1
	ySBp+QZg==
X-Received: by 2002:a05:600c:548f:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4954d003084mr127437195e9.12.1784549863747;
        Mon, 20 Jul 2026 05:17:43 -0700 (PDT)
Received: from NULL.Home ([2001:8a0:7280:4000:74ef:7b69:d912:ab76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e8529sm268730355e9.11.2026.07.20.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:17:42 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: gregkh@linuxfoundation.org,
	linux@armlinux.org.uk
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Eric Curtin <ericcurtin17@gmail.com>
Subject: [PATCH v3] serial: amba-pl011: don't wait for BUSY after every earlycon character
Date: Mon, 20 Jul 2026 12:17:41 +0000
Message-ID: <20260720121741.13682-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026071036-unworn-bunny-fec5@gregkh>
References: <2026071036-unworn-bunny-fec5@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_putc(), used exclusively by the pl011 earlycon (pl011_early_write()
-> uart_console_write()), waits for UART01x_FR_TXFF to clear before
writing a character (correct: don't overrun the TX FIFO) and then *also*
busy-waited for UART01x_FR_BUSY to clear before returning, i.e. it waited
for the character to be fully shifted out on the wire before the next
character in the string could even be considered.

Waiting for BUSY per character defeats the TX FIFO: instead of letting
the UART buffer several queued bytes and transmit them back to back,
every single character printed through earlycon was forced to wait for
that character's own complete transmission (a full UART bit-time at the
configured baud rate) before the driver would even look at writing the
next one. This is wasted time on real hardware, and it is much worse
under virtualization: each read of UARTFR and each write to UARTDR is
an MMIO access that traps to the hypervisor, so every extra poll is a
full VM-exit/entry round trip.

The regular (non-early) console path already gets this right: it waits
for TXFF per character while filling the FIFO, then waits for BUSY only
once, after the whole string has been written (see the tail of
pl011_console_write_atomic()). The QDF2400 erratum 44 earlycon path
(qdf2400_e44_putc()) is intentionally different because that erratum
requires waiting for the stuck BUSY bit workaround per character, and
is left untouched by this change.

This patch was written with the assistance of an AI coding tool
(OpenCode CLI, using Claude as the backing model). The tool was given
the observation that earlycon output was slower than expected under
virtualization and asked to locate the cause and propose a fix; it
identified the redundant per-character BUSY wait in pl011_putc() shown
above and produced the one-line removal in this patch. The analysis
and diff were reviewed by hand against the driver's other console
write paths (pl011_console_write_atomic()/qdf2400_e44_putc()) to
confirm the change is safe and does not affect the QDF2400 erratum
workaround. Testing was done by booting a VM with a pl011 earlycon
console with and without this change and comparing boot log timing.

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ed91e1da22b..2a25095e8d8c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2741,8 +2741,6 @@ static void pl011_putc(struct uart_port *port, unsigned char c)
 		writel(c, port->membase + UART01x_DR);
 	else
 		writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
-		cpu_relax();
 }
 
 static void pl011_early_write(struct console *con, const char *s, unsigned int n)
-- 
2.54.0

