Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NtrxVUXx"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FC1B4;
	Thu, 30 Nov 2023 06:07:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C32934000D;
	Thu, 30 Nov 2023 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701353256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9nOprxz6fcIYCBwr+hMskwGdUdDHFkRMGiyHUidsjs=;
	b=NtrxVUXxRHUkgyhUybuEJ67yF7/hooBVKQL1dMnaBsNQOeW0dgE1JuOf9hTahfbTmr5Bxy
	mI7wZaIDPb1qDd8pj+S06xXM1I13nCCKDHP9fVtPhgS7AMsG2qxOKhwuDthRAtXkdJgWoD
	ix+3ktB54h+eO43C7XPCr1GBWeTPIXKi6JMTSRECLrP43UCu204AgJ6XoyKBTIbEDINbbO
	TdHnyaLEUudR5VpKLLQ3HcJVwTfOlVTWYLkaiSaKFf6RLcahLNCUI7EAjKxZV7LFoE70O7
	ipAE6OlLZxeQmxo8kRPKeUOK/zNcv8uAsqXRX4FWP1rr4an6oVdQSHAk0VGt0g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 30 Nov 2023 15:07:17 +0100
Subject: [PATCH v5 5/9] tty: serial: amba-pl011: avoid quoted string split
 across lines
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com

Remove all instances of quoted strings split across lines. Fix four
checkpatch warnings:

    $ ./scripts/checkpatch.pl --strict --file \
        drivers/tty/serial/amba-pl011.c
    WARNING: quoted string split across lines
    [...]

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 743dee75c68b..be8888db1a37 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -973,8 +973,8 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	/* Switch buffer & re-trigger DMA job */
 	dmarx->use_buf_b = !dmarx->use_buf_b;
 	if (pl011_dma_rx_trigger_dma(uap)) {
-		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
-			"fall back to interrupt mode\n");
+		dev_dbg(uap->port.dev,
+			"could not retrigger RX DMA job fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
 		pl011_write(uap->im, uap, REG_IMSC);
 	}
@@ -1021,8 +1021,8 @@ static void pl011_dma_rx_callback(void *data)
 	 * get some IRQ immediately from RX.
 	 */
 	if (ret) {
-		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
-			"fall back to interrupt mode\n");
+		dev_dbg(uap->port.dev,
+			"could not retrigger RX DMA job fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
 		pl011_write(uap->im, uap, REG_IMSC);
 	}
@@ -1158,8 +1158,8 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	if (uap->using_rx_dma) {
 		if (pl011_dma_rx_trigger_dma(uap))
-			dev_dbg(uap->port.dev, "could not trigger initial "
-				"RX DMA job, fall back to interrupt mode\n");
+			dev_dbg(uap->port.dev,
+				"could not trigger initial RX DMA job, fall back to interrupt mode\n");
 		if (uap->dmarx.poll_rate) {
 			timer_setup(&uap->dmarx.timer, pl011_dma_rx_poll, 0);
 			mod_timer(&uap->dmarx.timer,
@@ -1391,8 +1391,8 @@ __acquires(&uap->port.lock)
 	 */
 	if (pl011_dma_rx_available(uap)) {
 		if (pl011_dma_rx_trigger_dma(uap)) {
-			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
-				"fall back to interrupt mode again\n");
+			dev_dbg(uap->port.dev,
+				"could not trigger RX DMA job fall back to interrupt mode again\n");
 			uap->im |= UART011_RXIM;
 			pl011_write(uap->im, uap, REG_IMSC);
 		} else {

-- 
2.43.0

