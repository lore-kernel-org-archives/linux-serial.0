Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661291;
	b=wcggI/dQejNNZK/ihMFzuumxA4GHEpc4qL6Y/qK1YUFoNi/SrqPHDSXtONiQ8ugjzLfB
	 rlhdaFBUKYBxRDP1A9m/1hxn2WgQ38Kkl+DnHVq3/oH/w/+b1fgI1hpj8tFPVg/fcRwfX
	 G5DwNac6Gt8goX1Mi8sUWxK4r3T98s1L6+lvZPpTx8ImI8pqemZ8MqdHqA6X7n1xTSgU4
	 OIHJq9yB4eGpRTWzgXlY/dKCSmCChXiaVqSJXc7z+rGCc5wsQgetER00HlDBFvjGfz1qC
	 wxEfqBwmuvJ3KkuAkmI+QmG5Cz5vNiWuWe1F+9JTJcEMSDGRlGusXtK+I+CKW6jBeCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+ORORHppGTPyJBRftk3KXjGyfdJJh/FdBHFC+AmjObY=;
	b=p+50sWB3qEPAVv9rgw3C2ggC31qLGhY99PBz+4sIC5jUXhKifjw+N5hbOkv4lBXrGcMN
	 FxhGxMOlCTNcPHzOLpIgNm38UKYmWEDV4KScdf5rVEsJB/YMDoLsuX1sEmMsEtYN3LyRt
	 q0zKknO+cgzpRVoJlMNul2pHiTWaRosnzhmx0v33Bzy9XoBGdKKG+333xxsc1ng5Fprx3
	 g95BQtIMWK6VITU9cXOPmOsGLI4YLz//6tSeCVgXK6pZ0F+GF4REa8po7TyHChBNe4KNr
	 SPeZt4pPTNXTfRFbvP9tsYgONu82yJLDbc8Hl/jdTldDu7ckqlLdmilVYZ3PRHXxKwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oUUu4MGw;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AA608362A
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 045AA608362A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oUUu4MGw
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6aa9606ddadso2777766eaf.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 15:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661290; x=1794266090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ORORHppGTPyJBRftk3KXjGyfdJJh/FdBHFC+AmjObY=;
        b=oUUu4MGwHwZ8+XEdn+DK60HxzuRxzbLwaVW9KUdmOyN1/D7ylVTJoTBkJnXq0TpQMQ
         mtvxCUrMdRHxx4vLSHTeEBea96qhiZ1u4KByOUHidRgb5MKOX22EA3WQxStyB5slc0mr
         hKpYPTD92LFh3j60gcjKzHJkij3bqko04ugt0E+/T3w7NKJzGMjN0wtnWC7PU1AXjyBI
         ihyg1Ox+54MQW6sU9lMEy5UCVic+JeICboRbzhCXgtajRSypRchK3ijiRBYfSPRqOAHz
         toQrlzS3iNZ80CtcrsopzXUBIU4+9tYNpepO2dJsVhlLhsj4cuoRjLusUSP46pI4IkQe
         LYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661290; x=1794266090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ORORHppGTPyJBRftk3KXjGyfdJJh/FdBHFC+AmjObY=;
        b=UUeTyhN4Q6LMcdmR9vOqfgR60CbUeRWa6Y+ys6leHCp90faZGVwIYY6gYrsrAKfW/u
         Elr8NmeeFXuJX2zvIv6aZxh+cCHs2AJrtWwdBWw1goEVbcUAA0LNLUUEmexWjX5fEGJl
         K2oSNAMQUf3BG58gOFZaGLHyXGEnNkucY6cuPJ3H78H4Btby3gpMYkW9OtxVCPcnjmAJ
         7Rv+SSFmRkYqkTpdBuk//ljTUP9Hmrqsqwy1Re8XiK8BSdGDU5wU/KLNDSIPmbnzY7xA
         8onSiJJFgAeqz795NbdBR9jwV/jAN1KHRn5Q72KsDU4TVQ5IBzJv1xQuJw1gA4grDmDK
         KPtA==
X-Forwarded-Encrypted: i=1; AKwUvBw9zSEIXsLrwPZMak2waIx/1oYqaNy850ZJTJkDi7VcX9w8UjDEA0D7RYSZWUpIrwJwIh263osExLqJFzk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc0fin3uGDaAndEAmQDHc6wbw+82APkfl/qVw8EoD6aTt6YqSB
	+dOjPksL0+6DwBjL/szZPk4jym1BYnVsM3f/QJ3eXlyV+MvZTwZ02AvV
X-Gm-Gg: AYBFou0cxu3boxlrcA6gdMZp86iQWVW/OCOL1pGj3sXquQ8eP9YxrQC5HZHe/POJwZC
	Sg/cvLx2OuGcvyztoCnM46vALikr2ONlrQVR/AF84yXBmE6gvMfXTLsG4B2BZIRUW8OvL27oPk9
	p/ihzQr7UHhmW2lkRE8yWbFOp1zsIUGkRyJboEtYu49U6lWP+AmRlp0l8ark6tapPQDc+wl5u5p
	HzMtG8jja1ykddFlb2OwdCZJpA8Y0HbzRUJZbZsidS7NGJs8fyQ4P4r6ZxMiXVU9HZur8Bl+kgF
	IE6UqutCndnSO+XwzmfNEAj4Btd9trEOa3yp8JNpT0DIUQcUVZdulYPVitz+uPSKnFN1Hay+sSf
	mZXMnvwO7lHG6olmujp2Vr3qeut9W6k7n8Dqx2vu/xYCWVzF7aeLO38H3JNuHbiAo48JHYoLOEM
	d4Zp/viiOsOBKANtQZ3sfca9BwbT6x1HmJhPniD6c6mdUna0gjp1nAg7ucNQlZRnO1u3BnYkovT
	UICh381HVYrecLd88nNfTaGLf13YVk7IJlZPOVPO0WZ3BRn1ZEg9xNaUEphsPd6eCcuHaMNbhda
	Wp7RfttdbHjJKcrfFe7JBSUiJ+x/PS8fKAqZki/zVnffFeXMsxVQPmO2Kj8k7/9waRiuHPta1MH
	GKQyYhl8sCv1aQyCIejJaPO7JD+EoFUwu6euFmMslPtYYlh8eIDd4K4TGCt3OFzNZ2tfb1AbltE
	pTiiiwIxf+d9ReZ+9okyQcNGUXsas0ehBIr1kcZiQEEkcDIRtFJ88w
X-Received: by 2002:a05:6820:a508:20b0:6cd:3fec:de76 with SMTP id 006d021491bc7-714f2ab9b3bmr4460157eaf.76.1793661289912;
        Mon, 02 Nov 2026 15:14:49 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:49 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:35 -0700
Subject: [PATCH v9 8/8] serial: 8250: retain DMA resources when termination
 fails
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
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

serial8250_release_dma() ignores the return from dmaengine_terminate_sync()
before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
the channels. If the provider fails to stop a channel, the DMAengine
wrapper returns the error without synchronizing its callbacks. Hardware
or a detached callback can then access the released storage and state.

Checking the error and returning early would not preserve their lifetime:
serial core frees the TX FIFO after the driver's shutdown callback returns,
and port removal can then release the callback context as well.

Require successful synchronous termination of both channels before
releasing any DMA resources. Retry failed channels after a sleep outside
the port lock, leaving channels that have already stopped and drained
alone. Keep the shutdown gate and storage reservation in place throughout
the retries.

Start retries with a 1 ms sleep and double it up to one second. This
makes short-lived failures responsive while bounding sustained retry
activity; neither delay is a hardware timeout. Report the initial failure,
rate-limit ongoing failures with the elapsed time and current RX/TX error
codes, and report recovery once both channels have stopped and drained.

A permanently failed DMA engine blocks close or removal. This deliberately
retains the buffers, mappings, channels and callback context until the
provider can establish that they are no longer in use.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dma.c | 43 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index fd2a0ed21165..6307d0261ceb 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -530,6 +530,46 @@ int serial8250_request_dma(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
+static void serial8250_terminate_dma(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	unsigned int delay_us = USEC_PER_MSEC;
+	ktime_t start;
+	int rx_ret, tx_ret;
+
+	rx_ret = dmaengine_terminate_sync(dma->rxchan);
+	tx_ret = dmaengine_terminate_sync(dma->txchan);
+	if (!rx_ret && !tx_ret)
+		return;
+
+	start = ktime_get();
+	dev_err(p->port.dev,
+		"DMA termination failed: RX %d, TX %d; teardown blocked\n",
+		rx_ret, tx_ret);
+
+	/*
+	 * Shutdown cannot return while DMA owns storage or callback state:
+	 * serial core frees the TX FIFO afterwards, and removal frees the port.
+	 * Retain both channels and retry outside the port lock. A permanently
+	 * failed DMA engine therefore prevents teardown from completing.
+	 */
+	while (rx_ret || tx_ret) {
+		fsleep(delay_us);
+		/* Retry promptly at first, then limit sustained retry activity. */
+		delay_us = min(delay_us * 2, USEC_PER_SEC);
+		if (rx_ret)
+			rx_ret = dmaengine_terminate_sync(dma->rxchan);
+		if (tx_ret)
+			tx_ret = dmaengine_terminate_sync(dma->txchan);
+		if (rx_ret || tx_ret)
+			dev_err_ratelimited(p->port.dev,
+					    "DMA termination still failing after %lld ms: RX %d, TX %d\n",
+					    ktime_ms_delta(ktime_get(), start), rx_ret, tx_ret);
+	}
+	dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
+		 ktime_ms_delta(ktime_get(), start));
+}
+
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
@@ -539,9 +579,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -553,7 +593,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0

