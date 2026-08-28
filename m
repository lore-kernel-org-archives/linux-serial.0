Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213F327BFC
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928422; cv=none; b=KyXn8enDq8dE+QwAtSmNL7xVRD1UCoGWDMy6UD5ebex4dt50WosnDFBDPu5IVAOSR7YY5MuyzYOQ8Ar1AQh5cj4RApRQe6aVTWVCSfGW/U5Zxrllg0P15Dbo+RbKJwM19rgfC4cXuDRnYzK3BYnuS5Pwp7sDg3opEtHivKQcVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928422; c=relaxed/simple;
	bh=PyMFn68RRIN3IzGpKysy1B9f4xHkGdvkvFc5FOvKIBI=;
	h=From:To:Cc:Subject:Date:Message-ID; b=hwd1WaWKx0lyEKoU8sM9vPg2fxNN8igIV3AqD0JQpKOTSj0sbzHQgvBQWzl/xvTV1yiE9vUvWbXL/EuUAL+x9nNUW/YEwieKW9THaerrth0Uci1nNUzuSTv1biKSJbVJezgy4EgDkd5ha2/9A6kYactiAKgPHxhOFWJK7W6CcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=EN5ec2xj; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EN5ec2xj"
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-782e0fc1e55so303283137.3
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 07:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787928418; x=1788533218;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YA8nPi3ueKnPwe6mZk4m/RrVVcVGq0t5B55x+7fBTtQ=;
        b=r/P32Yz4D0WdE5+II6VXg6zM8jGv/eYZQSo9cCprGbt4sMovyu8kF8Vo/uiaRMEjLU
         4O3fFxMzoYjfskAfSN9mwESgx+4pqCrhyV21JiuMf6yVEcvBPEZlunH/ZdwB44TX4/ww
         KegbaQChWNStz8M00UIBY0T0wD2J/DqbdE3GSkdhgsMuyKg9L0P1xogI1ZdMiBjz2zv4
         oGmyCHJqYcnhA7XdEgtQMmreEAG7GA3vL+oi8B4tTSeHGG66ty0f2L08OMVhJTVj9OPJ
         Yxfnq4Kpz8zpySf0IV5GAfiraY9CyMDzQ0MtpAkFtwE+/OAfkQgKdyF3RFt3qs6Sruw5
         lJ2w==
X-Forwarded-Encrypted: i=1; AHgh+RpqYn0YcOiv76sA/BDyvYC+Hn2ZQ+Hd8j3peLZvPvO0yCCZIDRb0RCKW/NH7eeo5ZIXkvjt/0kdTEBfVpk=@vger.kernel.org
X-Gm-Message-State: AFuF++mdOgJaxUMZssR6BIDgKF+smP6t6g9EsnO/bPENdlb7cV1Kd2bc
	F/+aJ/Let4yr5MmmollJpRJ2Zoh46c4RXUIVpi8bFGJG5hMxbqljR0VvDX0S8SQ0OspoxSGaElt
	8VnmWw7zTl7LWtla+2gm2BrsJ1XsekdK2ig==
X-Gm-Gg: AR+sD12C16eE9VhCOan47nr6u/mbWAKhFx8JLQCW+qvx7LDEB21tU6NUyJY/WmmgmUz
	6tGadYxkW6SEkGfvE/TzhQJyqCTmxaNlu9ZmCL4s5IkMeT0XlX7xbQDnKg2lbFYZPXvNXk/1DE0
	NZMtfoRpi5mC+hy0Hgn6jBDyiD42XvM2YTEiNEkYyKtOS/FqYkSChhDK4Uz6sQNgwW6HjkCQySb
	cUtr0xq+s8Aa6zVta+bOCJUO+iTSYL8GZcVwIztgYtyi7tT0X1DpX2YPXELN3Uqulp66gR1PGkK
	UKY+QvjU+RNsU6+U3W0pQNP/cZunKSN1IWMbfBOMo7JvOMRjBR7L+14PazAXW8FhOjbvSkL3xxd
	xQDOGor+CR7knaPfG1Te7pwf/Wc4xOpSl7LY=
X-Received: by 2002:a05:6102:2907:b0:782:de7b:eead with SMTP id ada2fe7eead31-785962b3b4fmr2012595137.1.1787928418039;
        Fri, 28 Aug 2026 07:46:58 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx1.aristanetworks.com. [74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-785f800dbd3sm28652137.17.2026.08.28.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:46:58 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1787928417;
	bh=YA8nPi3ueKnPwe6mZk4m/RrVVcVGq0t5B55x+7fBTtQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EN5ec2xjEDQzo5TUwvsImgohFuK2Ucq51bvpqk5Ichgg9ZdWA+bfElliISOYYeY87
	 JdMvH5TkgUgl+vCrQSimMFgYY6cW5rVlKUdA0wK6qhwU+/21sIPmEbgmBhDAu2eS3A
	 iGEWBtiMsn9ARvnwbubsmopAfOV2yGVn2waBVZMGnF4waUOZaxmvqvkK6Z451wB+ET
	 4gy6/SH2Kpwro4Woi37KpBUkaGuBZoOmqUcUDCpn/38dpIBJ0x9yTGZUmQRd1uLz0j
	 WC2BUcnVI9wRAwogxR/j/eduSwbDzf0+AQ8JVvDSvQ+fr5sgH/agqeOrHMx3c82D7v
	 t9VK2pj06Z0ig==
Received: from vm-whiteberg-ubuntu.aristanetworks.com (dhcp-244-90-77.sjc.aristanetworks.com [10.244.90.77])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 260B31003C7;
	Fri, 28 Aug 2026 14:46:57 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Tate Whiteberg <whiteberg@arista.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Tate Whiteberg <whiteberg@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_mid: wait for LSR tx empty before setting termios
Date: Fri, 28 Aug 2026 14:45:17 +0000
Message-ID: <20260828144617.1210599-2-whiteberg@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

If mid8250_set_termios is called while data is still in transmission,
the corresponding register updates will corrupt the transmission.

Fix this by locking the port and and waiting for the transmitter to
empty before performing updates. It is necessary to wait for both
UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.

Signed-off-by: Tate Whiteberg <whiteberg@arista.com>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_mid.c  |  5 +++++
 drivers/tty/serial/8250/8250_port.c | 13 +++++++------
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 9337fec9394e..f99620b1cab7 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -180,6 +180,7 @@ void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
 void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
 				       struct nbcon_write_context *wctxt,
 				       unsigned int count);
+void serial8250_wait_for_xmitr(struct uart_8250_port *up, int bits);
 
 void serial8250_rpm_get(struct uart_8250_port *p);
 void serial8250_rpm_put(struct uart_8250_port *p);
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 82656645b8a6..c77e117b7822 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -210,6 +210,7 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
 {
 	unsigned int baud = tty_termios_baud_rate(termios);
 	struct mid8250 *mid = p->private_data;
+	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned short ps = 16;
 	unsigned long fuart = baud * ps;
 	unsigned long w = BIT(24) - 1;
@@ -218,6 +219,7 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	/* Gracefully handle the B0 case: fall back to B9600 */
 	fuart = fuart ? fuart : 9600 * 16;
 
+	uart_port_lock_irq(p);
 	if (mid->board->freq < fuart) {
 		/* Find prescaler value that satisfies Fuart < Fref */
 		if (mid->board->freq > baud)
@@ -231,11 +233,14 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	}
 
 	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);
+
+	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	p->uartclk = fuart * 16 / ps;		/* core uses ps = 16 always */
 
 	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
 	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
 	writel(div, p->membase + INTEL_MID_UART_DIV);
+	uart_port_unlock_irq(p);
 
 	serial8250_do_set_termios(p, termios, old);
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38fa45e74a37..4eaf417f1fd7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2024,7 +2024,7 @@ static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 }
 
 /* Wait for transmitter and holding register to empty with timeout */
-static void wait_for_xmitr(struct uart_8250_port *up, int bits)
+void serial8250_wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
 	unsigned int tmout;
 	bool tx_ready;
@@ -2052,6 +2052,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 		}
 	}
 }
+EXPORT_SYMBOL_NS_GPL(serial8250_wait_for_xmitr, "SERIAL_8250");
 
 #ifdef CONFIG_CONSOLE_POLL
 /*
@@ -2098,7 +2099,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	ier = serial_port_in(port, UART_IER);
 	__serial8250_clear_IER(up);
 
-	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	/*
 	 *	Send the character out.
 	 */
@@ -2108,7 +2109,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	serial_port_out(port, UART_IER, ier);
 }
 
@@ -2223,7 +2224,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	 * Synchronize UART_IER access against the console.
 	 */
 	scoped_guard(uart_port_lock_irqsave, port) {
-		wait_for_xmitr(up, UART_LSR_THRE);
+		serial8250_wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow THRE to set */
 		iir_noint1 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
@@ -3293,7 +3294,7 @@ static void serial8250_console_wait_putchar(struct uart_port *port, unsigned cha
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
-	wait_for_xmitr(up, UART_LSR_THRE);
+	serial8250_wait_for_xmitr(up, UART_LSR_THRE);
 	serial8250_console_putchar(port, ch);
 }
 
@@ -3504,7 +3505,7 @@ void serial8250_console_write(struct uart_8250_port *up,
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
-- 
2.43.0

