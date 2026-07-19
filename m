Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84BE2E738C
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784442995; cv=none; b=rAyp3qnzEC4VHK4J+/YIUErv2FzOxXf7LrWZS9wgqV0QDPHcdg90gDQvoft0nBmvlIQ3a4hIjaNpLPN0S0I/UU+PtFqWylhZj4sLMzei1E80IMlLsB2Xoz1nQCdejauIswbuiDMr+XJRpSoL4bpDKhE06anRSryOnb1x/D+Mho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784442995; c=relaxed/simple;
	bh=1xGW+5OPXtzQAk5+Pyyb09mDv2qTxs5kQSXDGy4qmJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMFS+G9jL9azQB7wUrO6LZuhDpUYps7Kx7DuUw7LtTZ1vb+IBW6TREKD8BcuZa3z9JyE/7s3UZOFqrhiVLTYSZJ7vnloIkagd/TrlXF3JcdNXMEYGVVNw8/xJTRJZJqhmwA31Sf8F9G9PWOTzWdNILS7z/cjob4fUSJHt7eV8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMyAYIYs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMyAYIYs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso6506595e9.3
        for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 23:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784442992; x=1785047792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cxs6c/h7vM3D54wuYMS02bOf2z2hWYR7//TmGe3XwKk=;
        b=AMyAYIYs4SuRsaKaJwu16VZ+pG4F999MQ8PGurcXHE+Bo3SGI8x9xwXJaaiAQ6lOkO
         MsCjUSxNbYsuxUeGv4yCpescEvZxGtpByRFOpBMmWs6LDoxDHiMi45XbQV9XGtpZYq0p
         Xg9r5TsrFJegDZbZ2cLZQYP9AyzTJIrcJOWPnXMKU2iH8L2YcWK6OOfMERuXF6wOGt1d
         NUnZBuY9vbXvSCd/CSV1eF1F563FuDnRZ+Lzutmth4xhz1R84oEFEi4/C529HXMFbFmF
         kh61bOExxIOCoP1Yvpyn2v3gE+1AH7JvrKfrLug29cL5LXy98QJB+o/CXkubTBL44dU5
         JbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784442992; x=1785047792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxs6c/h7vM3D54wuYMS02bOf2z2hWYR7//TmGe3XwKk=;
        b=oemvHruGfo1CUXrAzCCa0nxiEovKEb6KDhmc5enWOgGAitr3tMmp4MZOat9If38yn2
         PGOg3S8XoVm9vaPBdl6oKAWxlXWzB8Ly0k4hJcM5k+y0ay2kh+PdEy2y+OqlldGJRJ8y
         6gFtLemFyqlbvMDnWfad6pgrzF4J3KNDpOJWmOaJN+qxtI22nuEoImUJJUwCmTZyCNos
         JfYm/ViLIoF7S46fGM5IsW7m9lKr6EChHg2Za3YWa3cwvwLSGpz2bdsJsicyN3GhiqxV
         RH7IWLG8wboxPdP5F4ZkGGuD5Mb4OPFRNtOFO86O4gQyPXv7tiAmCS0MIMahZ7KQRU+L
         ZKkw==
X-Gm-Message-State: AOJu0YxnYJT3WQQxTnf4Pn800e+BoEr/GxyAoqtz/O0PA+J1NH0Ngc94
	R8J0eHwSksNdnh3lyDad6wAz3rCTuvRGxBeicBSueGfT0tzTWp/nB3S9
X-Gm-Gg: AfdE7cnJrXYhOD+rmsKZxudQ6ck4IDGOpjinOTgjzRIFYozujbBacjjukbu5MloCgCd
	GAndTiFL9coFS+/7jYkSIrPalPaT5AqUCvLJ7q6jsn9B7llGiAHlNwSzqcisejWWtXwf6z1R0jJ
	c2wfkFqCyim4nF6/ekFHwJtbyWNK9pALkEJLTjgRrFdOyDTk2mO/kROXP2QNiksFx5waD+b5BkN
	gEDD3YyAbrAFlyz/pXnHGHq6Nbfub8VyQLK4F357bmrf+ksTim4L7nWdnQu7zuITy0DMLxmfY7p
	g6C1Qcx3Fjv1DZ9Lx+FDoqAHTedasZHAQ48i9cvamQthnJN2A6zokddOGPIEDYRchvnmnBiIwZP
	nvKdNZhWxlOPwmd5X2eMPEaFOsCDx7zGgnaMnuaUtuXRGXBTBZ2wdIbFYmh1pg0Eye3mErRHHUX
	v8jap2K4q4gu41tAJWxmyu3Pl4FQ7sPTwWd07OO8WztGJ5wS6Eflkqj7y7jsFuPxAqji/toMG4W
	IYHZXLsDkCWUmLkXmNJicuv1pFC5rPgZDPIei0=
X-Received: by 2002:a05:600c:5657:b0:493:f442:3dd4 with SMTP id 5b1f17b1804b1-4954a516af8mr59398075e9.39.1784442991787;
        Sat, 18 Jul 2026 23:36:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-018-194.77.7.pool.telefonica.de. [77.7.18.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96f19sm193053245e9.9.2026.07.18.23.36.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 23:36:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 1/2] serial: amba-pl011: unprepare console clock on unregister
Date: Sun, 19 Jul 2026 08:35:01 +0200
Message-Id: <20260719063502.18852-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719063502.18852-1-kmehltretter@gmail.com>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_console_setup() calls clk_prepare() on the UART clock, but the
console provides no matching teardown, so the clock is never unprepared
when the console is unregistered -- via the sysfs "console" attribute or
a driver unbind. Each re-registration prepares the clock again, leaking
one prepare reference per cycle.

Even where preparing the clock has no hardware effect, the stale
reference leaves the clock framework's prepare count unbalanced. On
providers whose prepare operation enables hardware, the leaked reference
may also keep the UART clock running after unregister.

Add a console .exit() callback that clk_unprepare()s the clock,
balancing the clk_prepare() in pl011_console_setup().

Fixes: 4b4851c65d92 ("clk: amba-pl011: convert to clk_prepare()/clk_unprepare()")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The i.MX console had the same missing teardown, fixed in 9768a37cec37
("serial: imx: disable console clocks on unregister").

Measured on QEMU raspi (bcm2835), whose UART clock is a real gateable
CPRMAN clock: recycling the console via /sys/class/tty/ttyAMA0/console,
the uart clock's prepare_count (/sys/kernel/debug/clk/uart/
clk_prepare_count) climbs by one per cycle -- 2 -> 8 over six cycles --
without this patch, and stays at 2 with it.

 drivers/tty/serial/amba-pl011.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ed91e1da22b..1aa43994a3cd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2552,6 +2552,15 @@ static int pl011_console_setup(struct console *co, char *options)
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
+static int pl011_console_exit(struct console *co)
+{
+	struct uart_amba_port *uap = amba_ports[co->index];
+
+	clk_unprepare(uap->clk);
+
+	return 0;
+}
+
 /**
  *	pl011_console_match - non-standard console matching
  *	@co:	  registering console
@@ -2705,6 +2714,7 @@ static struct console amba_console = {
 	.name		= "ttyAMA",
 	.device		= uart_console_device,
 	.setup		= pl011_console_setup,
+	.exit		= pl011_console_exit,
 	.match		= pl011_console_match,
 	.write_atomic	= pl011_console_write_atomic,
 	.write_thread	= pl011_console_write_thread,
-- 
2.53.0
