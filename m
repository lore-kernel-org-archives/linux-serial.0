Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7734BA28
	for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729048; cv=none; b=oK9wvvM2iHQhGn2PvAuI5ezG/qSJq76ss2Zkf/MMrWoX/EAB2OiysBRSn+FJwrTZVStBbDIHsHGMjuDHS704Ozq/uKquAGeLlswnYTZjJBduY/LKXhDYJFizI0urplXjxKg0CP+nLUWg9Pi7gA7iHq5rsnJBUZa5oL5Nm/g4t8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729048; c=relaxed/simple;
	bh=AT1iOZIgI0G2w/DsDzljkDDBTzqzwW8LnfeB4zK9+Io=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhNzJLYmBuAWvVd3tvz8creX6i75aNudOOoOoXzq5UHnxOSxh6mg5FRQHzZhxqUCDwt1j6OlPaZqdu+hJ9bUjQaSm5kjwARAnCuYJIUSet3id0YdPF0ohqLNEkbbD9Bnbt9MvPPWGU9LSUIFzf79yrKC1gY225q1TFQFuW/d1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWu62Vut; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWu62Vut"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-668432fe416so3824486d50.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784729045; x=1785333845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5h4UrmIJtTrB9KVtsD8cZwtpryJNbIzuhP6tvoigZY=;
        b=KWu62VutmyAnSinBB6pPouaK7XC322d40uJCPyXV43oDe1j5njptyZoOUD1heuxPuF
         mkirojWZzRizKVup3Gja368EGK/9vH4hr7XTM9ER3d2Q0tmZV9hwv5Rovt747AcgInL+
         Bz806ild6D2202siJ/cZbm+guy3dtOpbg+eydVJlgF/gDXT41lfuMdjBNS0gEi54Yib2
         7clTrd4aPt1zPNbpOp6eMuLe2bSyNlTsILrVgj28EnEM+vkBjqpnD6oQBLg4ri4z/Oqo
         tjLme97OZZSFj7e1RaM6dBNyfJEMaxAoG02+rMIMS+ca4TeCHk7We+54ke6qz7ryzwYA
         EZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729045; x=1785333845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5h4UrmIJtTrB9KVtsD8cZwtpryJNbIzuhP6tvoigZY=;
        b=iekTKMb/YQUIUfQBjE7WwmGnjXSylJfXyZEhY0vPyB3ORqN5fkwkUrqovAjJZCjtKN
         NKfeWLODvpoDqbdR5qOkZX6x/GOv8pb5ZdVLl08bHvTepdDm1SiHhYQQVz5vFY/h2Hok
         o3d+3lu5XIVzsSMM595B3mY3a0745AJbIofMYzJlFVTXpofrjB66nlnbvug4M3Ev7kj3
         bLy0dOh5beD4ACcQ/sGNXajEKsHFG6pymRYaOLPPbQx6jUSTsXWnc/QBBD91PqcGKcNs
         mODqNBbdiVAsXe/Ftl49RkzJwzbHFDPVh9jstognOscU60YcB7tZr3S+bVQ4wz14MINj
         p/ew==
X-Forwarded-Encrypted: i=1; AHgh+RqIqBpwIODl7DxpucflTFeJb5fgmJ/n3flKw9FI9FHx2x+g3zvNWFMxJtsA7Nd+ArTZKZEvHQN35WDbex4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWiXM84/CXbyh6I2NZVdFTvd3CDKl8J7rmTXApJLGJhffD7mwI
	uPwYKB25EJbX3iP3yBVTjjGLPSYV4r5Q5H51EC/+uLcrCzT7RLt3mAM=
X-Gm-Gg: AR+sD13JrkfPJEYfSANsWHiWTCQ6jOO1HFwi3RFAQ+nYzv6Ou+cJAWK7hJBuY1+43LJ
	uAR/sEoX2gC8jsdW0+ss6Z4tIuMR7ZI/geGrM2Rw+SpskbZCsIixNWUHteJY+M2pUms7D94heNf
	4w8ihedoq9WVYc2BvDZX2bDEQJjqT5dzoEdqxklcJGROMkrro7E621SNeXGKTForifBRLXiDRuF
	Zx1PmNWOtlx0JRgRmOTjTy//aZjU8IgOSE3BdEiPUd0GTYy6Y4paF6zotXO8i+4Bgl3L3fN2mqK
	CZPrceF3jT5oMC7YruD8tlvYln5yUe/pIrwXJBPmcjrFmqHCJcNjdkftYZuUNZ68NIJ03HZc7Bq
	0/dOyrY2QAq3eKJUM+S4tAfggyvK00O4COtv33PSe4iJCnukSHC9ImGY1uXemcK8MRXl4MJmpbk
	CyktQhVWQ6mwpgnKGHibNQiDStYD6SqBTIv5TiN+2PA0eobQai5tcA+DkF0UT9ERjiIw==
X-Received: by 2002:a05:690e:4890:20b0:667:9d0c:5b80 with SMTP id 956f58d0204a3-6683bb61805mr4722351d50.28.1784729042080;
        Wed, 22 Jul 2026 07:04:02 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa296bcsm21512146d6.47.2026.07.22.07.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:04:01 -0700 (PDT)
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
Subject: [PATCH v3] serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx
Date: Wed, 22 Jul 2026 11:03:53 -0300
Message-Id: <20260722140353.115899-1-rwilbur633@gmail.com>
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
Changes in v3:
- Move the workaround out of the generic serial8250_handle_irq_locked()
  into an LPC32xx-specific ->handle_irq in 8250_of.c
- Skip the dummy read when LSR.BI is set, matching dw8250_handle_irq

Changes in v2:
- Drop the PORT_LPC3220 gate and handle the spurious RX timeout generically

v2: https://lore.kernel.org/linux-serial/20260720131123.29840-1-rwilbur633@gmail.com/
v1: https://lore.kernel.org/linux-serial/20260717123530.481021-1-rwilbur633@gmail.com/

 drivers/tty/serial/8250/8250_of.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index f0537fb6ef4f..93db28a48dea 100644
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

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.25.1

