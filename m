Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B47383;
	Sat,  5 Apr 2025 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743828508; cv=none; b=QgF0J7cbMGDB32H7Wg4iK4J/RoH0Vk/5yX5tzVHGBw4r3YYIR1+8J76Wi5/syQYhqd9pL+zMSM7gNm7s1mwntugWzaO0nQ4sHBRq7+HZRsGCgi+ChoQ8ZRhZE0oVQ91FXUIQYl67bJxSALV98zJp+MjNyFRU9fr2U7y7jeVGvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743828508; c=relaxed/simple;
	bh=7mIr9M2omHGTkBUxaaJB3QxfmS2mOT5iUI9JQCvVPkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uY94CAqxJ/ztIYzQsQCtfVAvoVpzEGKntAU2dV5UEnmtRmHCsQo70vZTsCdxdSa7lhY1p5FyYZ6d+AtUvRvLWs1O7Z0vRdHPBLURsnCewqltSsI0BOJ/KFBAO3MTZdNaX9Crss7vQozezuEe8RJQHE6BXSWMi4G7D0rSUsDNpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRpQ955m; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRpQ955m"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af980595952so1771036a12.2;
        Fri, 04 Apr 2025 21:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743828506; x=1744433306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOkDjWl0tPtnVRw3Yhbh47uy8y4J+a0KMVbJXu1GpRE=;
        b=IRpQ955mGJKVV1QQYkX85CAmgZ+dKTw8pqUNRMgorOJerqRwarran25gtjTR74LD+T
         QXl/ZUl1NDyNOEPWd6ZAzTlrLMmE0oDCgbHSUStx80SfYdtrbEWCqwVWM9N7grNfFDlM
         dt/pekiAvyvTXMiExk9JYVUk+KQpUCRUDlak7IlmcGxnp3070DLDwkVNxZ9mhCvedyin
         NjV3OD066h889O5mPWEfQQ6GBY9PaenFQ0OomjQqrTgtmKPCV4zBSYYWghh/99nGUvii
         0AUi9MlXJLCHUJmcoglO6fQgIUQmlFWlKxjIjeJfKAPjtinhxphD3pGoyfsdpqw7lwLr
         /4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743828506; x=1744433306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOkDjWl0tPtnVRw3Yhbh47uy8y4J+a0KMVbJXu1GpRE=;
        b=ExNSwgUuTsOqElVXyiFFOBSCwfh8v/eYz20W9FGKMADqsJUp+yfHB2lgHz00XHpZd2
         Yd140jzAnNJimwUYWrBTcPoMdqhEG3WhLEvSNq9NgTTtrvOE0y5XOngEeSEXDVSlZ8sb
         /hfehFutnReQWv2h2brEctHuddhZ2oRqpcIeajWKAmu4Lgxf73/Y4t3e1hFrMBQy9C+j
         xU2p+Kfa8+xENEALFAKxtiTsGXPRm+bnD4nrqsvjFf7ryeS3uhgOHqbrchBlAwnpFO0z
         D5F67iB7RBeV+ZSP+nxWUwvaK2CvArqhawy/c0+wGD+Y+gH4VJlDU8FiuoO2slBBoom3
         pBAg==
X-Forwarded-Encrypted: i=1; AJvYcCWcZ6OGMdlW6xqn8ueGa/Rtdn1ClziowYY9sO/cBKL033EBxVYVtb75Ax2E7Kz0I6LdDZd9gam0wxfts1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTY8cYM4+P6byya1LoXePLhVYfBjl6T4FjUoBSuApXtVFv/Sj/
	seFzUflzE/Gi5aezCQg/K9Uoqbnp29Q+kH7w9NW1JFjCuBGmY6fH
X-Gm-Gg: ASbGncu2tQ2zF5BBgfyCDtj6MfOVrndiHc4MU+g2/lwldNZsFgHW7vqCW389RuZgyoj
	tSJ1xX+aT+hpKMBblys6bM9iCLOIN6m/ilddI4WTFeGOkIo5ADqEIFWQ/SAaqk2b61ErJeQdh1b
	k+mlmL5sh0AnJpL1LkUL474+OLNmPkRTgrV0r91xm7XX76V2dtjmKYV84R7Ayd0HZgieJnTb3QC
	74WyU8eDpM4ko/iTY6BwGW94bbwrp4JwgQe1SJVItKBx+gqhADNhJrz6SU8nRxkWd5vfl5t4CFV
	aEcYyGlcJB//tSUqoG+NUuWSYwEMvzOSWdEdCEuPfw457PxhVyKQhX/+NQB8DnHDHzD+sDZEFtJ
	jnKHbX1L6ks62IC9sPKkSD6MT0FfeJ30=
X-Google-Smtp-Source: AGHT+IHayKYESoyQUebzW8OHMxuspJNCiiNnavvSdkWttXkg7u4SpFb0YVtZ8myPQ+8pc7VdcOH8RQ==
X-Received: by 2002:a17:90b:50c7:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-306a612c906mr7676516a91.10.1743828506170;
        Fri, 04 Apr 2025 21:48:26 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca5163fsm5196338a91.19.2025.04.04.21.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 21:48:25 -0700 (PDT)
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
Subject: [PATCH v4 2/2] serial: sifive: Switch to nbcon console
Date: Sat,  5 Apr 2025 13:47:39 +0900
Message-Id: <20250405044739.397456-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250405043833.397020-1-ryotkkr98@gmail.com>
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
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

