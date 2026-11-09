Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196288;
	b=oMR/R9yTLHKHw8+NZOddJM9/c54ME3DAK64dKcuy0Eg4/qd9k5/hhfTJ29dnR1IivlE5
	 kGYnLARd2XjcD9rod72h2bYuluJw++CPLlRSzaKOILc9CitJdIgJUbOwlPJ57Jo7PNzqT
	 MkCGOTI19x7GaH3LrlCBW56vxng/7EPvnspMuWelBCXkz27LaAcoKowL6Zw+zIlRswbYl
	 O+oBolHeYLNSo77HehFJhjUIh1cO2OWyL3RG6zVdtdQcRexaan2Zx4hshXy+EhUa0bJR6
	 v7jA91xJrULti3gA4J3x9oeLgCeNhO0JqMifvzqNB0b+UfYhhBl1mL/V6t4R6rRhl1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
	b=YZMnwhv1VcAn/J1dnf+ElK8pMjjERM1BVkL5bVGEtRkUS9Qv1Z7/Zo0iwMii1YVBgfhL
	 nw6V6at847+LqDwOYWcl0n0urQMA4mc3yZ+Cru4cknssDJp9zZX6BqXhecL2LnoPOORSp
	 OMYwpEE8hgAJ7X/H1iEYucxXyD+7ouH0C1JAOpnMaR2ASo0hIA72UMvwFFrn/h72L/hP/
	 bcA52Sh6c0/65y1nPV835C+HeTNEjvXuz01b3DiqHHpdThvsa0gFTCU3g8OrP0C0/nnTl
	 p45fItc96SeRdDHQPpKLVLMB0DiBGpht3/dza4N7Wnhks29empDGYw69I2cknoIgM+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmx2PlMb;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A5606A32A
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 03:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E35A5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmx2PlMb
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843b6f8e2c7so618484a34.1
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 19:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196277; x=1794801077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=bmx2PlMbpqjrv1lSw6wlXnQjSbxQojHqc/LxevBMdVlIXWrqHbmvYJr0lvfeImL5uQ
         8MvZvZ2JmHsACsSYyuwiraSMHsgjwbGat6pgHhHUy1k//gqOtwBi1KSg7GCQZdJgxBBf
         /lJ6DmwCUo2HB/bIPXYvyIok8cFk3fHKlKZcYl1dw47LzUMHiDOg7G8goqn8R7f7x98h
         WeBta+QUzvJ/Xw+YeC6X1eg/DffeX6dBu8nX0l9RhV7ntPST/oAwL6gUo2tvusvXr5R+
         Yyv7XreFYneaLbuqh6/BKvzqxCEMu8KcW+GKOhZComUnxi66yCEEz6ZrTpTMhRtz4vMI
         j0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196277; x=1794801077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=vZya4NfVFmYzskzcjJWVItDEa3VHrxuwQaL8b044q8Rh7w45vmaZMtXRJwve9HmGHU
         LHaFrF+gLMh3lFXiZQ8wchRmBnzMxPPWGgbBrquwT/gFA5hU1MM6dsMFSTSGyofTMPcp
         nHYpG0quBpqOzon7d2027yJkY33aka8av0MzJTQTmuPQMD/dYHO6aOTplnZpkHG4BaQ6
         Ty53Qq8cBHJMV8Qrcd5RO6ab3O5ZjSbTSZ3ADemXj2SWX59uPix+uKzvP1JW5ok6VTFp
         xD8UsZs2q2qifzA0ez8q35C86t1CYLtXtcYMWtgkUbu+/0A0mPhMXVWCw3KnfQMLE0l3
         sWig==
X-Forwarded-Encrypted: i=1; AL+hErGXZJOAoTX90as9Yur0jQ/luwHzCZ0GdnI3HQTv3htLC5gZWcAYJ3VLJXqsOaxx6b1b9HE53AjHz60VIF4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ykf7qgjR5hG29CRauDrZ84V07UpWKlRpGFimqtddhqE0dSc63
	d/oBnMW0lhTBCVHtXEqQRnkRKnE1ocNBum00ifiTx+MwUM/KYqjrervW
X-Gm-Gg: AYBFou1IE/ATtVI/xtwrOUdHVo0KdZrV1Z72sfELFk3lzcBMdiesla6vDB8soC000TD
	UPt4esF0lVN2B2ksR9lSupWsmC++QBPEStR+ANCd0FhRjzpqxW/OUcmLwb/n0KJnwldNKKxjLiO
	IsU/bGtJ0MPfKQUV5AGS2ls7oHCKbJx7ZilzFBiSxkHI4ycD1wlZbMHplywtiwKwxUtJN5YMfE6
	Hn6CayNpbJH/8Ya4LHvmAoz1ZVQ39iW2eiuhj3FaEYqPMea37exHpViQNfS9vrnVyh6KjDq+e2Z
	lCXElPNndjiid//L4UFEMKGhsbEj4aYYfcBLJHzHZ+2vu1lqALjfrJ2JSb1QyPPbDXu+/VbkFMh
	Tzaj+LujKcZM+BISxBzh3JNdEyNNICtvKnV8f/zdlzJoqrHB1c1mRmyO3HYNfSMWl8pL1J1n/W0
	3nkOdjd3qh+FkVC32U0ZLrugec2G5lH5Lo6WYkvHgFZdFqG1WepXkdt7WcTVqmz8V21kM3DlXNb
	3/0mg1dLJGy4S587zMEEevtWcd0M9xbqRS3x8v83Ry/tVEQYSN8yrOENWdErcT+42Ut/T8buADy
	JXHTU8X9cbDtCCW6Pq7RArJm1VElweykN9HWtScqFDSXxxeTF2XpPW5Eth1j9HVMO6PzyKtctqa
	dHDAXCrH1ClX/vxenAkmSzsnCQl9FlvIJIXAROmJLCLgown98+B1f65ErZdFeL0UHKNRhSI2MSt
	6ji5jD3FjL9c/qpr6rCnr+ITH3ydKHuMoQUvRtOxw3CKeAWmrDYko7cQ==
X-Received: by 2002:a05:6830:34a8:b0:85d:44ee:607d with SMTP id 46e09a7af769-85f501a3163mr2198462a34.0.1794196277001;
        Sun, 08 Nov 2026 19:51:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:13 -0700
Subject: [PATCH v10 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-4-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

disable_irq_nosync() masks the UART interrupt without waiting for a
running handler. That handler can have observed up->dma and continue
using it while shutdown releases the DMA channels and clears the pointer.
Synchronizing the IRQ later in serial core does not protect those accesses.

Publish the DMA shutdown gate under the port lock before the final RX
flush and interrupt masking. Have DMA IRQ handling check the same gate
under the lock, so a queued interrupt cannot restart receive processing
after the final flush.

Drain the UART IRQ outside the port lock before releasing DMA state.
The lock excludes competing RX processing during the flush, while
disable_irq() also waits for a handler that observed up->dma before
acquiring the lock.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5e114dd8f9bf..51013dd2d851 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,10 +771,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma) {
-		guard(uart_port_lock_irq)(port);
-		omap_8250_rx_dma_flush(up);
-	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -782,13 +778,16 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	/* Synchronize UART_IER access against the console. */
 	scoped_guard(uart_port_lock_irq, port) {
-		if (up->dma)
+		if (up->dma) {
 			up->dma->shutting_down = true;
+			omap_8250_rx_dma_flush(up);
+		}
 		up->ier = 0;
 		serial_out(up, UART_IER, 0);
 	}
 
-	disable_irq_nosync(port->irq);
+	/* An in-flight handler may still be using up->dma. */
+	disable_irq(port->irq);
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -1330,6 +1329,11 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	uart_port_lock(port);
 
+	if (up->dma->shutting_down) {
+		uart_port_unlock(port);
+		return IRQ_HANDLED;
+	}
+
 	status = serial_port_in(port, UART_LSR);
 
 	if ((iir & 0x3f) != UART_IIR_THRI) {

-- 
2.53.0

