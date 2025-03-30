Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CBE4431;
	Sun, 30 Mar 2025 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743295243; cv=none; b=bVTSV1/38MsUsQ3ZAP/vH3VF6jqpg9W0W3jdZIcns24RbNm9DoN+KYk/fmTTBE8GOCPuUDF86ecS9DizEIuZZ6hcIwP1R0AZtW/tDvOM2TqUrG/Z3W/4NvXDRkGgH3feeLsN97kQYx2Fya7MoexWbaVEJe5Q7mmLaSNJNIMQe2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743295243; c=relaxed/simple;
	bh=aE1PF5WLy33Y8t4F9B7ciZ8sDuqyDOI9Xc97DhOEnz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oetLZ9X0wLaDAeyadzcYwmmZXP7aFzerT5oTWRS9KTgZo/Ulk2EjqZLed06kxbjP6DfT/e6ed49Jm6uzE4eBSorEB37IP+ymKYtkyNEDod/FNQ3zAhoa3UH5Ty80OFHdiv14bE5IBO0GrIAYkxXWSIZznMSRZrfKaWgN1CkSmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jehTikBU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jehTikBU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223f4c06e9fso63249485ad.1;
        Sat, 29 Mar 2025 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743295241; x=1743900041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMZHL0UOoWagu8ugPnApvJFimUNmRJzmGaDhx8HHglA=;
        b=jehTikBUGJEvLGEKR61sbjy7n/I7N2iEvRlxQCKVO6MoWf4Os67bGmcXwV4WJjyz6/
         4Qx+eZ8WRCIjhyXVrhcZquZwvGb+VHCqkTJmUOOCuvOWClY73pgTjcpPNtdbzzjLfjfm
         Sxa3ZUC6OmqiLt4qCNXoyuCq2oAOR4i4K2pdpAatyFC0xU42IxyYEXsS2Fgb7n6ezwvL
         NfdSZv7W4tAvlMnVbGn8wexp0kBmCfHRV5PtwtoVVi3C3GDBs6W2mHF5HPQ3ZpEP2Rie
         SVejMIWlDeKFHlz59ZW13bJlzSyFr79Ms7f3q0KmOMelhFhwZpt0qipVKFQB0co1yFhA
         tOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743295241; x=1743900041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMZHL0UOoWagu8ugPnApvJFimUNmRJzmGaDhx8HHglA=;
        b=vmLG6oevK/Q8dq+D3v2lbKsT89cn9IewA/2WqHodB9Q9mncKjDJ1vjuIumLNzTKRr6
         BI+2feOAP5jZkQWtjMIjKVJ0ier/KlzbJVMCb/64Tq7lzKXDfk3MBgLicE27BwxyGl7e
         6hW3eDU+k+bAEElXA/OqSXaXr8HMMVnHUYD3E/R+0LKv+kNLCrgCeXykiDgFF4eTMBix
         7JXyvtRpZsLh6RHPERNkK3ylvzP7A1aWK153KaXKViBW+uOgqiNJL2OZBnnuwHMt/dNM
         7BgL4Jeumpfzqyorrqre7ydyO9rJ6tmz9Gfw0rCr7qmAZrgUlEP8Fl8VDHs0LmS3Qft7
         1I/g==
X-Forwarded-Encrypted: i=1; AJvYcCWNjXJtWU1ABe+aGJqe+0YbgqZgaW3h3UP5d3x5wD5A5DLbCB5ILiWqehNfRb+J2ScG0nnWjtJjduCoYEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJGthrs881Rd3wsOqIOl7Tb/N0hVjgQNJiBr8HOXUztiblapB
	H2MQDdv746PWFr+U7Eq3QXCod8fQcLpfXL/dIXSS5PUK9mY86xnQ
X-Gm-Gg: ASbGncudet4MXCR6vpa+qWP07hPs6sjuvXghV+5NpgFlwBkb+BoMcxY6356i6dRbVQB
	umxouBxyYBRVUNvFv4Go1uTqbrY22/uOvP6NIwljBC9mGvRCxIrodJ8vg3XhpmbJeDECVu2pD67
	2RNUK6lwmT8A/ge0IPi0jyzdnUNrnRMW82jq3wtnLLTIWmvsUao4JeqQuSRo4u3mPChwSb5Q4Ec
	agdTiLtzbL6h/R6iDkxiMhg07PSG4HSXHt8naTgnUb41L1iZEymeyHUAfPwCiibM+18W95PH/LE
	zWvIX7wVMsnIlqrLHZyAWYghAsPi/ADOcvAG7i35/if5Pb+EjzPCcpRpN9Rvfr0SO22NqWSoskB
	pL9sSHW/VAyaYp4N5JYl2q5ytDurVYXjq4y6FokitRQ==
X-Google-Smtp-Source: AGHT+IHFOyCEAeJmbkmn+i+Vl5fMBQ+7z+CMVVak4iT79a/beE+79Yk9mFZKRySVNG7yZkoJnU70Tw==
X-Received: by 2002:a17:902:e88f:b0:21f:5063:d3ca with SMTP id d9443c01a7336-22921d25b63mr125070065ad.16.1743295241191;
        Sat, 29 Mar 2025 17:40:41 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e22346sm4246537b3a.46.2025.03.29.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 17:40:40 -0700 (PDT)
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
Subject: [PATCH v2 2/2] serial: sifive: Switch to nbcon console
Date: Sun, 30 Mar 2025 09:40:07 +0900
Message-Id: <20250330004007.386978-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250330003058.386447-1-ryotkkr98@gmail.com>
References: <20250330003058.386447-1-ryotkkr98@gmail.com>
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

