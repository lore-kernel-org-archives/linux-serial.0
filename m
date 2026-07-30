Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F2426697
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440385; cv=none; b=cYk/wJsQF0ZtJtkQo3fIyVJ4zHqpR1j6K9qq3SF/A6naEwuUnccwSlza0VwzfFxsXbMNP92OMJ5ifY58214/VbLoxngJ2PuU8mX7ZfCEBhE1mjcBJO8mPBEX5O5yJ6BQA4kfJ8OkwmJqLPsoO/E/LQvue5oySX70LVREMlk0/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440385; c=relaxed/simple;
	bh=Xek6nAcAxHFWtjTAXAbgJUByFpoNIJp1L8Sni4LGBl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JueP7O2wKqIFFM+PTAUCrTbF16Ljm8fhIJ+xjVphXaHf8c1t0fhE+qT34K8XXaFF9x8K2PzuYwiMtgrL5aLInxLd8USUI2BsQB/ts0yapb/RThCntj0eI2cMRgiWlxrBkhbUQzLD9nLvTE9Ju2MjXDYLpLHHYp9uilmu38jpD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtdAdN4/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtdAdN4/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930f618435cso13167385a.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785440382; x=1786045182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q6CySGkLA59m8l/gGJ5sKhCAFzbLaQDYRMPErxTdJ2I=;
        b=CtdAdN4/GfEdLyg43GhFfgy0K1fzVoIHwwWAB5aqigR1jq3GVpYqd8my8kiv7ktNB+
         gt6TlZY4T2ms0cDE+hf+La8Dwjy24P95xh9i/Q70TK9lxaUxETs35EWeTbC1yVGew40b
         aPEd8hJv+tbqZKSKK9flzGPuuMK0z6jYvkDXvwTqCa6d6smGPhkrAn49I1WCqrOT+P6z
         /M34DufKAoM0HE7/476ni7XXSm8JLQ9t25Eo7NufVsDuOEAN+PbeEIwaxZV1X+YrYVWU
         /D9dBqgsFfZ5US0NR7JwtV0uyc4555fZSu+/SDdmg7LsuMH0SRQVscrgcaXroJG9QM4e
         kmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440382; x=1786045182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6CySGkLA59m8l/gGJ5sKhCAFzbLaQDYRMPErxTdJ2I=;
        b=QoFHlhF6kF/Ms54L2Cv7+WNEDOzq1ocJBMCcfvQg8w2Qmi0ZmbbU9lwHn19A2MaYzZ
         NYn1c+Hhrt07B5ajU8rlGzkRgcUfqd0OPWHSYC7g9SJ3XTX1bjx0d4dUxy9yUaTFe5BN
         4U4GP4/c6LQdftDEhtWcLdUjV/Zm4d6FizlQguQhz6OwR5qeW0/49Uyp4G4I61hxqHJa
         wkIhWOaREHld1bfS9432z3OGhZFz8BHv+2V3vIYXliOtaTSLuTIhWamsIhfn96DdEgP2
         gR06KDeSxXd4DnnC3r34YmfcApfWpmpETL4XUPCOTujzAtHfHsKZQ0htwG1BPmIym11j
         mJGw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+QJcD5uFJf2WI+l9Q8ys96XFbWuX6ekOKQbpiniN4FRWW1zK6PXovyfW0W9RKEdbemMgfC9QBb097WsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuGYIqTrA3hqAveg2sJBJiX3TDd/NBzYxzoBPmP8q41nsCMaG
	Azk2MuUGUei6ow4i4VU6kEdFWlwzNHg0vf9nv6p6IAowPLtMQgHzvuA=
X-Gm-Gg: AR+sD10bFk8eJCYnS0gXKHJ18UoNCY8EiKlM6WUVnzSKXQ5FroIN1DHiEVndfLwtjRT
	QMoFubaPorsR2hlaTwk7E/bRRVcuYb1cU2ykhzcwv276mEvF2bPvSHc7h2OJKLFtEDMF0WnJ9wP
	swI7H+hm9kibUQAscUbG9uCs4NK3qcNI/u67M93iruFdSehhwxjkxWTlS0tuNipVtb3IoYSjnj5
	MBmScXv564O9F9qYNpb0hEkRK3iE3rhY5h+DvTGmHnQuEzaPurfweqaVtl9n+WHsY4lVwx3pPvE
	C5e/qblwtzRhTsMBIU9JeLFLnCuWkFpednIQcJAZQIZsXTlf38X0QzzsHo/DJC8ymyeaYpeOiit
	LpjTbFrZNvKevH1Qd+8sHFh4Jp1pPXDexbxQHjR2iE4irko5OoZk3umSrhfWI/OhRDhDau6StHP
	RzIBLliX8DFCurjn8mB0BYDQURlSHR2VbvlHLBY7FFtd5cbq+J8+e4hXxxtr4LLcF0WCafoqSEO
	wIgoMKyFVP/yaElK+wXyJ9uuubEN8UqXqhRN/5OgzoIrgU8oW44
X-Received: by 2002:a05:6214:54ca:b0:8ce:e651:5d63 with SMTP id 6a1803df08f44-90834753f59mr46487746d6.31.1785440381934;
        Thu, 30 Jul 2026 12:39:41 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9083231957asm24537616d6.16.2026.07.30.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:39:41 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Wilbur <rwilbur633@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx
Date: Thu, 30 Jul 2026 16:39:20 -0300
Message-Id: <20260730193920.28954-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP LPC32xx UART (PORT_LPC3220) can latch an RX character-timeout
interrupt while the RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT
(0x0c) but LSR.DR is clear. A character timeout is only cleared by
reading RHR, but serial8250_rx_chars() reads RHR only when LSR.DR is
set, so nothing ever clears the condition. The interrupt is
level-triggered and re-fires immediately, so on a single-core ARM926
the resulting interrupt storm livelocks the CPU.

It is reproducible when userspace repeatedly opens the front-panel port
(ttyS1): serial8250_do_set_termios() re-enables interrupts on unlock and
the handler then spins forever with iir=0xcc lsr=0x60 ier=0x05, tripping
the soft-lockup detector in serial8250_handle_irq_locked().

LPC32xx has no dedicated 8250 glue driver, it's driven by the generic
8250_of. Add a hardware specific handle_irq for PORT_LPC3220, wired up
in of_platform_serial_setup() the same way fsl8250_handle_irq is
installed. The handler follows dw8250_handle_irq(): on an RX timeout
with an empty FIFO (LSR.DR and LSR.BI clear) it does one throwaway RHR
read to clear the condition, then calls serial8250_handle_irq_locked().
No real received data is ever discarded, and it is a no-op on healthy
UARTs which never report a timeout with DR clear.

This is the same class of bug already worked around in other 8250 drivers;
see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
which reports the identical iir=0xcc/lsr=0x60. See also
UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

Cc: stable@vger.kernel.org
Assisted-by: Claude:Opus4.8
Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
---
Changes in v4:
- Add MODULE_IMPORT_NS("SERIAL_8250") so 8250_of.c builds as a module.
  Now calls the namespaced serial8250_handle_irq_locked(). Fixes the
  modular build break reported by Greg KH. Reproduced the failure with
  CONFIG_SERIAL_OF_PLATFORM=m and confirmed v4 builds cleanly

Changes in v3:
- Move the workaround out of serial8250_handle_irq_locked() into an
  LPC32xx-specific ->handle_irq in 8250_of.c
- Skip the dummy read when LSR.BI is set, matching dw8250_handle_irq

Changes in v2:
- Drop the PORT_LPC3220 gate and handle the spurious RX timeout generically

v3: https://lore.kernel.org/linux-serial/20260722140353.115899-1-rwilbur633@gmail.com/
v2: https://lore.kernel.org/linux-serial/20260720131123.29840-1-rwilbur633@gmail.com/
v1: https://lore.kernel.org/linux-serial/20260717123530.481021-1-rwilbur633@gmail.com/

 drivers/tty/serial/8250/8250_of.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index f0537fb6ef4f..b1561c499acd 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -82,6 +82,40 @@ static int of_platform_serial_clk_notifier_cb(struct notifier_block *nb, unsigne
 	return NOTIFY_DONE;
 }
 
+static int lpc32xx_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int iir;
+	u16 status;
+
+	guard(serial8250_rpm)(up);
+
+	iir = serial_port_in(port, UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	guard(uart_port_lock_check_sysrq_irqsave)(port);
+
+	/*
+	 * The LPC32xx UART can assert an RX character-timeout interrupt while
+	 * the RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT but LSR.DR is
+	 * clear. The timeout is only cleared by reading RHR, but the core RX
+	 * path skips that read when the FIFO is empty, so the level-triggered
+	 * IRQ re-fires forever and livelocks this single-core SoC. Do one
+	 * throwaway RHR read to clear it; a healthy UART never reports a
+	 * timeout with DR/BI clear, so no received data is ever discarded.
+	 */
+	if ((iir & 0x3f) == UART_IIR_RX_TIMEOUT) {
+		status = serial_lsr_in(up);
+		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+			serial_port_in(port, UART_RX);
+	}
+
+	serial8250_handle_irq_locked(port, iir);
+
+	return 1;
+}
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -185,6 +219,9 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	case PORT_NPCM:
 		ret = npcm_setup(port);
 		break;
+	case PORT_LPC3220:
+		port->handle_irq = lpc32xx_handle_irq;
+		break;
 	default:
 		/* Nothing to do */
 		ret = 0;
@@ -381,6 +418,7 @@ static struct platform_driver of_platform_serial_driver = {
 
 module_platform_driver(of_platform_serial_driver);
 
+MODULE_IMPORT_NS("SERIAL_8250");
 MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Serial Port driver for Open Firmware platform devices");

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.25.1

