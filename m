Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8D3AAF52
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223132; cv=none; b=Nf2H6gCPnTUHdQQMNTgDTH/mzgZkbGV/24q+800X2j/jhFSvVdjCVMe7ghy495UAwVhXDIqOZR9ZNE8uasT2tCsYUvq02ru5kvAGbxsu5QPPOY0fcLkbOPGXlkzlFHpBNi23xdwLCubjk8nZYlEZDXXuZ5Jshaa2eH4ouT0Vllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223132; c=relaxed/simple;
	bh=qPVWbcybtA2FbyXQHtXtzDhQM1hYp+5hZUiApPPsn60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oriiDohfHaFPA2pE7OOdaBF79Ozmt9tfcVoDNraCwmtSgpo6swid1hLiylnO6Un4Mlrz+a4hYIZP7DfUopavVZXMEMWXkvvsbhWArknSiXMR2EZaZ1rL8yuzL9sE6YSrIfC7d9vo5f1WXwl41uRLMboJ3pEjrI+BXZqk3VGfvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUDWkYbX; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUDWkYbX"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99071945aa7so380594241.3
        for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792223130; x=1792827930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+MRhp20Qv6qzPEtCEOr1Z9CVtBjcSUa4+hS0qMlh6k=;
        b=BUDWkYbXQgl/YSuZcGfYXKjxUAoL134/L/AZRKLTVBSZ3S0lHQ8lnN6P3pjUDq5Kdd
         oi/ergSOOdtGdGEG6cCSAiwnTyNQGoaKnlOyCex5PNUWdBvIxp0yrJbfJTcb4yMqm0SY
         7YkjhUDHIuMjsErVEALo3Xef/jE8dBEUHRF/n7tYMHsi+JaW4FsHRRH+z6fpv9JtQB2p
         rFr0ZjjitRn5HXR5bWK9KXLZAVtVaWyqxnYpl9bx4T1qfgwIzHFQPV2gjBoyQpV0zy47
         Y5799ZcqNDhZEBtxhCc6ugZdCY8fcnUriufRjnVJ8AN2PA9GTMdSeCLNpHadlKr7Brna
         MX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792223130; x=1792827930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+MRhp20Qv6qzPEtCEOr1Z9CVtBjcSUa4+hS0qMlh6k=;
        b=gyAKI8vZMIArZMl/fcGsQpaXbFry8ZB4LJ0Fb+qqWXXI7QFL5CkxzOIV59121FxFzu
         55nvt6idhz5ZPwZuEOJJVbLF8mk8HUW7qZjQ795ap6RXF39c0VKG7R2NTrnaadG+j/Tu
         e1UMwVp2ff+6NUxLQiP3nkabDVfhJrhAR3khcKr3dV0+o5VqVnpvvQpx409ovWYS/axd
         UMIdVRbXDFib7X3AQFBB8RjMfkcaJu2+eb3wu3ARohETFR+B3ZzmzkKRKzvWBBXLe1E3
         VUEnBs6OuqLF15iEkW3BO3GDUqpj0bUgVSryC2obpoQDvbKt3442o1XNnmT6rjoRRMJG
         b6Bg==
X-Gm-Message-State: AFq9FYKAYvUeaGVBNAhLw2qq+GVexIW8jzeiCffrwiW8USejEhyU0Wcz
	5r7/liozaToNB6JiyHD4/hBgI8FcgEmzIeIF9RnCIAkXZoQOUHuSqqBI
X-Gm-Gg: AYBFou2zQshLBjKTWfJ8EUK180bdxkUCW57GajEWEp5iq9rvTrJldoF3fiaLIPXUQQB
	62Kg34MsYmPm0WjpgQJx9I7ANxwwpAJ9cB7uuJfcryOXmtCurFGDKiZn2f7TIrIvSpMWUHKXAce
	45coKIYmEvlvNQvL9KFy2sUcN9LtIqHMo13XFX9OwsSyeTL+P3zcYM8KZMstSKTljsNa9zEH9GO
	UCjrfEV5jMdJ2fbd9NR3N+PgE8jxGCmHZ5Y1z7lgDW/fIoIoUje8hQm54msdk/4Oq0ALXJCDLhL
	e+3VARKjhjy6Pd1cT+QsbYWrr1DjkVA48KdIal2iCTpEehln8a6e/QtVnXiUGE1fDIDhfYtIaZ3
	2bsZMz5oLPDIJ0qWMSA/APfl/9S0RhcPD8SgYn06XLck/CWjR8CWpieCh81fAmeB9P/73M2uXW7
	l+twhVS7McsMwk98PSzOMiWmDkqHjWy4oftIZF2V34ybi/H1YCakP70VA6Mp31j/ErAyc10uln7
	bvKSzCnuByr8L5xY8IRyqhEK9/s2gQ0P6XN5CyiKqmXN739ZfvsploKgJntE7U=
X-Received: by 2002:a05:6102:41a2:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7cc36997787mr569456137.14.1792223130340;
        Sat, 17 Oct 2026 00:45:30 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b53cfdfsm3701836e0c.15.2026.10.17.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:45:29 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	pjw@kernel.org,
	samuel.holland@sifive.com
Cc: linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Alba <sebasjosue84@estudiantec.cr>
Subject: [PATCH 1/2] serial: sifive: fix NULL pointer dereference in probe IRQ window
Date: Sat, 17 Oct 2026 01:44:52 -0600
Message-ID: <20261017074453.62645-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017074453.62645-1-sebasjosue84@gmail.com>
References: <20261017074453.62645-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Alba <sebasjosue84@estudiantec.cr>

sifive_serial_probe() installs the interrupt handler with request_irq()
before uart_add_one_port() has run.  uart_add_one_port() is what assigns
ssp->port.state, and ssp is allocated with devm_kzalloc(), so
ssp->port.state is NULL for the whole window between the two calls.

The handler dereferences that pointer unconditionally:

  sifive_serial_irq()
    __ssp_receive_chars()
      uart_insert_char(&ssp->port, ...)        /* port->state->port */
      tty_flip_buffer_push(&ssp->port.state->port);

so an RX interrupt taken inside the window oopses the kernel.

The window is not purely theoretical.  probe() programs TXCTRL and
RXCTRL but never writes the interrupt enable register, so IE keeps
whatever value the previous stage left in it.  If RX watermark
interrupts are still enabled there, or an interrupt is already pending
at the PLIC, the handler runs as soon as request_irq() unmasks the
line, with no timing requirement at all.

On a HiFive Unmatched (FU740-C000) the vendor firmware leaves IE
masked, so a cold boot on that board does not hit this.  The realistic
trigger is a handover where the previous stage leaves IE enabled, such
as kexec into a new kernel while the UART is in use.

Move request_irq() after uart_add_one_port() so the handler can never
observe a half-initialised port, and explicitly mask the interrupt
enable register during probe instead of inheriting whatever value was
left there.  Unwinding is adjusted accordingly: uart_remove_one_port()
now balances the added port on the request_irq() failure path.

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Sebastian Alba <sebasjosue84@estudiantec.cr>
---
 drivers/tty/serial/sifive.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index f615701fc..4a445d285 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1046,27 +1046,30 @@ static int sifive_serial_probe(struct platform_device *pdev)
 		     SIFIVE_SERIAL_RXCTRL_RXEN_MASK,
 		     SIFIVE_SERIAL_RXCTRL_OFFS, ssp);
 
-	r = request_irq(ssp->port.irq, sifive_serial_irq, ssp->port.irqflags,
-			dev_name(&pdev->dev), ssp);
-	if (r) {
-		dev_err(&pdev->dev, "could not attach interrupt: %d\n", r);
-		goto probe_out2;
-	}
+	/* Mask all interrupts; the bootloader may have left some enabled */
+	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
 
 	__ssp_add_console_port(ssp);
 
 	r = uart_add_one_port(&sifive_serial_uart_driver, &ssp->port);
 	if (r != 0) {
 		dev_err(&pdev->dev, "could not add uart: %d\n", r);
+		goto probe_out2;
+	}
+
+	r = request_irq(ssp->port.irq, sifive_serial_irq, ssp->port.irqflags,
+			dev_name(&pdev->dev), ssp);
+	if (r) {
+		dev_err(&pdev->dev, "could not attach interrupt: %d\n", r);
 		goto probe_out3;
 	}
 
 	return 0;
 
 probe_out3:
-	__ssp_remove_console_port(ssp);
-	free_irq(ssp->port.irq, ssp);
+	uart_remove_one_port(&sifive_serial_uart_driver, &ssp->port);
 probe_out2:
+	__ssp_remove_console_port(ssp);
 	clk_notifier_unregister(ssp->clk, &ssp->clk_notifier);
 probe_out1:
 	return r;
-- 
2.43.0

