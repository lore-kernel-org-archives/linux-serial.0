Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563619;
	b=j8QgY9jYygacgP0E8yKgjzAL2EvPhf9Z7cazx7RwcniI3D2z6W+IxO3SkU9MXyterMB0
	 Y1xF1Gqp/Zlw3wobTLqZf2vx9rjxsuhrfGHW17Uc3dkVQZcJYRzWS4ZRPNuDnRrL5cKxI
	 Ew66CoxvJTmha2fTpZfLtuiescUV7E6eRc6RIcQFnGtE2GPl2hVhXmgEx1F1ZAzo6L615
	 oO5zrZtMqp8zPENj2MuoNFi2QSJNcyS94De0UfVALwARXrvbQnA+jccYCCN1qpCX5g87G
	 K31TwqMkQDnLL9bYj1i9GcsnnI36Igrd5NaRtWkKB4p2ncUUQNjLZ3yTTbJeDbTpMfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tKw63yp+LNfG2M5Iosvm2af5QjVi5+/3H0IZittDmk8=;
	b=k5T0udr8hKlqt9XzoZQmjiYUm8OylDJPGorFlKfGvVQdRAo1vgwylfLtZwyZegq7MHSE
	 n9J+ip9y/tqVctEhiKSyBAi0xYWFYAE8lX8mJ5mSeP//aXnMyUXY6+ykYnOjSr3mkoWld
	 YWvtOoA5zfZCHKGeZYDLaIcUQSbGUvT41b+qkVKf02tvrjdXDRtfhiRt0kevRHuvT0qRf
	 JxHy4/ZtXdKdjGC6twwSHHDfMBwjMXzGo3N9kpjKzbflR6PWswakzXQAIggbkdqBf5rqW
	 86UvUkLfOHIyXtu6HPyHoiX8Nm4uqAZaAXWwmVGnGLnGOrh83BsAaR40tlD+DZ7RQqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1JdRcn2;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5660A2636
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 09:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBA5660A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1JdRcn2
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4e4a4d77e5bso1631857b6e.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 01:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563617; x=1795168417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKw63yp+LNfG2M5Iosvm2af5QjVi5+/3H0IZittDmk8=;
        b=r1JdRcn2tXPQ2B4ngpoyCJTkDbyJRwwLo01UdW5+HD1jMKyTSYd7u2IsR2QZu/LYWF
         PalqPlnR9GjgHvjauSBoqP4EbtPmmXtQWWgdXKl6T7v/URk6gN+NxeQ4FcrMX64d0hQn
         Lcy/V4pXrXiWbxtDaPhhjMeOfLiKJedN1ar4BY8Hkc/66IpdlDKEdTkEV6oNYxVBiJco
         tbHppqSOrM+KjMSNwpubD5VzhbK57hMqtQHJ7nvpiNjzsT2mInI9fd9RC11q5pg/M/es
         iV4VGFArCFcK0oYvIfhtreO9BWx1BRBa60SEqqAqpWOSo00rfng+SqNhZwyZRD8hw6mr
         HVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563617; x=1795168417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKw63yp+LNfG2M5Iosvm2af5QjVi5+/3H0IZittDmk8=;
        b=Kew2XLCXXIPv+yjUMPSlMUrfVYNAgYxiZT6hpYa16liHYIefSnvyBcUParyxRP56by
         24JPJ1oCztVTfIxXGRi6/b+i6mG9swF34bQjytYvoPKczkWHCMZP52QR74ts3gGN6FaA
         8NV4oOP1fvDLVJLdZPkRuits79Hr5jnZ/YYXE/JKCnxqXnVQPLT0xUcuqnAPeiCBhEoF
         8Ta0HM+P/C8W7+HSZkIvZyIRGr5qn92PeOl1OR6BiMt4W+rny9J7SoGBd2joctaqyoxz
         sH6zo4uwfQtI1v3O1TYEhj08meI2KNgaqnIiUc90+6VL6ewYVHPePei1lv3RUoCdPj59
         za+A==
X-Forwarded-Encrypted: i=1; AL+hErHizBLT2GJdVKCusJ5r40+6jLk42PhyIxVEMYhnq0rNOwu12/tl5jZ3DlAlZJxPWJ2yD9lVNQPYC/M/gJQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3S1OZXJANNuZpZW1cJu2PkUiKhwAiFvr1uTcBM+Rvmh2TJida
	XMUnxh748ej9QqEcITivLfIFHxCEDKN0CTjjwx3kD1YBJopPwhtVp1Z8
X-Gm-Gg: AYBFou2pSE83e+G/hc6m1EgsXUGV+iynd2ZBWHj/8hSwtaG7AcmnKZfHShe/0K1U4Pi
	X6XatYoNdTruvmL/L65K+tvZ1zJ65dnHhNcKOEkJJDuEzTZWzCzhvn+su04DY0o1aJ4a39E35Vp
	WX0MKTxNyWkWt5yX4zUgNfXddgbsxcAaNFBOTfcGVHhcTs6y9UuibAqQ/d05WSiHQaduqrHo/Vx
	fUFZ/9z6uk1/xVu3ow4ed/wNEYaAH7p8TqSTNRDb3Akg0+TNBNmt5hLUYou63r8zCk8mY9GLU8l
	C/tCltk3ELQSamTqHyb4ZdUocgfPfFEuQDcjebbN5RfZcgPC9wrhBrf2iAAiBjDlKjEQd0/EX2W
	/sdOJOVQAcbHpVswUGLWm+bnF6r0GFVYbq5hXvO83IsITwKZRSJ28COHvHuw+Kfi4xkXteJN3u4
	SzYPHlYSozE6gRU0L723EyiApsU4XBbOod47aMayc6p6kAhSBZYoozgVVILTvfaHjSoqGzhVDvB
	drV0TChtbmJzDMroWsD6pHErQJGWCFv7p8ewRzKeHRkzJJwbol+3/cqjgPOpxC++lk70EAmYEV9
	HX3KSmZmYB0QQnRll00B9hWsC2Owp1tXCWuWTLY6sHESw6U3QGKFVVKWPZu1JnRjOXKwrz/3zum
	XqSMFVTL89PJjbSwOcjLEmT8ol7u39tPACqNxc9WCPYla00sPr+3xwQo9+ZHKPVbkVMg1vFdXzE
	BNf169UkFCcasw2zfyDiJwaTQjCJ3mZXcP1c8vYDpH+KJ0gUJtTQM=
X-Received: by 2002:a05:6808:3383:b0:564:3e9e:b498 with SMTP id 5614622812f47-56e65624042mr1138531b6e.22.1794563617554;
        Fri, 13 Nov 2026 01:53:37 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:36 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:21 -0700
Subject: [PATCH v13 8/8] serial: 8250: retain DMA resources when
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-8-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
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
 drivers/tty/serial/8250/8250_dma.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1d7c3c5b7564..0719fd4c3129 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -578,6 +578,51 @@ int serial8250_request_dma(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
+static void serial8250_terminate_dma(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	unsigned int delay_us = 1 * USEC_PER_MSEC;
+	ktime_t start = 0, last_report = 0;
+	bool first = true;
+	int rx_ret = 0, tx_ret = 0;
+
+	/*
+	 * Shutdown cannot return while DMA owns storage or callback state:
+	 * serial core frees the TX FIFO afterwards, and removal frees the port.
+	 * Retain both channels and retry outside the port lock. A permanently
+	 * failed DMA engine therefore prevents teardown from completing.
+	 */
+	do {
+		if (first || rx_ret)
+			rx_ret = dmaengine_terminate_sync(dma->rxchan);
+		if (first || tx_ret)
+			tx_ret = dmaengine_terminate_sync(dma->txchan);
+		if (rx_ret || tx_ret) {
+			ktime_t now = ktime_get();
+
+			if (first) {
+				start = now;
+				last_report = now;
+				first = false;
+				dev_err(p->port.dev,
+					"DMA termination failed: RX %d, TX %d; teardown blocked\n",
+					rx_ret, tx_ret);
+			} else if (ktime_ms_delta(now, last_report) >= 5 * MSEC_PER_SEC) {
+				dev_err(p->port.dev,
+					"DMA termination still failing after %lld ms: RX %d, TX %d\n",
+					ktime_ms_delta(now, start), rx_ret, tx_ret);
+				last_report = now;
+			}
+			fsleep(delay_us);
+			/* Retry promptly at first, then limit sustained retry activity. */
+			delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
+		}
+	} while (rx_ret || tx_ret);
+	if (!first)
+		dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
+			 ktime_ms_delta(ktime_get(), start));
+}
+
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
@@ -587,9 +632,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -601,7 +646,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0

