Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689377;
	b=w92woigzam6KYB2BN9SVY6lRhEFj2N5RQUjXgF0WNnGIEgszHQhayg6yImjLaRfLM351
	 EAQTB3M8eK1jO0Pln0o+kuKOeXE8LEatovzmWaXAT/wMs1IULtTlOw1PPALYZgLzG9XPQ
	 t7FvPeEHnY5uAlTB2v8tyxPVKQgfyvajnCxeEPkJEM4qO/uJznxLlD6Nyudk4lLGg6lGe
	 jChcULZJPqpQ7Ojkbp6BP344d3VUeLEkiMV5o3y69WZbZ9Yx3n1RHoVqQkWlrf4/lumGt
	 SwkUnGLRElSB9p43dUEPBm1jTIjEcpOkx7Apq2vCulojI8ZQbhds1oRlc9BJ+ndvc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=MMBG8QKSR0rhDtOWejNhaXgUwJDCAE1G7Lk1+og1YAE=;
	b=5Skqr3SUTeP5UfcZP19KHtJBgkd3GQlVfY4hlt1lMnszw0ezN7mzGW+j+WlkGdtW5tM4
	 hptUNAztrc+EWyBs1dcFx4gHsgbU3IbLna1c9c9QN3tQ4pTOMwBbM35f4bcAFDubD6Ix6
	 PJPeiGPSmR9AQMl5fclou0swOqRmwBrTcCAYXVK96M4H6hPi4nNOMlAiJ/Lc3MhZAYOBi
	 waXodoRzzm9hD9QnKDctLFrl3lwrlLar13VpQNCou3VX7S6wZMq8KKt0PQBa+1xyQxDHS
	 QZ4lcodumlpgIceSSGuSsB2hQLmlQQNHS1WfJdtmjcgNzEw+oTVswr84Uxh2575a4iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZbAFahrD;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08994606A325
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 17:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08994606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZbAFahrD
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a77761ff8aso37461fac.2
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792689376; x=1793294176; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MMBG8QKSR0rhDtOWejNhaXgUwJDCAE1G7Lk1+og1YAE=;
        b=ZbAFahrDCUfbmLIcschgp3VGFEBHdDfeNAh65p58FNTDyCjJ2NI6XbX/m6jzfRzwrU
         ZLlJlXH5cTS+21RnZbnQfRWIDIDJuda51lAWKfLX1frlpGcZPhcGzpLuIw6h250/nupg
         cvx8h3oGM+di9E8dI+lvuZ/pjIu5PMuaRrdak+BTFkuPcl/OGx9VuzjFC6lroz7k/xQa
         PCAc93OGEoqDpohaFYQfx41aEgcWQKJo8NAfBslJZ/qqluyXo2yKUGWR85mikyTE1FzD
         L2RAhqlTgjOPMqYvZRKNx19JZd0ZWvF/D8N3SmF5Rl7urnninYZZGonNpMUICOpEuqEC
         X/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689376; x=1793294176;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MMBG8QKSR0rhDtOWejNhaXgUwJDCAE1G7Lk1+og1YAE=;
        b=OXEztc5qYuxx/6qHZ/2eXzp6jdrDj67ot6xanDPY+bbTQl/WbVXmrBdPWJ95woK4Ib
         YPA0U0vngUh5C/LF5aG/S6j2U3BtsQndBLjRGcd2LCq3QTeWieSK/pm7GGxCVfP+c69R
         6B3PCxJVHKYWDDs4XxV6R57eSbPfRTa7zcYW99foVUt60RmV3d4NVsLunJ43TSBq0RxH
         K0pnatdQqBaEcWZ6tJ8iLeOgihjnIhSGEZtObFhax3mtiy+stKOzmKc1ELRsQDmY4mYn
         wESYT4F0Vie6nTDOxbtMUFxHl/YzjURocsc5kfRj2gzyNO/ixflQGLl9XRdkzcC+1LXg
         HC2w==
X-Forwarded-Encrypted: i=1; AKwUvBxlHB1BkByklcVpQ/uCJESzUjMmqh/TchYSfNvs++lOSP2JV7htOc398DM9drBklJuODOjdtQy6bZgjB68=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOoBdqdy0n8Vb+b6ab/wnL/TNvPv3tn+DyYj8JL2gMh5b44eJc
	UGW5FMSPLJ3r/Na9qzoLCEzJwPf2ZHZsMPmlZdXddRaeU2s/wD/t8u6f
X-Gm-Gg: AYBFou3tRLJo7qmr6XoU4vVJ49OldDnFb1/RpZ62rGrL72OohkV/c2qsDdMBiiHD1Jg
	YGwunpD+g3YpSOlb5bTnrDKlsqt7sBKGqDzHjcPpotYL8oD2cU6fYiWtE3QSl8IUvUUI4CCONx8
	6hC20/Jj4cy1Q7HeSN4dhjhhgb9GuuI3UwdKKhxdh2QAZs1ZqW6p7UUaBSkX+DGh2ilob92XJ+s
	exHYNTOUsWf5fFD5NkNtPvtQ7i8ZLaM/OBhA0TnRsFWTB0jIMwQWqvTQORCNBU8iI8LAy91wj/L
	lXta1EWDV2n1/OemjvhcBG92bcjh2uUbzlvWDpYfdQE/7w3qo8cDXP+bQdfme87xg7GW0WnJrkM
	psjK2917lTMv7xtk5GeLsSYfm3GmHo9vSI+cWm17JMVziNp6ymL0nW9zNCSKSFhas1roiKMNvvO
	JTmkr6iywM3MqQrs8SmaQOsrEDMc4KY3AVpCJ6RGlrxm/UDEUzJVGZj3c2nFwTnOqjM5Y3HSqyJ
	3Az4kJ+OhpgwrwYgriEluR12wUzukkIVU+hbyVL2HYn8lCK0WglCp69sE0wxZCVlLe9pU7xMWb1
	vyk6S7D0icvePBnU70xtCgbMU/6dMjz918qO6hD7hFxiVV6WvBok1uHDJ6Zpsm8RhSELgDCel0X
	iznkg50gvL3np0WE4P21zEL1Drufzuttu7nfJbcqsXTJ825HPCSc4+RT0DaEaw2FFAiayBV/Sct
	DlJfY=
X-Received: by 2002:a05:6870:b3e8:b0:47d:f10:686f with SMTP id 586e51a60fabf-4a7dc1bdb12mr4297357fac.23.1792689375838;
        Thu, 22 Oct 2026 10:16:15 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d611b380sm4997022fac.5.2026.10.22.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:16:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 11:16:11 -0600
Subject: [PATCH] serial: 8250: release the transmit PM reference on
 shutdown
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7CMAxEr1J5jUUSCWi5CmKRj0uCaFolbimqe
 ncSWHjxRjPPG2RKgTJcmw0SLSGHMRaQhwas1/FBGFxhUEKdpVAK82yGwFhn+oWtOgnkFacBs5/
 Zje+Ii0RnOtFJ56jtL1BUU6I+rL83t/ufi+dJlqu7NozOhCbpaH2NmD/HchhpZdj3L7ZQCsynA
 AAA
X-Change-ID: 20261022-submit-serial-8250-tx-pm-shutdown-v1-db9091dde8f7
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Transmit holds a runtime PM reference until the transmitter-empty path
clears THRI. A hangup can shut down the port while that reference is still
held. Shutdown clears the interrupt enables and stops DMA, leaving no TX
interrupt to release rpm_tx_active. A suppressed DMA completion cannot
release it either.

Drop the transmit reference after shutting down TX in both the generic
and OMAP shutdown paths. Their separate shutdown PM references keep the
UART accessible throughout cleanup. The exchange in the helper also
handles shutdown after the normal TX path already released its reference.

Fixes: d74d5d1b7288 ("tty: serial: 8250_core: add run time pm")
Reported-by: Raul E Rangel <rrangel@chromium.org>
Closes: https://lore.kernel.org/r/20261022152019.1621716-1-rrangel@chromium.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      | 1 +
 drivers/tty/serial/8250/8250_omap.c | 1 +
 drivers/tty/serial/8250/8250_port.c | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..4a7d26e2dbf0 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -190,6 +190,7 @@ void serial8250_wait_for_xmitr(struct uart_8250_port *up, int bits);
 
 void serial8250_rpm_get(struct uart_8250_port *p);
 void serial8250_rpm_put(struct uart_8250_port *p);
+void serial8250_rpm_put_tx(struct uart_8250_port *p);
 DEFINE_GUARD(serial8250_rpm, struct uart_8250_port *,
 	     serial8250_rpm_get(_T), serial8250_rpm_put(_T));
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 29a203ed93fd..bb6c312c8cdf 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -795,6 +795,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 	if (up->lcr & UART_LCR_SBC)
 		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
 	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+	serial8250_rpm_put_tx(up);
 }
 
 static void omap_8250_throttle(struct uart_port *port)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index db066a42f61d..76f35d1b3203 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -672,7 +672,7 @@ static void serial8250_rpm_get_tx(struct uart_8250_port *p)
 	pm_runtime_get_sync(p->port.dev);
 }
 
-static void serial8250_rpm_put_tx(struct uart_8250_port *p)
+void serial8250_rpm_put_tx(struct uart_8250_port *p)
 {
 	unsigned char rpm_active;
 
@@ -684,6 +684,7 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
 		return;
 	pm_runtime_put_autosuspend(p->port.dev);
 }
+EXPORT_SYMBOL_GPL(serial8250_rpm_put_tx);
 
 /*
  * IER sleep support.  UARTs which have EFRs need the "extended
@@ -2486,6 +2487,8 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 */
 	synchronize_irq(port->irq);
 
+	/* TX interrupts can no longer release the transmit reference. */
+	serial8250_rpm_put_tx(up);
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261022-submit-serial-8250-tx-pm-shutdown-v1-db9091dde8f7

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

