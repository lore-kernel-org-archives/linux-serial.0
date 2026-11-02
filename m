Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661283;
	b=qAcu+eYS7MbF3EigfYLCXs8V3MUFpddwOme3DlRIOA1qE9cdEhrZ3yOX/98SnY8GoBDZ
	 Dxe0916EGq4R5yU26dwmnZy93hhSPCAJi7lu8crOO+8eHvH3r/6m6pb7yLxJ16+t0SCcF
	 E5nYCMzXa3Y4b5WlKNHvhc1HkbckRxR5TxKLl3l/bNzIOPwq05mrvKrIViaZI3OK1iTL7
	 0x6kH40ZowNcWqQKhFtiWQhim/Gb1LgNTudAKNJDcFGWnexzc3Kd2LL8S6otBval/731B
	 x0hRyTDpD6miTwtClaBUeno+bhEycDq4txxn4H6IOqbYDF0jDIG5YQe0anwt2VbmEpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=A54gT3IO9WKmImwah9XNTHPRX08hDBc7sZs/pq9+S4c=;
	b=ArkmmmAcfAP2fudI7Ui7Pw0bsulBItHnAXqxmDa/Rzc2bIvwITSp3RIrPt1rM5Cu5kci
	 bTetOfTXx4Xlfcutbcay5YdubbXHHGeyTlkalRA5RGwUOGGXu4yn1rU2lAVVRceVEhGUX
	 +al6x9nj9QvRqX9FmqeNSgLjGUArHeBgHofaCBm24yk2hvkyXT39+BBUAI9C1b9+bMS2J
	 hv3ePHVimLLlHNHOv7qxnYpBjJEMaA9w3o78JtXHi+QcGvugdtkQnBzX3GPK1vHbbeOrt
	 scSKpZGdmMeiXDk1+wZgKC/cI0OVc1NDIA1iLSGAEBGuWilsfaVuuiXwqBkKsN/O6ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HLRows/3";
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4A606EEBB
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5D4A606EEBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLRows/3
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6deb848ddd7so2740417eaf.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 15:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661282; x=1794266082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A54gT3IO9WKmImwah9XNTHPRX08hDBc7sZs/pq9+S4c=;
        b=HLRows/3UIceZHgKjgYdtz3irbkskP/VCUGwmx8hEpa4/da+am5zryNdOMogFIVTtd
         0TtD4Xb2VEtIqQtxFB9t47SbXA8bR9eBWp+DvUoanMOkXVrsH6cpLcWXMa2Pe3ELJ84d
         b3BfbO7X7oi8r7jWc6AQWyL0rCXKLsRa2WdMUK00kf4FxrPY+pD7uMaEjnu1W1mNEG1x
         QmEUIowxwGBZRAG2CDwY2DXl2JDn6AG3liHgMy4Rify+3lskyN+HWvGlQyd6W9U9Vn3Y
         Vth03acQ/zdYBsmHijOtCnaUNOFzAPHyRdGuzpmHtZ/eTxCTVjT58UGgjLvgVl3hR0LG
         ctAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661282; x=1794266082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A54gT3IO9WKmImwah9XNTHPRX08hDBc7sZs/pq9+S4c=;
        b=qfcQ5Cb5rLs0XGfm1L8h8G5ij7ufMiAC28iiKO6PG+NBdI5HU4RhiE4Ig+WRYSHroT
         +386cijHgRm07rWYcWR9Vb4YsZsPVH7bz2aluOVK5XvqPzWCbSijI64ZpVwNq2Coab2j
         WzwECvuBzjLgKv9xzHu+r/hdIW0zhq+fapxmJJlgAQ/q/en3GFZ/eSpab4StHEDdUTo9
         CuIb0T72ezpezWxghug/4BAtblx6kdhJ5FjkFkOz4PGXYipiavJzlbl+okQjQCE94qLk
         0KtW0tv3tmnqDQfq+Z8gzATmogrJSXfAF9xWbILAl2Z0uBhLs12gEza5CdfFIjBRlzgv
         BmZg==
X-Forwarded-Encrypted: i=1; AKwUvBzN8qXsHUAptiGk7+6IZvHY1jfGZ5BUiHDyPI2UbhUPTR88IYB1b/r6wa/s/z/CXODel3ZLobFslIAbejU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsp5RoiRtPpIzoXG035uBq2GMUBvfCUYuWHNdSd5f2p5pyGRlV
	W0s0MZvusJZkU0If4egM39Ehpq5WEyp6hRWlLhbiQ8feM6o5uBJNPwRZ
X-Gm-Gg: AYBFou25caJiWTgVzq8awsw4yxpjpZjUwwS61J459Mv/qsKJ2ueY2Egf/OlJZXPPiqw
	ZzdJ5S6S7l/Y+yp5lNK8NF0hkxlHIb8yHBtKYWIt3RcUCo68Lj8FKxMOwbhLNgehetzyliFco6c
	kN+NyNT68YW6nK6wtzRzQdLfqU8yhkbGmQK+t7R84z478BuJuwmuYbqbT3s6Npz3WU2QQHKGUXH
	ahekvfd62dvOlEITaA8Rbp4HphV43rO3lEMzqiMV5UMxS7G2FRxGGjrYho96xlTDqmWioyD6MeL
	lk1zPYXtHcCssaj4T6mJAqOGJkGr9DEbE4Msh34rJL7S92xl6E0gvrCrKeK9qAikvd+ScohYBFf
	ScLcdHzwKup9jG5P9RD1czNyXb0/SVhVHtRVqPaT7OPMTqIWfGCHN/tfx7bIA7OyFFtRkG0DBE7
	qH40dUTnc5FPOnNeGyxItSFKU9RhGUvThjYvujIEy6Z5obA6IVaTsSdlvzYzocqqdMRjxMMGHuI
	nMtfo5gLX/66FYNIobacbK123/3s/ZM6CwfCfOyCcjFAOg2NVFTdWB88mjjRoSOiE165ulGePRK
	MKocxZ/AciqATvzevKljkYkOoDWZCwbIKTih/8gGrqccG95gZs5k3p/jdJeFCE9TWXJhlxdwIZw
	/bugjPUfaCqJIRbkRvc9igJgn3e5cnvAwWpWr3caGp61TUwnpbSKWoEZoc3SSoCNLawB5FECZJO
	ol6baeyWi5tuGjygtddF4oABxQv5PUYX4VdbvVjrgiUzqyyEu6ZCU=
X-Received: by 2002:a05:6820:5717:20b0:6d8:57bf:57bf with SMTP id 006d021491bc7-714f2381e69mr4446915eaf.21.1793661281665;
        Mon, 02 Nov 2026 15:14:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:41 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:30 -0700
Subject: [PATCH v9 3/8] serial: 8250_omap: serialize RX DMA completion and
 flushing
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
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

Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
completion callback calling it without rx_dma_lock. Shutdown and runtime
suspend flush RX under rx_dma_lock but without the port lock, allowing
these paths to overlap the callback's buffer accounting and flip-buffer
insertion. RX submission and UART interrupt handling also require the
port lock.

Take rx_dma_lock inside the port lock in the completion callback. Hold
the port lock around the shutdown and runtime-suspend flushes, matching
the existing interrupt-path lock order. Assert both locks in the common
completion helper and the port lock at the flush entry point.

Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b6f108d34854..322403cec2de 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,8 +771,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma)
+	if (up->dma) {
+		guard(uart_port_lock_irq)(port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -898,7 +900,7 @@ static int omap8250_rs485_config(struct uart_port *port,
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
-/* Must be called while priv->rx_dma_lock is held */
+/* Must be called with the port lock and priv->rx_dma_lock held. */
 static void __dma_rx_do_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma    *dma = p->dma;
@@ -911,6 +913,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	int			ret;
 	u32			reg;
 
+	lockdep_assert_held_once(&p->port.lock);
+	lockdep_assert_held_once(&priv->rx_dma_lock);
+
 	if (!dma->rx_running)
 		goto out;
 
@@ -977,7 +982,8 @@ static void __dma_rx_complete(void *param)
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
 
-	__dma_rx_do_complete(p);
+	scoped_guard(spinlock, &priv->rx_dma_lock)
+		__dma_rx_do_complete(p);
 	if (priv->throttled)
 		return;
 
@@ -995,6 +1001,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	unsigned long		flags;
 	int ret;
 
+	lockdep_assert_held_once(&p->port.lock);
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
 	if (!dma->rx_running) {
@@ -1811,8 +1819,10 @@ static int omap8250_runtime_suspend(struct device *dev)
 		}
 	}
 
-	if (up && up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan) {
+		guard(uart_port_lock_irqsave)(&up->port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);

-- 
2.53.0

