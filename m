Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6D3ABD99
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939895; cv=none; b=ME7rK9zPAFjPCjRdbWOO407Fhexml1EIvB7eo8JQkEAerioW1FvJERR4ij1fHpszwb2nD01GGA5Y6yASIfWhhh/bxDitJbc2AgB3YAc9Elcnel8LkFG9XWNN4PUV6PZEeFyZ8RhCRcpuysqJT7YNGcqQYZ6ZTynLimN8eMqZ1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939895; c=relaxed/simple;
	bh=2syIJmjcswpsVgwEi2ImAtlcAqYfUfd9bprdJdMk+Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=KPZZyT8L6jcp865BqhRTyIY6rRa9Xp29sKBT3FqfEJ+ZUjwwTVUncGJKdXLOj2dJP5KZOyoJzsaXJKRlpVo4pONbzhEnZri8HqPOds4Y4DZxtRBKgXYPDIVaDS8d/AYKD7i8nTPs4BqhTJ5ZO6J4o8mDuPo+AgR6wgeT5SJpBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=KlhWY1YT; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KlhWY1YT"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2cf452def93so20005025ad.1
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 10:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939893; x=1788544693;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZqFY5uK60R/5xw6Negun7eGTEaorGHjqlQPmWGNoYw=;
        b=CLoCAbnbqUQ1s43dLOShrBXxv1tzFGj4N4bJIuRVH3aiLwsWQpUqmVAmLGFzHJcnBG
         oDkgq07t3M6W/ADvzO/f1bKSuTd3HsCBLFnd+QdOiZxE6sZBufY1gGe5lycNYc1rrHsY
         ILLNMRIkl35y9fdHgeytsxrP2RZmONc9ByrmosA8ZFpzz0bxpC6RDU8ieKNEm042BgCI
         Zk3j5I4cHBolxi841SSTRmuHfedpvH7gQkN+NrBw2C3LuQmH7CMNDbKErRSPvz0iYeC9
         3qty1bkAQrg3cPE5L5i972xSP4ULU3M0+nO8B019mKrvgKbBxHQCpYrZjq2krsddZpnW
         vVfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxntRNoKCf4lwv4j4TGknepkQISj6+Xqn+XHbTOAXc6t6Vspc2T7mQZr4IBkKzsX3A0MJL06cbL7IT6Vo4=@vger.kernel.org
X-Gm-Message-State: AFuF++le0i6QuqUEmaawfDdySx0F5I4k6TFMqfEtC5q/ME0TKbH0yKvW
	uS7NQEnfffjNXIKf/PwcAO/RKmLW+8Bie0eMSSDCIMd9hhcyPAlWR9dIXxvEbmFt6IX9l6SMzrc
	FvPL3iyI4RuXT6U4j3W8bWPEVmtKu5+lR4Q==
X-Gm-Gg: AYBFou22vgojxH1eZctoM78Jt9o86P0NYOyrHNxh9mnTXFdjo0TC8SA/uDH0f8SD+Iv
	C4LqmBUF4kzXJavxIZc1UIj3KuyHGibyvE4tA5LFC45E4EtLexU5own4VhGaeJZEdPtbCUPochf
	KO0EHEWF2yNqc5syABTnRBF0c1MZfbrtVbXEANUvK5t0kYJ293p8EVcK8h5Cg0Llzn2ck6vV6zJ
	NFVq8HD7MLN6EPcRxrG4fJXQ4L7epWKW/Bz99o/gtVSjEG4TUuwVvEnIgIB0fl/Ce+PwTJdauXM
	5bD5uZAgDY2G0JMd5BQLbC6iX+i22og1XiFKQjrnl3SH8ZhQRTW7EQLga2GJCBPzlgB9wOwZHYb
	P3LHayyRcmyVdkAc6ngd1igE7csDHEb5Mv7Rl6maBNZtRoapaf+rSWIFupx4g
X-Received: by 2002:a17:903:2ec5:b0:2d6:fddf:a890 with SMTP id d9443c01a7336-2d72634612dmr225105535ad.6.1787939893319;
        Fri, 28 Aug 2026 10:58:13 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-54-84-120-176.compute-1.amazonaws.com. [54.84.120.176])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d7595288d9sm323555ad.15.2026.08.28.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 10:58:13 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1787939892;
	bh=PZqFY5uK60R/5xw6Negun7eGTEaorGHjqlQPmWGNoYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlhWY1YTVrVUpFn2IfTH5Q8uC2Lz9EigFuoTSbFpqx1Mhk5ILvc0vhfqbFqVZ0qS5
	 TrI0hlw0Q4Kd5lB79LS193AXIxWkEM539VvH8r+khQDhQj7eqjYdHZ0s3Buq4V0n5+
	 NL1upoY4bJzSZtgc2zCfyK6tFCTZQlmgtKHS9fsgBjQCwb+FIB60hsdic3KkHh2ImZ
	 fA5tv+Bq9SLZ5myormuySmLxNVkTy8KgjhRulWZFa3dkz+8ZmDH/HUEGO8WP8SemnS
	 90q7HNkLCqk6UlC+k+/1qgtF1w3lLQWi6kY35Nkwg9SxAkI0NuCdEbaQw0i0VBNinP
	 nMnUxEJI7VthQ==
Received: from vm-whiteberg-ubuntu.aristanetworks.com (dhcp-244-90-77.sjc.aristanetworks.com [10.244.90.77])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 75F05C0CE0;
	Fri, 28 Aug 2026 17:58:11 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Tate Whiteberg <whiteberg@arista.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 1/2] serial: 8250: export and rename wait_for_xmitr()
Date: Fri, 28 Aug 2026 17:57:27 +0000
Message-ID: <20260828175733.1650267-2-whiteberg@arista.com>
In-Reply-To: <20260828175733.1650267-1-whiteberg@arista.com>
References: <20260828175733.1650267-1-whiteberg@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Export wait_for_xmitr() and rename it to follow naming convention.

Signed-off-by: Tate Whiteberg <whiteberg@arista.com>
---
Changes in v2:
  - Separate this patch from successor patch.

 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_port.c | 13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

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

