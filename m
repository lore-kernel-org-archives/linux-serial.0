Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FBAD27;
	Sun, 23 Mar 2025 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742710011; cv=none; b=DBRJIMkU97nKhdBmFoisb8goUJxXR4ksyf+KTmUcmHpegSrysE+If21RJHNAnfvL0xh4BTcyFY5bhXeVHHGL/NvN3ITotXGdm7PxN8kkCdfw4T4HzIRUmOdN3nB+Q0869jDSiIn0CVRSrTU6m84E3oA/dDsQ7enRx89Ze+TuZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742710011; c=relaxed/simple;
	bh=I6k1xtcP8hppbjVrKhSpeoD7jmUHCyEErJxzazqfbSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gufojbVpg2Q41R0uOCs3is9hsY9wS4aXNYYKeR77OwlQ7yRaqQ/HRF0mLvjQ3DS8bX4RruwTWxcNDuD88Y/BRqAdX8ixU82xKsCTgx5mOQhTDszZ3FnpE7MWBDlomP/HEMfCxLk9XZE7a/jieICRtazKCMMaDWsVWOmxY2TPWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTtj6SMy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTtj6SMy"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2279915e06eso11180075ad.1;
        Sat, 22 Mar 2025 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742710009; x=1743314809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hRrLYrQqWoUWab1kJtk8tDpV6Q/Kh0bvdM9UsTNmZY=;
        b=kTtj6SMyAt4GQhJkVCKztm2aw2JSmjcwsmyE+d+/PYokbO4oomI0cyivbl4AC3RI7Z
         lXSLGPaphhp/GjL8QI0bj/7GxAlFa6A5Nyc9jHlvoSt/rjR8rWLsjGTijq7TdxXNvmKT
         NYP9SqLnPO64L0It+T0zgk8UjXOlr7Jr3lFjH4jLv+v6mnU/iJs6NZRg2CTsS1azhJXQ
         w2TmXQy5cWsOuGze8BxO4Vd7Ilz3bY/vj5x2Q/pIqCP/fwVIw6HI38WUDnTTXk6CT1Z7
         DOaYcHLcKuSOohuqDoyh49wohpU+Lh1DoUsoxlIEjzKjLlzL3hljvoqWJr9o670S2woZ
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742710009; x=1743314809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hRrLYrQqWoUWab1kJtk8tDpV6Q/Kh0bvdM9UsTNmZY=;
        b=JPGAZdZYjZfq77Vd+TwFCIadlaZfKKmxQawjT7ztZKtvVFAZUOPsWUVQQc8nCIx8ux
         GYX7CW7Hns7yGxRCJOdC3xAyhbSsAzwYY8AzO1nwvAnsnjceSuo3P1+ey/EdZ6qVKUvC
         rwFrKmzQszSutktPl60a/QTPMlcr0MTgNxR9W63koBhbkVkplfYqOWq8wv/XLOs5qCBG
         wlR1hlf2gV1pyrK9fj1inSffPOLVFqo5VKCIaPvMKYcLRwvaOdH2wTEuoQ9PgCsxr7r7
         RtN4FzBlfXz7UaSsjIZsshlzL582XoKhPaIaUZuWjwqm28psWTs6+2A7hsOYEDGO0qVH
         f/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVTW2yXxtvIDUf+EE2taG5nNA5bGRFgL0pbz6phpQ2eHIHPWHl0d/Z9DgSefE1//w0xYN8NqM23XoXpQjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZd/x682wFNBRk71kQA94pb7HZYD6LwpZY+U+R8CKQQ9p9BMO
	94VRQ94W05EUBKsoKFGLNGYufzaiPQXo2MjwxI6laN5OgmjZGrvK
X-Gm-Gg: ASbGncuncW8zbtBRBn5JfWa4ZcSesb4hkpAwdxXA5Y43L2ocHvcZVMWOgTNFhVy6idX
	qJ2D10/P6wduERFzegdelZriFyiTMfS3b1ti5fCckBGlV6QIkc61nO7JM7vynw9w6/z61Q+PYV8
	BAW2HvF5GVhIARXJJWLVj/4QfKVx+ITm/+pHCqE1vjlcVqKfDsZLKeglJjnQXq2Xo8CpcS2JUb/
	yGZLpepS3f3FhHnZl8+NLBm4Hl4rcvKIm6IeSjXyuJ/OPQ5oDv3HWBY2NRXK8XhcstV6geT8KqA
	57pCKytwb2iqUeN0PlqOs/pMyAesG4HlO5/0Dh04n1BwE7ABzyeHVp9LQ5PRlxMohMNvCvCZXxE
	RpXu1pgFmG13a9ImwH9XIfKdAban+D/0=
X-Google-Smtp-Source: AGHT+IFdTzdYwVw4qAZHzhbbTSWg3s2s5hfhGqEcU9flZ/U2rK2lNN4Qh8/poZ0SnK+VH3t/JQOFQQ==
X-Received: by 2002:a17:902:e803:b0:227:ac2a:1dcf with SMTP id d9443c01a7336-227ac2a2536mr25143875ad.23.1742710008825;
        Sat, 22 Mar 2025 23:06:48 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2e0sm45406045ad.39.2025.03.22.23.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 23:06:48 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	john.ogness@linutronix.de,
	pmladek@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] serial: sifive: Switch to nbcon console
Date: Sun, 23 Mar 2025 15:06:03 +0900
Message-Id: <20250323060603.388621-1-ryotkkr98@gmail.com>
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
---

Hi!

I referred to the already converted console drivers 8250 [0], imx [1]
and amba-pl011 [2]. I tested the patch for each of the NBCON priority
(PANIC, EMERGENCY and NORMAL) on riscv qemu.
Hope to get feedbacks, thanks!

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/20250107212702.169493-1-john.ogness@linutronix.de/
[1] https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4c627302335b@geanix.com/
[2] https://lore.kernel.org/linux-serial/20250204044428.2191983-1-fj6611ie@aa.jp.fujitsu.com/

---
 drivers/tty/serial/sifive.c | 87 +++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5904a2d4c..d032de619 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -151,6 +151,7 @@ struct sifive_serial_port {
 	unsigned long		baud_rate;
 	struct clk		*clk;
 	struct notifier_block	clk_notifier;
+	bool			console_line_ended;
 };
 
 /*
@@ -779,33 +780,88 @@ static void sifive_serial_console_putchar(struct uart_port *port, unsigned char
 
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
@@ -823,6 +879,8 @@ static int sifive_serial_console_setup(struct console *co, char *options)
 	if (!ssp)
 		return -ENODEV;
 
+	ssp->console_line_ended = true;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
@@ -833,10 +891,13 @@ static struct uart_driver sifive_serial_uart_driver;
 
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

