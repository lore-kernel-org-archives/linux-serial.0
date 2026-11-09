Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196277;
	b=sB1NFwS1/G3rrPDss/OuK6cGaZzr02zxGGOYGbMl+Lv83D4J/BzUzvgM2oUS44oyFbYX
	 LhPSLuIIPHy9OO1qY1/zqtIF9WwgdBZmr8MriPNPmD/b/saXsQa1PVfk1TMh6N2UgGjaW
	 2V3uqce0FrUF0bxuxdlH3GZTlmnovG+JIXFgDLBVrDGuQiVRZP4sNVGsaIa8GchyvDHI9
	 mD05u7Y2tI+fFx9kZasnntCgTvJC0KTVe3Pk6iJC04YoNFeBjnbLkmHOrQyjc1vDIGVpL
	 4YNlyGDGeAPfomw3/h7XnLCo9R+o8KEIf5tC1U2dPfG7PAcf7jFLqyDJJ17Nw+RvQCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	b=Z1Bf4vtrCSlU2wiLPrHQY0Qy/OdihUOLWatIEtilsvFxvsulz/zszFlbvKN/hiBt74BN
	 2BWAUN2cjmnDcO946JK+YJGIPtSQTJ7Q4bregUnvkn6jqKIasrqDz05FvCdlASzEOAaFc
	 nchzl9RUKjLsLvgnQx8DhgFehed/xoifQXvF/b1/0BlytiSk6MjD6+sL1/WlymTOcn2Y/
	 8Sl3m4Go8Hiv2pVtOTgLOuvsZevAGWKP3FJb1rlTc243m1ysSOfxvb3YPeW2aF8XGL2s5
	 yfvt9Jsqa37wPy86e84wqko/KGciI0tCJYEkUE1TiC0QSlwuFIrfOHK0FOFdFaH/KWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iRu7/eI5";
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FB606A330
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 03:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE7FB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iRu7/eI5
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-844a8bf7e25so310502a34.1
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196276; x=1794801076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=iRu7/eI5jbPQv586S/vAhjA9mCQe3E+hSVRxrGLWdzZ1Cu98h8PhkR7ync5vauEodJ
         8cZFqsEZaDudsOfOz7RI+EUCAvmciAretwgXQBpkcKuD3cFb37HLm5mzTayAeKjP1w+z
         zLxXTqedYctsoSjpHJsY+XghbosThFK8q7oRWox8t1f4c8Jw4F4aCQd9oZBjFCTOxSxA
         eOZdV2QbyyyID9OhaVEMWpQpUZfAFmtFzpNNPvU+nYI7z49wnNgBot4Lw9GkFKPCNmhI
         riNa0XS3q2Z9Of/LXhYba9Z3bDA0q87CA4ZfVXNvc3R92iECt4EC21E0FX193on+S7tj
         ayUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196276; x=1794801076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=FvJqritHmHAwHbvbGzOfrqT8t0pdqoZ/5CXP45wl2OPLdFDJAYaZSiR47tDNTq5iFL
         9qRcSmSMfpjI24MHYAW7lneU9uN68iMa1XygKLdl3jRB/Xbh0f1j+EdPjc05mnYKWO3E
         nHLLcNoZsTiaRJjRm6mVhcgdDKrXobiwxnk3qRS5QF9MgV05X+pitSJPg4Ncwd1SHwh8
         HZpue4RrBD2NmOW03dfanF1zzqQnOlNVVQkCxMuG3Fsz7ah174sg4RrAGhEH2o4rI8TS
         mUL0X7Bw8N4fKNWedBkuYDINN9G0K88vEymsR6Z7RSv15Q3iX3tU1lu/xwLLQWFsR0Pk
         Lawg==
X-Forwarded-Encrypted: i=1; AL+hErFu8TYS4ajwv+M0Lhg2QDtjYK2Q5/Ppo/sMvgOV0+hF9eDWLfm1cY7oHiBuuN/ctm2NF7zREPv7lZXthKw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q+gifwiJlLXCSghYnX7gcE2cGgO0IuP1OLZcvdIX3iNhnVWnu
	UddKYj/zepuJ8wKCoCOZYlsWxgPduF4KNRjeYBkmEpjc4HXljRzV6Mn8
X-Gm-Gg: AYBFou2sln3cV5veOssQPLgXQt3Dnp1xkJedODMGshM+nKpN7lX8e0Z+LFIj0Y/3DHh
	+9lgartc0tBHhDZAEwJXEpCgTNyQE5dxkWXW0/1lLIWe6Lz4Ge9HGl81D4ak1rnmqgLRnazL/MM
	WiM5q9Nfe/rivGopiqWR5KTDe4D87uvh42SZiqVNL3oyteZi0yUvHsvVKvPREp1jo58IvN1o4Ov
	isfDKhxYz5qiLb0yGlItfSY6DHlNMEJ0TYX/ENLoIepSzzk8RRyBkhj8/6yeSROCYeiLvJi+uR0
	89W0szCkDLou+siJeFvrm5a8E7nyVi1r1Ow260gR1qrQ3JlAab7h49ysWksO6GeOt5EA8nE4aNt
	vxtH5EUmFTClMLmYzhUtw4MqFvUE0UzXllUBfWwhbfte80TYt1kdscT63jclwyqWpRF6kje21Qj
	LsvGnSDVHNtK8mNCFngL+7jJkN/VMfMLYxgdh0A+yIbg65QHeUN9UAOVM18E37YsUk4isJTfLnu
	FWQwpKCcO+HvrVjhTcwht01i/m8Jbv1os++xJvmzLbjgZ0SOa18wGKVkvnV766oExM9+QTSVg0I
	R7nMsiTX+Q3wbxkYu/AbX8AKbghfAzY4JZnn8IOwz+qzlsBIv3xDIW+t//6FbmvM+4FwPwmrLpQ
	nY2octzTTC1AvTeQxUSgDMei3VXJ8zTC8r9fJF5O2s+d8shJBJZikXoamCbZL/MdS0BSKX+slGD
	qABgFSv1XkyrU0dILvPdnrKe6SIV/qzYJ6jU1Q1Z2Gembm1gokAASc
X-Received: by 2002:a05:6830:2b2c:b0:821:c75e:5309 with SMTP id 46e09a7af769-85f506ac2damr2072062a34.7.1794196275699;
        Sun, 08 Nov 2026 19:51:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:12 -0700
Subject: [PATCH v10 3/8] serial: 8250_omap: serialize RX DMA completion and
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-3-e6227ddb95b1@gmail.com>
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
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b6f108d34854..5e114dd8f9bf 100644
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
+/* Context: port lock and priv->rx_dma_lock held. */
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

