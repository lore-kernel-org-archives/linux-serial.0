Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0A1CD1F;
	Sat,  5 Apr 2025 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743860129; cv=none; b=kMe7HGSf7uggCjeicY1ZSAcb7BdQMy15IeUJ8LowOH/PBYRxcx6iZqAkqG4cmi+aLSYLP8aXQhGMcNO53YZ/wOjcux42D/6jzTILHe9FbxjXgiyfxueArPL2p5eqKD8JvHDM5FMwBu4YE5vqmZ/OEsnQf3hTVlAI8Rw9DI9+ANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743860129; c=relaxed/simple;
	bh=H1fG2Pxym03Drj+wWFznLo89g344hOJZtWpctlqIg+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1Ee15c0XuWL6GipKZdfuXUYHre9GDqXO2SCPc3RbB+uDObfu9j6+RbqDayyeaobWrSQD4Dv7f+0vHyLshwvJAChOo1GmIZF6BAev8wJ809SzBLor3gfVhRBoHJK3rq3jCTMqy0rQDZagP+2AFHbVTWWEw6cKJjPdgvqRfptAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Actumepu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Actumepu"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af6a315b491so2591195a12.1;
        Sat, 05 Apr 2025 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743860127; x=1744464927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FQzVHvUxHSJNU/i0CyWe43dg67CKrHYWlJYSIJQstY=;
        b=Actumepu3ZeqUCCRCHg6NwlRZsalypJSdG2MwfvKz9Uk9+utlvrXaL5DH2FUzgxLgn
         Auz122WkJ1QjaIIWgu8cdZ+ZZ4uJIHpzlVKspCpBNYCOJuIwjCFp21YbM/O+H2b8iRLY
         uRWPibGhjeVYBFJbEs/iBTPe7+rx2A7gHsKbbnEVkYVk/M9YnaDsAH2N7zxoZz8qDm45
         Df7iTjFhCNi+XgtUs8DsuAFtKW2RrgWpmgB0luzoZAyQG+m7GRmeDyf8As7Twl3Ipfof
         tiL/lYi7kkmm66pZSFQGfMdEhbEHqcpmlMpILkwILy056ScgVbZFpYJioRagfD9ws/M8
         d5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743860127; x=1744464927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FQzVHvUxHSJNU/i0CyWe43dg67CKrHYWlJYSIJQstY=;
        b=WahLz64d5ncG5NuUTwV7tl1G4+v6cLx0Vv++Iczd6RSMqB5vXQofZ25h7mT+KGW2E5
         71WpvHghDwEfr54WPP4rnuTgg06v0Jtr4/77yWn58b1EjomSTT6x1Lz5Rmht5PBlQp2l
         yFIl6ZXCUk1rxXSGJcPB+nTdhQoRQ6K7Ptjpfr9RsPo1dLjyXzqTS7Y7FnZU1Ia+WFD4
         TrFg8EhhqfjGg6hKWxl+Kqo6MUYDdzrekHAhhqmTBE/MPmbXVnFwAe7YN8LcnXPgCzDj
         uh89I6azTGTs+lsoYajgcNH+fh6RbxwtI2mtetOouq4iMEmiywRlnNAae53kcVNVKAl9
         gHVg==
X-Forwarded-Encrypted: i=1; AJvYcCWJmb9Ai3xMCWmDCA4Cv1nM/cx7mvHWpbezm13WxuoPs5m5harC9eclNG1urxXUFCD1NRrBviNnP6Uskq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3k71RQasyKG4R71hyAS43gdQq6BEolPZgO2B9K6wyFppZ0OmE
	dfXMeWA+FDT4q05wQvyyO2XgP2GrH3ekUhSbaGFxLEeP4YvavplL
X-Gm-Gg: ASbGncuc8JFJ9/bqF/pl1XRexb8EWf55pgfbGS5C8p/ZKf2vqx7RTtI6raKnhg8ZHdm
	eddUCBq2S7djusS4KsR6yYnU29YyT34tN6RWo9YOvJ5fR6V4zXd9yK5J+EfQyZ5qNW9vN/X0l2U
	9DI08L5/+1SPHpTQKBpfXOyMIGqC+YHw6wQq5bs/yRH9b3dAbTFFrkZ9rNtOWql8CenFFs9P5on
	4P1SiLyV/Ie7BeMKAis9VKMyvz2epsGWTxiWfbkLNaOxRlcRqv8lOPfww+Qs6GvdIIvjrwnNokW
	3pjDpTOHswPMNCY3duIcAu5h6uC5RmBFeLUYN0ZAHkRkHS368ja9Tj9vCv1kkiE00/7qJ+upmqk
	qGmz8Nef3uU5RwGk8n/nxn2631LL07r4K/GIzRxSsPg==
X-Google-Smtp-Source: AGHT+IGxKomMocnLw8znvB5CA9sPxmcWTaLj9ccl9mIZAj6Kb4UW/TbsvGWqqwpRyu9AiVER5AB+Xw==
X-Received: by 2002:a17:902:ccc2:b0:224:1781:a947 with SMTP id d9443c01a7336-22a8a0556d9mr94019415ad.21.1743860126944;
        Sat, 05 Apr 2025 06:35:26 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c020dsm49579655ad.100.2025.04.05.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:35:26 -0700 (PDT)
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
Subject: [PATCH v5] serial: sifive: Switch to nbcon console
Date: Sat,  5 Apr 2025 22:34:50 +0900
Message-Id: <20250405133450.489780-1-ryotkkr98@gmail.com>
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

Changes since v1:
[0] https://lore.kernel.org/lkml/20250323060603.388621-1-ryotkkr98@gmail.com/

- Thank you John for the feedback!
- Add a patch for synchronizing startup()/shutdown() vs write().
- Add <Reviewed-by> by John.

Changes since v2:
[1] https://lore.kernel.org/all/20250330003058.386447-1-ryotkkr98@gmail.com/

- Add Cc stable for the first patch.

Changes since v3:
[2] https://lore.kernel.org/all/20250330110957.392460-1-ryotkkr98@gmail.com/

- Avoid using return statement on return-void function. Thanks Sebastian
  for pointing out!

Changes since v4:
[3] https://lore.kernel.org/all/20250405043833.397020-1-ryotkkr98@gmail.com/

- Send the 2 patches seperatly which used to be treated as a series. 
  The other patch which was sent as part of the series can be found [4].
  [4] https://lore.kernel.org/all/20250405132458.488942-1-ryotkkr98@gmail.com/

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

