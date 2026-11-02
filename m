Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661284;
	b=vYh+zc+t81Gvp0nEkXcXHlflur10Twbx4RKbL5bpcZ7m/4kEbTgLMfhbs3EyPjLaGX5c
	 ObqEqVxUezs/O4lZ/I1Po5OAbcbCy5ByfCbhj16JiR4n5rZSWVkP4F8+lYaRMaW/E5Sot
	 /V3zhmZj96PjgwetsehLzEBI6V6KU+s9ntHqsPFtq/dv5eh9sNQ/EktXolOxlQHuTuy9K
	 dajEwBcibBxDhVA7CO0e0g8NToSAmw24VWt1Gv004oUIsgdzCJ2bSZ0xJOtd6rTErUrRP
	 R7NLiklRj27s1x6Llxmm4HCtseozzKi+bkHDN+SdRgoHyLFyeq0jNhCKjmXF1eTdVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xGWk144TqWPWYAhvtpbLeTIfJgjLiqjAQeYBDnQ9hsE=;
	b=BOWdKwMri9n/iv4jlCH8KNj+Cja0zSaHEqfXA+QWxSrsWLooYhD+edVevJkZu5Xdi9yW
	 V37mG4FNViaMOsfEYy4vFd1rJN/rH0VSQdHfgmKL/FZLUUoADWTi45E1qkLGUZMNHYhbk
	 zRb7J0ByK2MZn6AqQT7GAB2BJO5HYYkCAH45lfML6XUlttNoAro86kwAa5kmfip8cZNE8
	 2JcBpCikM4JaWz2BmwWHivzpQfxCRNDR/xJzFUZvKL+PrkkdwIE/p5XSqMH9akKDpxZJd
	 vbIHtGmct+sdQJvoO5Uf5tLXk8vbJEEhfnLsI2rZ5MV5umtxxYN/+rgjP7BRfHW+3Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dkx3oL4k;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C26082BD5
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8C26082BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dkx3oL4k
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-705cb6cedd5so78313eaf.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 15:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661283; x=1794266083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGWk144TqWPWYAhvtpbLeTIfJgjLiqjAQeYBDnQ9hsE=;
        b=Dkx3oL4k5JnraMjI//7pIj4FRc/c/ni7jV1LCwcoRtcoT0D3CYRH3lgOrU0HZbGeSV
         TUwNV/dlx6yNCa2snGfNBIg/I6d/YrxkXPTraijQ16qDcrjsJixEVV6rvAIUz9zxX1aO
         QX6WtsbrngUCe/veWYgIJHoON/1MCv0zxYGRmzKlJExlNqqasniKQPoX/eSl1wLIX0u5
         u+Vwttc6JKv7lHzer0LOBv5sDk9H7xuA89g4EhJpEqKTzAXMCvi6PQ0M6bK7K7j/A1z/
         5VCFVJxh0ou8XS6GcIFKsqrGB3YnUd2299fZ/3oBpGwmrEHzAi0LlkwxBCkImVpmjyRD
         ntYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661283; x=1794266083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGWk144TqWPWYAhvtpbLeTIfJgjLiqjAQeYBDnQ9hsE=;
        b=2UlLxRqcedWaDqiAXebSZI5zLj9ZQfFhcnPNCYgMr/ML1P+Z3SI3MUd3QrDQ6ccVIf
         JpcmQ/B7hZYb7vA+QdMVw7GOIVb9pNljl0jCIa6T5V+c9j6d1JiXyIt7aQtEFhcHShH9
         oC+ncB+SF6SbFkF3BXF9rTHHR/rieR1WZF9/nIt2BSvkZHjIbTDoLjYnoztc1iEvhxbh
         kXXtjppRs20o9fznFS7yE6A3/5R+rBDKWrqdULg1lcQU65y+8LqPARk0Cnjo2Korv/Ka
         qs65eNkfUFLji5kCxfapHIdBZF5LNg12s930lvgzqqyRwU6GfOTJwgxr5VWLEJQiW8lU
         t7KA==
X-Forwarded-Encrypted: i=1; AKwUvBwQ28/APXxD2QkwTQ00dkqEmyVdQwXaafTL7lMB0alL8qLSTCFtwczsZxLDcYf7lo7A2prC6LL2YPQKK8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKyz2QT40yczZ+EfJ3XyH+QeQEDaR++x/v5myDluKW32NAZcvh
	STZjK8NJkFUZy4OjHR+4NSC1pt256kly+1bZoYRYqOw+yCLkBjoVdm3d
X-Gm-Gg: AYBFou3kbzXKfgMrv9HHLrZk5cTTIhn67gd0ZsuF9SCR/H0QixUCEwi5O3/8rpyg0G5
	isgeYWoc86R91qicLXoRwdvtx4fQj6eEQsV3GFix9nnezcOi2J/cCbKgFcPb2WgVa8/EPIXkK4c
	iYAujzZhbOrEuHaCO8FpstmxjKnabHBqEQkjPytdq1MyL/oSLPeoEwftJUFrx3jrFZoF1hX/42Q
	adzxBxhZpExOnwyqMR+8CbfEQQrIeolLOEyaU+WyZ9ekPXVfxtO2VKwmvMrH7S/LlDKXApqBMef
	jaRv0CthciImhxeOGpEQsmCB9g2OutsIMWZZjB4JT/9SfUH/HqO5AnfSOmYASY7s4LqSpjZ5U/W
	VBuy5htArvvEiGFnD27O5iWS+6bLXXvjH2I3EecJms1a/jbPQVlW35sxQYSsRZ8s7DeGxDZMbi8
	AM+44KV6k7hGOkRIqGJ5vm++IxvPqnGLHeWhj+5b9KQ9TtiISqGlzxvD8K+duWa/jbkJ9ASOlLM
	j4Y0ilNfBSuqIx3yXnff+zC1A1ttfV6mNY35lRaj5+aAqWVQiB82O5S31KgmG0FzDm1xCq3rCha
	KhB2uUzb+jbRnqjTPgHIbqO9Q8T0w/+PScnNwsAWQKHcsP384pIFArPeOTlRt+Fmtiubpi7KQAm
	2h7n51Uv7tUEqgW5qzYviWm+nenAP+0QnNW32oX9O1QYiACjwsOYiidheiMkawZT/euBDZ6N8HO
	qr7yflorV1ce/zWlN8vJ2fZ+365uGMODKE5LJRkOKT/+el+mj2cUR+keCtnQT96APgi5WlfRG7
X-Received: by 2002:a05:6820:571a:20b0:6f5:86e1:b020 with SMTP id 006d021491bc7-714f29fa61amr3266065eaf.26.1793661283331;
        Mon, 02 Nov 2026 15:14:43 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:31 -0700
Subject: [PATCH v9 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 322403cec2de..fc1a83d6fa7c 100644
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

