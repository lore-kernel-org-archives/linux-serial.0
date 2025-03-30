Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC34A05;
	Sun, 30 Mar 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333700; cv=none; b=gjiGYHZ2g/z/RyioJXUfUuLnJwif14xVLgXZRaw/La/pOW1i10Xw9S1Z8QxvESWC6WM7HmzcMianNRegwkL61BeybuTOVLhRNVhvtcDnawfJE6vsxmS/tcMoIYVbqVl8W213Idq9wf71wvxCHxFfzr01Bo1sQfARw3SYmBHPrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333700; c=relaxed/simple;
	bh=aE1PF5WLy33Y8t4F9B7ciZ8sDuqyDOI9Xc97DhOEnz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqKQyaGeg//F5feiEr6sxesdQMMS6NBnch7Uxaqf+JM9YGwV8shF/54jwNQn0XDeJRz2lPWSMQfe8iJ/jorEfLTGIP/cescKPs+zjb/vy+e6lsg/AyO2vlY+LQpIACJmFxxKQyntEqWlxlZQhdfCnuE2AmtZv279s3wqPDmoyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFC9yGs9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFC9yGs9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22928d629faso33900895ad.3;
        Sun, 30 Mar 2025 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743333698; x=1743938498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMZHL0UOoWagu8ugPnApvJFimUNmRJzmGaDhx8HHglA=;
        b=PFC9yGs96SF1qlNwVcNWtIbHJukIpKi2JCDa6Ly3PZbfc9MxeGny8sdKuZQzv/bBC7
         vrPeG2SwBjlMEYMNXbqCiKhYe7g1I4bH6fSvCAoz8gmI8v6CHTCtW04MPA/hpK7muTnL
         cK43Tq2PvRga7jZpUgr97NyHia0frgUTyeckzTupCcCgncZ0xSRwHFbfM23pGxXiMnPA
         cBxTjXL1A2u+IDSuyBETS6HlqbnVvLiPwxCiANZW08dOM+8iL54M0U1hQpVDqJ3ispjS
         SZJVOdvFP27nDLWTCp/JX/z704nGyN7BnjBnINCeHf5vB4+9JbXP7aGz1U4AxOq29iNF
         EeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743333698; x=1743938498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMZHL0UOoWagu8ugPnApvJFimUNmRJzmGaDhx8HHglA=;
        b=g8wmYQf5tMSC3/yXTKTxss5Hf6ZpwmW/Ds7v+u4gZ47jpLFInBtloGsae7wVxDkUXF
         XrdNUae5j45GUTyNjFHdsdeHEYn4Plng7bmSsaBPD9kliC2jQX7q1jn9/+vDG3ZV1l9k
         AFZs1IAnq6Uskih53VAGRT5Sg2AUyun5qGUnXTsWU6YS4Kv86A+UtAtGmSu6re40uXnV
         JQpjHabi4fBxUuv1Uj8bY3SEqPIjhNh/u3gAeZih0456FZFyoLxStkrOdZiXJ5370JqY
         0Sot/boZ29RMGiNbuTvdswbRIeqMOX0eJ9iStxtIpml+hz83tB25of7sS/5xzazo8OXY
         gRDw==
X-Forwarded-Encrypted: i=1; AJvYcCW7q1NUvNa/fonmH95SE4OByPhmeEaE8+oulL+KFWpGH31CvQX43NgIw8isqq9cbNEeW2oUS6SyoST96jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62k5l13d/NAojOP+0wY0Qb3aguoFMojheB6vXw44qZdnnW1i7
	7gwR06NNi25Ex8qONPZ0DVSg+cpRP590WLHTJkSK5KkkDj7mC7Gq
X-Gm-Gg: ASbGnctbb1oWy/eqVXdA7xGWYW0F9Pri5x0VX+ad3y7FHMDl6ZaPfmgzn98yJMhS/eE
	GtNvJA2i9x7NFg6CS7NlcdSIEPfGRK/D9hO7YgyzEUO8w1iLjlTnWRZBi7rbaK20lJwCEjsEwa+
	wJZdYJRDD6yU0iijOACT1HKBFhUIDw2PEKbqXlr/aPyMphd1XZKgKDZi8b0ooH2TcBVR+sFyNnw
	j0xX84iSkPsUpToICvRt0qhEUWOEYtMl+dWpno5/4VLcYEIVHmhYppms2CwEgsX2X1VEFFzYxdC
	7TbBsHkm2XKgmRoxYKQckgQgyx9XzmsGCFensQ9AFe7DIjXT/8AoJWV8ndfCdPW1oJJ2kAgztRj
	ow7jhlW+fvQF2fGuYBM/Y3FOUwHGOizNi84mGdZbE2Q==
X-Google-Smtp-Source: AGHT+IH99+PhWGohVfsr72uKeMhi0Xw9rhOjQI/S3ZcNcnEaPoC4XzXMs6Rq7hlk5w+0eNCUsKccYw==
X-Received: by 2002:a05:6a00:194a:b0:736:6ac4:d1ff with SMTP id d2e1a72fcca58-7398032c2damr8985734b3a.3.1743333698173;
        Sun, 30 Mar 2025 04:21:38 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970deefe4sm4997845b3a.30.2025.03.30.04.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 04:21:37 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v3 2/2] serial: sifive: Switch to nbcon console
Date: Sun, 30 Mar 2025 20:21:09 +0900
Message-Id: <20250330112109.393526-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250330110957.392460-1-ryotkkr98@gmail.com>
References: <20250330110957.392460-1-ryotkkr98@gmail.com>
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
 drivers/tty/serial/sifive.c | 87 +++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 054a8e630..37d5820af 100644
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
+	return __uart_port_lock_irqsave(up, flags);
+}
+
+static void sifive_serial_device_unlock(struct console *co, unsigned long flags)
+{
+	struct uart_port *up = &sifive_serial_console_ports[co->index]->port;
+
+	return __uart_port_unlock_irqrestore(up, flags);
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

