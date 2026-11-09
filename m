Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196285;
	b=I052Rl9MdoQrgrCHOHQq+aCuQDsYoAdvzOveNjPmQ3uLj+EV3l+fUIwAOaefZNosT4Ca
	 +zJcsmElbpi4VmzyPFHLDBLUaEO8breT6zqWvIXLYW6wGE8CgkgiU7gRLjmQD348ZSG1i
	 7J4NXVxxfJWiMKp34bnDPXIxHYx4C6IUy2xtswcTaytt7p9Ay3SGOvz6nBLg3CiIEbtzM
	 pHqxL5R5puCyelvC5IC4+8HgKs6jNQNIQ2Hq+XvFkdWJdruLRwhffM4eZ98FTa/s2ifqY
	 xDgbUi5QGJDDfhpHKpfpFjT+cVgeMHxa4MUrxg/2ML5lu74rxsbjYB7jszNcEKbLz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PCXVp3TiouFUBp+9ys/g3hrJvGOqhB12mNnRiK6VjhQ=;
	b=bO8OVDPyAwNxZhu7TjAXEhVNARD7PEEKPhXRBScFKAzjZ+btT0rSkTTZvpjkgp3R8GC2
	 ZeDqwsI36ohJE8D9x19ZepUwuhaGTbzczedc8q3UdFAuYV7WRDoyeqSQ6K6/MyWXxGYh1
	 lcJKYNpW5RhXkLGEXw0jL1/+0yVl/3Vwwkyw5BzhpcKc4mdy5wwMFVgTSqsbWWX+rrJ/e
	 phRBkaoZjN5kYZl5afL0P4rjqKMT7KCH9Uc2aRyVF1xm6aibBjMan4eQG4Rk2DRu4umHb
	 of0Dhj9e0D7zJLSEQ/sSvOXhDC8gZXvYaa62OLwJzrHDm4UcsQdZy8BFYziTAxewT1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x1UMBJu5;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F14606D812
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 03:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F14606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x1UMBJu5
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8439fe796ebso253588a34.3
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 19:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196284; x=1794801084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PCXVp3TiouFUBp+9ys/g3hrJvGOqhB12mNnRiK6VjhQ=;
        b=x1UMBJu53Yb/TLUJHtAjmL/MIwmZU18KvEpl9CcUAgwqR2nlac7RKBegYGqv9ST/p+
         ciBM9BSEPiAHwURUQKr5DRHLcgKmtaOAVaN8kp7SZXUvwUWItxKKdLx0Y/IFkY4HFhf5
         II5QikIFyY3+ltI3TAMIL8NT7abKojFrPxbqrnYZSwpLOHSjIZbD3lSr1IQQhGTcxPzZ
         QyP+SyTihb1BZUb6pJC/mTWeD+dRu01Wm9ODX1mAaKLFEjFLDx9fSmsZbtgJCmUy/L1T
         YodywidTr011IRxXDCqpdCXsRki3s4OZDcTMLW7p8tKYHPfPrdzS8w7WNF7Hi8ep5mOJ
         FKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196284; x=1794801084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCXVp3TiouFUBp+9ys/g3hrJvGOqhB12mNnRiK6VjhQ=;
        b=OeV2QcOSLh84s1IHqcZ4HfviLqiXdTi97Pz1jwuICyfyyi3qCFROIhFXEQEGBQEx/Y
         x8OBhd9IdX952RUpgtT/Ru/yDIAUmTUBBEEWNg5djZqzruxeuoCVhsudtq0hMmG2pmQa
         ZFoFUwNp3117tPfFBXd2LWq6CHiu2R8WW+bK8ZSjrgT/l7Fjo+fiL5IUzhFRXCunLG9c
         wAyy0ZZxJD+823pJogGV2CBoZZqmZgZylJq9vAzI05zRC4nLlrfvHpkKReczOtBUNwbL
         Beh9JpvzJ3TiRBltZKX2Uwg37HMGx3BjXPr0RYkbczSpfeAoGTwcfZUCxwvp4SZg+Tfd
         EzLA==
X-Forwarded-Encrypted: i=1; AL+hErECXQFhGko79mzWXHSl90rQRB9kiWFXT8O1ijsWw/7Yo9ugABPMcgfnWVoRjSrkA12avEnG1h6ffmR9/Po=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yoTKlwIm6yMz15b5ToZ/4LH8N7IxEtLowTqheE8OMCtgsq2BW
	Om4nUx1vN8kAvejI5QKbIS5yXXJHK7aZLS+5G6M/Qs94iV2G6o2quDmo
X-Gm-Gg: AYBFou215nF4HtTx9GEQ3HBj1Po798JoZZMScrpVpzbEWRvujL8qgynnW2Q8FQQxOD4
	Yz6hoR3+RJCCOUN4vdaaYMig+kWt2mLVYjAZQdo759QO6qrcvWn5w6qq6rqFddBXKOuYJK8k0Ef
	uCzP5H2Z0oyg/kmwyKZ0OFuIvJunYVd/7nl47nbvZjxN/icktuAaxY/zhquSyORJBkUtC35y3vL
	jzXH6M+Y0wAVGlWhS3teRId+ar7Sl7bDFiGhro6VA5hYwhsP0PM5o59d2Dt4hD81kAi0iJUVU4v
	CjFUPBiX00maVOZg9Qs2ww2FV9wic3tNf49jgQDU/1/4VPJ8mtS67hjaw33JiV5Xdk+YsQBxtyy
	XWr/4pcMn6sj4pKKTqvsp4uhH+7/VEUE3hxPir2JHCnIALiEEF6miK1HwUW9Xs3vDDEY38L/f7G
	f2G2+TTXf5JsSebYN+JJnUlLZyMJ2ARNhAVmLnyFkLJh4KZhBmwjILd/7lgLc8DUomoITIH1LWV
	7XdNSdctmmk0NRjPG49NnoQM0RN4Nd7Pyt+pQauIcpVF6GDsPkjukTRBZwmMs6arXTYwFGVyfg1
	VitHVMbWHxL+FDDspYTmGisz33pGw/dfl9NXLm0omeB2ShD7mSe8UEeqyDjQDnCwxJvsE9fJoFF
	V7dxBU6A3SZiQmTCkE4TCQ3luh6N6hDTxCdd5eSMgeBH5jxRptGCI1cloYm6HxyMDBAmyuYd5P6
	Y5wYjwKeyqoOUU47rEeZSfN+qgS1Cv9Zb8fwJKYbeCNUQD0GcsFgZb
X-Received: by 2002:a05:6830:928:b0:845:156f:58b1 with SMTP id 46e09a7af769-85f50847937mr2643447a34.24.1794196283700;
        Sun, 08 Nov 2026 19:51:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:17 -0700
Subject: [PATCH v10 8/8] serial: 8250: retain DMA resources when
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
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
---
 drivers/tty/serial/8250/8250_dma.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1ea22954150c..a279e3a1a845 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -528,6 +528,53 @@ int serial8250_request_dma(struct uart_8250_port *p)
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
@@ -537,9 +584,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -551,7 +598,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0

