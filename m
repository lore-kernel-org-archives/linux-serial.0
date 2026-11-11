Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435406;
	b=QpA0puYnYhJYH/to16n99anXJSahkGVlhHkjSBMGTTUoowNbLjpmEt4yLiR2PImTgJYd
	 PFkxI5DElPCVTS4ftWHKtDXW6B2pswrJucM0RJOJqdzwO7YE80ThKtSUqtfN5NaZk08JM
	 ODaZhjk92gxSk5fzYr2MY9iN4fWaWnZLSuMbMkEcTBgc3IGiz8Ln2x2hNtSV07YsPwuv4
	 rvBqzPo+cWPhW8VHNNZHrr0VcgijlcrUibLmOBqPE4qhJCtlkCvEBzdRHxWr8v/dpuABn
	 Li3Eg2WKDeEf1M/ijvu0Gb0l8NpnYbRNVbf3rGcmjmqaH5y1It54kRcCzpEyCZ+Xm9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
	b=MqWTlQiqXk0aDkSLxtVIQPE39Nt1ZlIZihzWAFO6jBfEOjd1+xmFM+NmkiY/nLFnO5pz
	 +jXg5zcqc6S/x+waL2w771Shnn5oJZplCBzDHchqwjlcyN0+4s+ObZm3rYSNgzlD+kAR7
	 rowE8rYKQ1l9JgUHQ2XA/PYfM/3QeVjaeAdObHBvfPCjGo1978/IBysHWs7O5KueGPUbx
	 jIJeYAIT8Po4yXz4FpYeXpEszmOb4GcFezeYFinY3eD+tEiOh+0UDAlROUgrCieBcnBwQ
	 LeQOuJ17FMYMIgycGDm+nr7ChsyynyWf7LnrYT3HS+I49lZsJHcxDfOJDGif2BSt7eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Inw4TnAA;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676E60A261C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 22:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4676E60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Inw4TnAA
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-825b40f8a26so1676382a34.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435405; x=1795040205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=Inw4TnAAUGWYGPeZymjF6AzDrvHa5kz04Ejs2ZNTW2FWKWRPNDgoa3CY7S6h1adJEW
         ZSdzhBA/njJQS4+36NSq6yWvJMgnuvOkdCL13qhF1hgZMZ48+CIckgwMxiAlDd7Dx+Jr
         yifcpm/deIHtC4LkRUxIMs7MJ8UCxMKDOCr4EfDjF+p5z6AYqYGI9wquK8UGLv7H/2Gx
         hFJa4yfUaZqafPzhaRcIEssQ5viHKM6J5Iad+udlo8gnJ3DNDc+zazMnPgoUc0mFRg1F
         uCMgAc3ptmTKE1Oqdtd/F9SbGSv/RLib5wXPLadatRjaIYzM9FydKEXG4nQO6hcAbR8c
         w6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435405; x=1795040205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=KsjlBO4xbDnrTs/WR2ODl9T55auxypSFGK9HXFsY7c3mpYMVAKu84oVWXYU7mDvxsm
         kkudz/BhLOxImyDfpuySaYx0//RvwJlt3fLjQIV39tQgT+C8D30el/z9a/iQWyFRiPSa
         b5oKH7oqxLjoVBTKb4Z25+uS0pr+NLJ0uwOE4wPCrC0YgoiPjZw5OuReo6VE1Jteunq2
         cZsWAGoHZutTREEdtA34I/BswEBBhGJ+mL2G8taIio3CvcXqpd1crCriNQbVtTHiCtPG
         765qjPNrZUxFJvW87yAd1gaovf5FA4ln3YNlObYJPU/uyHabeZjb/7vGoi8LaZeymHDc
         vvpg==
X-Forwarded-Encrypted: i=1; AL+hErHSp2eeO3vr5yeAzrvJg12UrAfSQpKbINu118SQZPctx3VIKxKc0UAPsPXG9nAjxOjNo6PedOhdjHlJP4w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DIgetsPUZEWUK8unQOjYQXu/TV0+ZtOdsjYB5hzX8MZ6yFeyY
	5KcrFCwlMWQZqrCtPDINqMbRqXJ8uUH1gxk1vNmKOA21MXj3MvF0BVAT
X-Gm-Gg: AYBFou3ZuRex4JzUHGJfCOfQziy7YGwspXs/dU9hprV4sbCWRDKipLUyCl55NC2itwY
	CzaWdyBGcfjmxipgjEUJ063ml7O234B+5vvGvQ2ksDaDmVFNR482Er1Qd39AiQnAkctKF6++22A
	rW+zwXRYr6/pM1qGOUsXDTR6sj4zQL5zJa/2aFR8oLxgLNmhU7pzv+y9gCC+fcxF1Vmn7KUApDH
	wTAFzfQhoV2pw+oeKFtjyAG+o8mK/FmVzPRNMHfm5YjnjHCu40A42Bgv5oQQ471cUngN2V5NOCr
	csh8BVgpbgOm99vkDCi9U0fju1X+WL5VbaDRDgIhgD+l+Bla+aNcIJPyD2J7U+eytrGmNCNjTEk
	PJxjBuT2mn2v+rW9zmOGLidg9c7XWJ06U/5uY12OI1VUITV4beRRI4XKKRXAdHyFE1Jg3HaYWKl
	KpYiDTG9yVDWp+V64jXaJ4/M/RcjpEVB6I3Mkgto8UY+Zn0CCOvmxo2GT8q5H0ApERHRzBxXFdt
	L7gDaoEKf6TOP7NQT/+qpuEp7ypA8/Sk7j8pFlNP/QVAfve1bxY6UasxX8wdx5m6IyG7LxBOrqZ
	pHxh6h58dLpLKy06PduGQa3aWYs6bv2txXnLByMvAQJw5ckyZFMblbioRMxA8fUSGmClq44dEZj
	K0lOpcLy/ASNdP8QnrnzvXXuhceJbV8NO9iLAMk0UjjN7Kte+tmoH4zHuiDCOeiUnL7CR8oXCMu
	iqPk3PeT5o1fhFbibJaZOg9p/Q26A8hUrEdRfEKGtCMmgPAB4HiLU60laDR2UmOP2IaXjmjKJe
X-Received: by 2002:a05:6808:1902:b0:4f9:6348:cd3b with SMTP id 5614622812f47-56b97101439mr3389720b6e.41.1794435404903;
        Wed, 11 Nov 2026 14:16:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:33 -0700
Subject: [PATCH v12 8/8] serial: 8250: retain DMA resources when
 termination fails
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
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
activity; neither delay is a hardware timeout. Report the initial failure
and ongoing failures with the elapsed time and current RX/TX error codes.
Track the five-second progress-report interval separately for each
teardown, so failures on different ports are reported independently.
Report recovery once both channels have stopped and drained.

A permanently failed DMA engine blocks close or removal. This deliberately
retains the buffers, mappings, channels and callback context until the
provider can establish that they are no longer in use.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
---
 drivers/tty/serial/8250/8250_dma.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index b1f2998e7735..6efeb16fd994 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -565,6 +565,53 @@ int serial8250_request_dma(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
+static void serial8250_terminate_dma(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	unsigned int delay_us = 1 * USEC_PER_MSEC;
+	ktime_t start, last_report;
+	int rx_ret, tx_ret;
+
+	rx_ret = dmaengine_terminate_sync(dma->rxchan);
+	tx_ret = dmaengine_terminate_sync(dma->txchan);
+	if (!rx_ret && !tx_ret)
+		return;
+
+	start = ktime_get();
+	last_report = start;
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
+		delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
+		if (rx_ret)
+			rx_ret = dmaengine_terminate_sync(dma->rxchan);
+		if (tx_ret)
+			tx_ret = dmaengine_terminate_sync(dma->txchan);
+		if (rx_ret || tx_ret) {
+			ktime_t now = ktime_get();
+
+			if (ktime_ms_delta(now, last_report) < 5 * MSEC_PER_SEC)
+				continue;
+			dev_err(p->port.dev,
+				"DMA termination still failing after %lld ms: RX %d, TX %d\n",
+				ktime_ms_delta(now, start), rx_ret, tx_ret);
+			last_report = now;
+		}
+	}
+	dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
+		 ktime_ms_delta(ktime_get(), start));
+}
+
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
@@ -574,9 +621,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -588,7 +635,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0

