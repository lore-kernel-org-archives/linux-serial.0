Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B91CD1F;
	Sat,  5 Apr 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743865184; cv=none; b=hxlzP/YRjMvhFj7BI/clGaauybUGr3hrIIi/5FMi0iVj0dO1YA6HTq2m+Dx89+wFLi27lUM25Y56kN6njaHlLme1aR7WM4qUKLsOa8BupPKCV7j5+LZI+wr6EXiVl/MROsnrK8bCxnunJPAMr25Dcokr3ZyF086XxIcs80gIkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743865184; c=relaxed/simple;
	bh=aMgVLr2gZ/zm9nchcvfQf1DOEODdM7BVtdc8Y3vrn50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rs6Ry2M+RAFz5mYU5oqhLHLxm6/lsJFHmq5XxMK74E4wL3OlhSWtCCh1w0+RHTBo24dDwN/hZzdJFQ8Ps8VlrWpqV1sCpgGBT35vaSK3s8oHSRwDrCk0IWoPpiemJGdpmPbUN7wXoFMoUuaO/goTbF9WOKn21/+J/m89pJCYj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+y65FEr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+y65FEr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736aaeed234so2472556b3a.0;
        Sat, 05 Apr 2025 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743865182; x=1744469982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U78dvPgCsVKsDHDJLPZBi8BzFbKiqAV3z5zJs3Q3Vas=;
        b=Y+y65FEr9MwImQNNNWkU5c8m5L3sBuzx46+/FBmu++xitHlr+QQOYtzgu1SQs2ndgs
         a+egQXxlKRZxDgIWTLDLji9NGNEWCGsGCwMfAdtmO8cSYPRkMZ7XTKAtmXvIkPfkYyI+
         j1ZMo8cHhm5n5WrYs4H5BNAjp5UINjH1fq2dW/Pw8oCP5B35HehiAaCb9sqXfNX0Duhr
         HQBB9yCJXAGgOuvG2J9JkFGdmoOGcIQu8qGItuzWl/ynVBy6auvizBaAXRCTsiDsiyhJ
         fvh7UCfM4so8RJQ7DCpTIRT3w8JP9s1JZ2l2GSdNiPBeYW6t/bYObzEDZ26/3Nekl2Tv
         8wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743865182; x=1744469982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U78dvPgCsVKsDHDJLPZBi8BzFbKiqAV3z5zJs3Q3Vas=;
        b=W4/TbOOH/n+r9dMZTBZdVQp8aJwcoUu5Nl30dnbQIJvtYa5PpklxL8nd0U+k5JT9H4
         54zb0Lf6VMqnTaQalyqwYCdNxrprkLDwAGDDQqxv+0UtOSEqJCQhMBhqLsGTHNM7UYzN
         N3OaRh1xINAoNcKUM1nm8KpxrwGssqcjMxJHQEF3vWqUVUPCaVXHFh1JNYEpwK9umcxW
         Yg7Jd+uv03mDAN+XBbc741spFmAPxRB6nv7qdVOroGQiSA0hPzJ6o1X3HLIpE56Pdgvv
         5VGBNeTkEUENilbT9QD2j/b3V4ItmoWkiiV5qSmSVJC2dvY620kraPWoMUZ+FbwEy/L0
         dMHg==
X-Forwarded-Encrypted: i=1; AJvYcCXc0trmI/SD+KDgIndGFrYFuk54n2hMWp8miKMOAmBQYFCfgTAMoNZEgyTfURP3pYWugbIyB71aazRB54o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90YFQQU5/edD/kjcu+YOxwIXh15XczTlaR+EN1VDSxu+fvNLP
	dv8ymVFNcIUel+T3lorvInnaF0eNWOuKnDdAY9Sfd72L3r8iHEGn
X-Gm-Gg: ASbGncsox4xtqyClqsYNZBXHRJeJkU+q6czgRbjgrymj9024CWrcM/8q57sdf7iHsBG
	RjY4atysGOf12AEb0MxsAFEy+ylWKu9Jb22X9Xorhec2O65QbmYVqivqAHN4Hy8hEBAo0g1JVH4
	x2+fF8a9yIOEkWg/ycUUfKQT8jEtyRuHTVToQFkjOlD1/yXRyl71o7IKWZ8ZSc2NbI/umvwJuVU
	xbmMxSxUs6exsuzytBE+Uul7G6AzGHDTM6lfkxaUhae7JO+y3epfT1gUW0X8t1Xj6Vstu0AZt+i
	f/w0Nsx7G148Zc5TN7UgsPCr3e4H7A5Ddlk34g8dJlhGb3SvsrCu0eaZOdlXyJFMEwxPUcQQu3C
	Lc+3WfJA3KuuyT5EnJdWy/F0nfQC7LpG5hTX72SB/+w==
X-Google-Smtp-Source: AGHT+IEIfr1PeRtQ/aHXxthPr+Pi+Ht9Cr3z0rBJ0mKi+8MkYMU1eZES+TqJkWwXtuflwGedDx7QRA==
X-Received: by 2002:a05:6a00:3a0f:b0:736:4e0a:7e82 with SMTP id d2e1a72fcca58-739e6ff6b10mr8332137b3a.10.1743865181802;
        Sat, 05 Apr 2025 07:59:41 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0991sm5497003b3a.106.2025.04.05.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 07:59:41 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v2] serial: sifive: Switch to nbcon console
Date: Sat,  5 Apr 2025 23:59:15 +0900
Message-Id: <20250405145915.493173-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the necessary callbacks(write_atomic, write_thread, device_lock
and device_unlock) and CON_NBCON flag to switch the sifive console
driver to perform as nbcon console.

Both ->write_atomic() and ->write_thread() will check for console
ownership whenever they are accessing registers.

The ->device_lock()/unlock() will provide the additional serilization
necessary for ->write_thread() which is called from dedicated printing
thread.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---

This patch is once again sent as a standalone patch for converting sifive
driver to nbcon. It used to be sent as a part of series. The related fixes
along the way can be found [0].

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/all/20250405043833.397020-1-ryotkkr98@gmail.com/

---
 drivers/tty/serial/sifive.c | 87 +++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 054a8e630..8f7f770ec 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -151,6 +151,7 @@ struct sifive_serial_port {
 	unsigned long		baud_rate;
 	struct clk		*clk;
 	struct notifier_block	clk_notifier;
+	bool			console_line_ended;
 };
 
 /*
@@ -785,33 +786,88 @@ static void sifive_serial_console_putchar(struct uart_port *port, unsigned char
 
 	__ssp_wait_for_xmitr(ssp);
 	__ssp_transmit_char(ssp, ch);
+
+	ssp->console_line_ended = (ch == '\n');
+}
+
+static void sifive_serial_device_lock(struct console *co, unsigned long *flags)
+{
+	struct uart_port *up = &sifive_serial_console_ports[co->index]->port;
+
+	__uart_port_lock_irqsave(up, flags);
+}
+
+static void sifive_serial_device_unlock(struct console *co, unsigned long flags)
+{
+	struct uart_port *up = &sifive_serial_console_ports[co->index]->port;
+
+	__uart_port_unlock_irqrestore(up, flags);
 }
 
-static void sifive_serial_console_write(struct console *co, const char *s,
-					unsigned int count)
+static void sifive_serial_console_write_atomic(struct console *co,
+					       struct nbcon_write_context *wctxt)
 {
 	struct sifive_serial_port *ssp = sifive_serial_console_ports[co->index];
-	unsigned long flags;
+	struct uart_port *port = &ssp->port;
 	unsigned int ier;
-	int locked = 1;
 
 	if (!ssp)
 		return;
 
-	if (oops_in_progress)
-		locked = uart_port_trylock_irqsave(&ssp->port, &flags);
-	else
-		uart_port_lock_irqsave(&ssp->port, &flags);
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
 
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
 
-	uart_console_write(&ssp->port, s, count, sifive_serial_console_putchar);
+	if (!ssp->console_line_ended)
+		uart_console_write(port, "\n", 1, sifive_serial_console_putchar);
+	uart_console_write(port, wctxt->outbuf, wctxt->len,
+			   sifive_serial_console_putchar);
 
 	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
 
-	if (locked)
-		uart_port_unlock_irqrestore(&ssp->port, flags);
+	nbcon_exit_unsafe(wctxt);
+}
+
+static void sifive_serial_console_write_thread(struct console *co,
+					       struct nbcon_write_context *wctxt)
+{
+	struct sifive_serial_port *ssp = sifive_serial_console_ports[co->index];
+	struct uart_port *port = &ssp->port;
+	unsigned int ier;
+
+	if (!ssp)
+		return;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
+	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		int len = READ_ONCE(wctxt->len);
+		int i;
+
+		for (i = 0; i < len; i++) {
+			if (!nbcon_enter_unsafe(wctxt))
+				break;
+
+			uart_console_write(port, wctxt->outbuf + i, 1,
+					   sifive_serial_console_putchar);
+
+			if (!nbcon_exit_unsafe(wctxt))
+				break;
+		}
+	}
+
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
+
+	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
+
+	nbcon_exit_unsafe(wctxt);
 }
 
 static int sifive_serial_console_setup(struct console *co, char *options)
@@ -829,6 +885,8 @@ static int sifive_serial_console_setup(struct console *co, char *options)
 	if (!ssp)
 		return -ENODEV;
 
+	ssp->console_line_ended = true;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
@@ -839,10 +897,13 @@ static struct uart_driver sifive_serial_uart_driver;
 
 static struct console sifive_serial_console = {
 	.name		= SIFIVE_TTY_PREFIX,
-	.write		= sifive_serial_console_write,
+	.write_atomic	= sifive_serial_console_write_atomic,
+	.write_thread	= sifive_serial_console_write_thread,
+	.device_lock	= sifive_serial_device_lock,
+	.device_unlock	= sifive_serial_device_unlock,
 	.device		= uart_console_device,
 	.setup		= sifive_serial_console_setup,
-	.flags		= CON_PRINTBUFFER,
+	.flags		= CON_PRINTBUFFER | CON_NBCON,
 	.index		= -1,
 	.data		= &sifive_serial_uart_driver,
 };
-- 
2.34.1

