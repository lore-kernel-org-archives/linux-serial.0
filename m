Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED41BC46
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070433; cv=none; b=O05ob1EzkTrxGv2FbPvEeM70hgo+S5OLClF2Q0TuiYkd4pi98oCSXiXOWfHshhyT0WZKs1WVgIW8QN9G8Hg698kWmkOeFCXKD4w13UpiPT+1GipS8M/aYzIV49/Kki7BtQuWIhOeJ6RekHxgzyDtXJ7KTu1WcIe7XGYkkS73Wks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070433; c=relaxed/simple;
	bh=DpW7fdG3PEtBSw4uHybL/y6wUJ0RIFhtQZUvi+EiDQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lclpz0SyjLLDyeTawXXPHvhKsmHXXdZ7cYNmGMtqx1E/rKXVcOzeHs5hWPfm4c8eZRoO0RwaEk+JtTRdk6aL508YFznMOfLJ+KsDybDgEr8mMsdeLGx8vquCy03tEBu1oBHNrckQ74rZclADBbefDywWt9Gs21Vu7IhMBlH5lBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbingKq8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbingKq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708070430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bho+yn8M4kGUaS4UAXQ+fSY/db1hBVlHnbWifBhcoOQ=;
	b=KbingKq8bQB/tVwThgkrOePHrzrH9vUza+vafwlLoYFBlmxo9S7GlOzcJXB9BrzLtd03uc
	STPxVtHp2Add4qO6ScFkamwukMjWNoqr4G83Gqix/g2/kTj+Hd0MRh0UlQbD8E6hj7eQOt
	C0LOIblATfprhVmNBs3eDNNlhnxxrc0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-GKQkKMUpMtK34O-j3URBKA-1; Fri, 16 Feb 2024 03:00:29 -0500
X-MC-Unique: GKQkKMUpMtK34O-j3URBKA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-785da5b71d3so193840885a.2
        for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 00:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070429; x=1708675229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bho+yn8M4kGUaS4UAXQ+fSY/db1hBVlHnbWifBhcoOQ=;
        b=D3ukXzrwwgevhyc1w2CHMQdA8Nqg/w4raOLT7JjT9XOnlzO8ifG8avf/XtZnxmO+P/
         c31IVk50SBtDMSlXPtRVYD2V1ovo8nHFyNq1hStbvJsOcgpnMMCWyExR43yCicLMAPap
         Dr/3wBS6OauYefLy4+Vs9uZuNaQSwDuZE5R/ZCWdElFDl2bnZQsfAtPuRICrM+q9/fJu
         IpnBX1rgpFmIAtulXXlHfdscTo8+2UjbcTj1g7bWsnq3OftSjD7fm3K/3DWSoEN9xTSx
         c/jWAvMM+2NqzFiZ2EYLLNwzxnUty3z7PHcYOFyl/yztjYJQoLKMS0jvSNgFd5qUX4DA
         Lm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8jWKy9ePvvOoz4UmXKfIpiakjCNVQMTMwqCbkGjpSH87KQD4NgcbZOcpJRBwNYW2+GyjxUdofzzloBPDXBwCFl8av4uHCrZJlaO45
X-Gm-Message-State: AOJu0YwE8l2hYtPB8bMO3bajRadUjcmiYS6fBH+0WRGohBklURBzauYS
	+avYsLruo0C5PRCgI2UcUVRO1YNFfSCOpe4F5uubmj1g125z+vuwu9zicZXvhuF+FWZ3RqoZvaM
	ig+AL9b1OUKup/UHyJ9myw3eiOkYCN2J1LNBSGxFACUJLeLRidltXDS1lTEC4iw==
X-Received: by 2002:a05:620a:564a:b0:785:ec1f:6aee with SMTP id vw10-20020a05620a564a00b00785ec1f6aeemr3631451qkn.27.1708070428744;
        Fri, 16 Feb 2024 00:00:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk5xfmE9icqXe3ltJz8nq6nkHMSdP3/86CuMkgc0dqcATRNh3NfMI3OUZi8MhWVBnCnizQ8w==
X-Received: by 2002:a05:620a:564a:b0:785:ec1f:6aee with SMTP id vw10-20020a05620a564a00b00785ec1f6aeemr3631427qkn.27.1708070428387;
        Fri, 16 Feb 2024 00:00:28 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm1300756qkb.54.2024.02.16.00.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:00:28 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Leonardo Bras <leobras@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v2 4/4] tty/serial8250: Make use of IRQ_HANDLED_MANY interface
Date: Fri, 16 Feb 2024 04:59:46 -0300
Message-ID: <20240216075948.131372-6-leobras@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216075948.131372-2-leobras@redhat.com>
References: <20240216075948.131372-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

For every TX byte an IRQ is requested.
On threaded IRQs, the handler calls serial8250_tx_chars can send multiple
bytes, limited to it's queue size (tx_loadsz).

When this happens, the handler return IRQ_HANDLED with reduces the
unhandled IRQ counter only by 1, even though many requests have been
handled at once.

This causes the unhandled IRQ counter to go up until it reaches the maximum
and causes the registered IRQ to be disabled, thus breaking the serial
console.

Make use of the newly introduced IRQ_HANDLED_MANY interface to return the
number of requests handled, so the unhandled IRQ counter can get decreased
accordingly.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/serial_8250.h         |  2 +-
 drivers/tty/serial/8250/8250_core.c | 13 ++++++++-----
 drivers/tty/serial/8250/8250_port.c | 16 ++++++++++------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ec46e3b49ee99..c9d4271b71d70 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -200,7 +200,7 @@ int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
-void serial8250_tx_chars(struct uart_8250_port *up);
+int serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ae637155fe7cd..2fab9102eec45 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -110,7 +110,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 {
 	struct irq_info *i = dev_id;
 	struct list_head *l, *end = NULL;
-	int pass_counter = 0, handled = 0;
+	int pass_counter = 0, handled_total = 0;
 
 	pr_debug("%s(%d): start\n", __func__, irq);
 
@@ -120,15 +120,18 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	do {
 		struct uart_8250_port *up;
 		struct uart_port *port;
+		int handled;
 
 		up = list_entry(l, struct uart_8250_port, list);
 		port = &up->port;
 
-		if (port->handle_irq(port)) {
-			handled = 1;
+		handled = port->handle_irq(port);
+		if (handled) {
+			handled_total += handled;
 			end = NULL;
-		} else if (end == NULL)
+		} else if (end == NULL) {
 			end = l;
+		}
 
 		l = l->next;
 
@@ -140,7 +143,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 	pr_debug("%s(%d): end\n", __func__, irq);
 
-	return IRQ_RETVAL(handled);
+	return IRQ_RETVAL_MANY(handled_total);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f799c34f1603c..74d53507a73d4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1802,7 +1802,7 @@ u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_chars);
 
-void serial8250_tx_chars(struct uart_8250_port *up)
+int serial8250_tx_chars(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 	struct circ_buf *xmit = &port->state->xmit;
@@ -1810,15 +1810,15 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 
 	if (port->x_char) {
 		uart_xchar_out(port, UART_TX);
-		return;
+		return 0;
 	}
 	if (uart_tx_stopped(port)) {
 		serial8250_stop_tx(port);
-		return;
+		return 0;
 	}
 	if (uart_circ_empty(xmit)) {
 		__stop_tx(up);
-		return;
+		return 0;
 	}
 
 	count = up->tx_loadsz;
@@ -1858,6 +1858,9 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	 */
 	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
 		__stop_tx(up);
+
+	/* Return number of chars sent */
+	return up->tx_loadsz - count;
 }
 EXPORT_SYMBOL_GPL(serial8250_tx_chars);
 
@@ -1923,6 +1926,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	bool skip_rx = false;
 	unsigned long flags;
 	u16 status;
+	int handled = 0;
 
 	if (iir & UART_IIR_NO_INT)
 		return 0;
@@ -1956,14 +1960,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	serial8250_modem_status(up);
 	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
 		if (!up->dma || up->dma->tx_err)
-			serial8250_tx_chars(up);
+			handled = serial8250_tx_chars(up);
 		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-	return 1;
+	return handled ? : 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
-- 
2.43.2

