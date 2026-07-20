Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60F419FBC
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553090; cv=none; b=sP8b5aOAj2ifzJ9IoVaRYAuTT2cLvGGXeqacHn4Biw4ufq29mK+OvSindEFZngElpOyMRhNwsCBze8hq1iDF/CrvFDLLPWrL0UyCniPiUTphHL00JiAqmInzkZa/lOyom4WxulJ2wgcs6AFEnmg4XmFEvlB0CnFR7t03U61cBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553090; c=relaxed/simple;
	bh=Ic1mjyhG74UKb3Y9WRfTc4sM8v6bo+xZ0k8sXMFYhoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b72poUaNdGtnpM22CAZU/Lo6QCNzTm4Ad1ammwFPu58i7XzkOSk0hvhbCl9Vh7XDQFZ2MF/WWvXQr3MJZpaCEbJduP1kAPalASpMi8XGSCebZpu1zl38gq0FSp/+l3OHi4wjhjxAwZwWG5wSDtUnqk5xv/OCi64BYnyNP8/AQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owFADj4T; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owFADj4T"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efb708b1a0so97221216d6.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784553088; x=1785157888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQ61Qwl4wNBqojEyy6dBtjcn4fhIUIzUAIvLJbLRdSU=;
        b=owFADj4TX2D5vwkBFt1J+Awop72VivILRED1280s76Ax62QlBHkZiIqnt9KBD9dRI6
         m/HC2iKKv2/NVTOJst1EykapER461asGimRonIUWJ0DAAGMAHuhV8rf0BHI64Dr5KgE6
         N8QBbw/m+E1WSl282ZP9JsP8xopn9guyWolwG/OawsP9H9O5IA9TdXXzjXRJ63VfZjKg
         qHLAAA5irBWs9GL1Rv67EB6y2EIrty06UbRyMbWmuViwqhn0romblAC4qSdnstPDlVLU
         wJaim0vIakFQIIomo2QYeesupnSUPXBXUu86u2bVaH4tQWOF6aU624gKTrhGgcP4ksqt
         Z1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784553088; x=1785157888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQ61Qwl4wNBqojEyy6dBtjcn4fhIUIzUAIvLJbLRdSU=;
        b=TxrfURwrVB2ZD6yoYptvNm8ib+VJ0QXXdNDIak4h7mHsI+wU5ihY7WB45/s2v9c25T
         U8wjb4emydB5sCuWCtG8hziaGn+3czVSxPZvqfi7y2Mi6+xs5DVbW6PErZcfh54VVbgF
         UIdMuvuSEiLt2QxHppx1b6V39UyevRSGvCg5Lf7zDyPojv3FWCO7vlfx/TiHjab9pd83
         lEsTnDeki3ePi70Lid2tUSddmObkiGHzM9cWBdnVEFJNldHt1pCjAqRuRdIEu1OxDEyO
         UaJOJ/ge/Elg92dwBvqP2UFeaaPW/zWW+WtJ2ppf3XLHUe7VPX7ggc2Z9/SReFyEP4If
         n8nw==
X-Forwarded-Encrypted: i=1; AHgh+RpFXKbK/Wfo1pT3Zr7yyNCYF7uGDqzYkV1GzV4Zip6s0aw7DAqbwfcV0ogjf5rrBG9XzEcAbPKjFHJ3JyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYsfTAqoQ7KOK/7l6HloxC8rc3d0w9e3qRVKQhhDka1GDbPkO
	fjP5l+ZaPqxgRwrOzj/l8LWBxZGIyhdoR/rBazGLJYUpIfR+nyVxSU8=
X-Gm-Gg: AR+sD10Uxu1a1rkwcGpF3ca20E84KTeoy/hvY/fvYlUghYHShNHN6gFPctScXyXoCdn
	DvjdAcDgVMepTUKRXWBZ88MuFxnuygwcVgLBTZgVUwpWoHPvLPXKTY03nAtYjeiIX+IbyyikAjV
	s9zKknQbqyIoIQJzO0DywpXGnI1vBqmW7ecyBBAcH/+xtjXdFwm9aeSx8d48d2AGs7QkKCfolTK
	kC8YYZ8+LKreiYrTUcDXFCKDQ7mUSHtKdfmL0T2alJUNzjEX0VTK8h/msk0aQbDJxf8CpiaSW3F
	uVUmXHoWg9POJ9g8HMeMKwBFsT3FzFrVmT5gFmkl8WBCu2x+clJS/8ZXssRVASUwECuG6K6qA+3
	cgnjlKdSXK5ejL2FW6W0c1s6wmcEheXQkmQa3pALOgsbhhDVcB1LYr3f4iD+wGjo4QHcILosWSA
	9Jzppd6R69bMamxZvPs4DQvFQrxiL8CDHLPKIkHMxdRj9JyxZMA6+0nLI=
X-Received: by 2002:a05:6214:5886:b0:8b5:e126:e77d with SMTP id 6a1803df08f44-90778345ddamr154463306d6.8.1784553088200;
        Mon, 20 Jul 2026 06:11:28 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9078b6d8cd4sm61211476d6.29.2026.07.20.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:11:27 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	john.ogness@linutronix.de,
	hvilleneuve@dimonoff.com,
	m.felsch@pengutronix.de,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Wilbur <rwilbur633@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: 8250: clear a stuck RX-timeout interrupt with an empty FIFO
Date: Mon, 20 Jul 2026 10:11:23 -0300
Message-Id: <20260720131123.29840-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some UARTs can latch an RX character-timeout interrupt while the
RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT (0x0c) but LSR.DR is
clear. A character timeout is only cleared by reading RHR, but
serial8250_rx_chars() reads RHR only when LSR.DR is set, so nothing ever
clears the condition. The interrupt is level-triggered and re-fires
immediately, so on a single-core ARM926 the resulting interrupt
storm livelocks the CPU.

It is reproducible when userspace repeatedly opens the front-panel port
(ttyS1): serial8250_do_set_termios() re-enables interrupts on unlock and
the handler then spins forever with iir=0xcc lsr=0x60 ier=0x05, tripping
the soft-lockup detector in serial8250_handle_irq_locked().

Fix this by doing one throwaway RHR read to clear the timeout when the
FIFO is empty (LSR.DR clear), so no real received data is ever discarded,
and it is a no-op on healthy UARTs which never report a timeout with
DR==0.

This is the same class of bug already worked around in 8250 drivers;
see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
which reports the identical iir=0xcc/lsr=0x60. See also
UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

LPC32xx (PORT_LPC3220) has no dedicated 8250 glue driver, driven
by generic 8250_of, so it's handled here.

Cc: stable@vger.kernel.org
Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
---
Changes in v2:
- Drop the PORT_LPC3220 gate and handle the spurious RX timeout generically

v1: https://lore.kernel.org/linux-serial/20260717123530.481021-1-rwilbur633@gmail.com/

 drivers/tty/serial/8250/8250_port.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8c241ec7f4f2..c63c4165105a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1803,6 +1803,21 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
 		serial8250_clear_and_reinit_fifos(up);
 
+	/*
+	 * A UART can raise an RX character-timeout interrupt while the RX
+	 * FIFO is already empty (IIR reports RX_TIMEOUT but LSR.DR is
+	 * clear). The timeout is only cleared by reading RHR, but the RX
+	 * path below is skipped when the FIFO is empty, so nothing clears
+	 * it. With a level-triggered IRQ it re-fires immediately and can
+	 * livelock a single-core. Observed on the NXP LPC32xx
+	 * UART (PORT_LPC3220). Do one throwaway RHR read to
+	 * clear it. A healthy 16550 UART never reports a timeout with DR clear,
+	 * so this is a no-op elsewhere.
+	 */
+	if ((iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
+	    !(status & UART_LSR_DR))
+		serial_in(up, UART_RX);
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.25.1
