Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7139CCE3
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195585; cv=none; b=hsMhfUd8r8M1+MORxaajuE68b/bg8gwul99lEKlHX76itk+oLkImL+yP4dyG2N6EklmghUjDfMBYL53ucklP5Hb11qP040rT3h+SEBzFcp6+vzIUmVwFDbRgYbfYMJAPYT6ah6wQx387Qmb2wboM5DmelVfGGR7NxcBz0JglCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195585; c=relaxed/simple;
	bh=KmPQSw7PJs6b7VbM0BsQfGrrnadbg/gaMHGAH53cHpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=UGMCSJORl9JrkezmalfwvwLbFI+e0EAwrxjSFZ0CdwRTMp826QnPZp6iBiGhqGIWBGsZjaZCmXyUwNZbS291cKVpbgjj/ysOGMxrfRccbVt6apDcFo1l7cdy1QovTUn1Ad6p3OZoZHB1oKY3U5uFX4XbYVL+DvbgCH7U3trz4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Dk70gwNO; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Dk70gwNO"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so3976135a91.3
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 09:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788195583; x=1788800383;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uhpEMVv4B/VVOtxDQtZyuSBsMdjI+x992PqU8euCejQ=;
        b=eOmydRAcYgvqhixdStBEQGoWk4EKzYoG6mpiKm7V82V0mlCJhk68fFs5jeofL9Pxp+
         RUP0FZlXUbxBXE0yTMsJxjKs98Ujjr89A+cpRuVNyTEO4npTnAWQWrGA+eFoJ1zP3mTs
         RU+yEGknwu17VDSoK28qBaotBPMFU8rZ9i9lMmXWcxmRfVmLUtDiWwdLSP2kSGFXiXlk
         eQCHa7PGsuNYQnj/7pW2WLmGiDGbQYMTtJov4XglyFQyO98MoN1IgfbfsCrrIke4+TNW
         4xn6FlefISfzr6HWjbDLl4XZEFjWsYNgGhGwC0KgR28iuVHLPJTLbByAcN+xo+5Xj1UO
         2uaw==
X-Forwarded-Encrypted: i=1; AKwUvBx+9RzaMO5PMd43iCpAKSznY8JBb01KnusUUeAkVCOnmts2IzcaHLrqf6aTgf6BaK+S2/cnWMw/NxylsvU=@vger.kernel.org
X-Gm-Message-State: AFuF++kltZfL1YLwM6/oudRbg77FtzF4bFHbmkSHbJXFDBflf4Oit+v5
	gYAIHnb1AaodM/u/Sd+JtwX2PXOuSyY0zFE5WFL03ZuR9pECU3J2ZEl2JG5sT3dzlxtbunhbYVB
	iuaa4WaoR5lh0njCUCmM3dDdyydAllKoLRw==
X-Gm-Gg: AYBFou2+9eHty1h6T6N3MT8X5Or40KGIENmU1xfvs7g9pHBRHqulKnPgUfGLGGqAR5v
	QLN8yYjVES7nC5WHjhyuPuXqyBo3jWvthh398O0dJ2ndpSZ7uHmz0b7/hKV9LIrk4RyT545e/ph
	hVHBRJxxS71kYNnDfskVvIpaJ8jMxU6OgoRMZc7AMu3RKfPOu364EnmL/pQKmn6xjghTd/2uePe
	5Y0GrPg1x5bbB/tBHOV4Ss0A+I8dvotD1qp//YwoWqAUBosCuNTMQJCWU+v8fzbPIP3wdzuFa1T
	H5MVUcJ4cioMMOZYNWvtURL0TuK0U3DCtcGdoGQm8AZ4KwunPWw4yZP3NfHGQLct8ZM4jNrFJPH
	1hX0b9mtWyWkUK9pV7YuZ+UNxSJPIWikGIiIg4nzoQuN8ryYLV4/Lm2E2de3GDTZJQnWT
X-Received: by 2002:a17:90b:1d05:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-396d0ff519cmr42557072a91.14.1788195582503;
        Mon, 31 Aug 2026 09:59:42 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-52-52-135-65.us-west-1.compute.amazonaws.com. [52.52.135.65])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-396d6e24cb8sm1037426a91.3.2026.08.31.09.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:59:42 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1788195580;
	bh=uhpEMVv4B/VVOtxDQtZyuSBsMdjI+x992PqU8euCejQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk70gwNOeoJREOUEBOnZ3+wiE6lFDwpu3gr6k6MKjVSQGn41egvhM/cSag4Bm9SNP
	 F/KA8nYIsKaISUnTHoKTXoLLtCug+VMV1nQnW9IDiqdyw+c81FGjJQ11YhVgRyJRWQ
	 ghzbJ72tPyAc4s3AtwZqBdptzeRML/cVC/O24oAL5DAJyPkqfPdml4zuc8tQJqutfw
	 9cosQH23JV07va8PBAwEsQLwE+FcYhJ17XhNQRJwfz2rQWqvllFD/HKMj3b/etryPd
	 1416NwLWJNCjdtznRAEFn5QD/DncKlphG5bDGqjUk1SxzjA4E9+yf+TeKj3LJz9DAb
	 bDM+IKkp6/glA==
Received: from vm-whiteberg-ubuntu.aristanetworks.com (dhcp-244-90-77.sjc.aristanetworks.com [10.244.90.77])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 9FD8CC2E81;
	Mon, 31 Aug 2026 16:59:40 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Tate Whiteberg <whiteberg@arista.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 1/2] serial: 8250: export and rename wait_for_xmitr()
Date: Mon, 31 Aug 2026 16:59:07 +0000
Message-ID: <20260831165911.2029839-2-whiteberg@arista.com>
In-Reply-To: <20260831165911.2029839-1-whiteberg@arista.com>
References: <20260831165911.2029839-1-whiteberg@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Export wait_for_xmitr() and rename it to follow naming convention.

Signed-off-by: Tate Whiteberg <whiteberg@arista.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---

Changes in v3:
  -- None

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

