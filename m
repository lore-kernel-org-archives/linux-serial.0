Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283247;
	b=rdb7n4U434ICH5YC4SyrWRmiIYX45tRBKX8nxqFoxTM34Nk8OtLKVoaBn8yA/ZrS32O8
	 pgyoGogiVPqM9gzcZrkwj+86F9shjOSPwPEed/YHGK1VikXFQkyv+kdwrWOe5aBugDpSi
	 d6yjkJJTc61N/UyxtRJc+KOzYBiqlK+tkkI6S9R75vPYUkSALj3SpbMPr/tEOXN3mwKKP
	 rnJ5wzSYqXfcvh6u8ZM2X57eutKgh20TGEcinaeaJq6+eMOkxt0PmoXme/Bd2xUTzdckE
	 FqIHEdUkBvq3oLhdcwKZ+CimaRpExq3NRukxUDixeP3L2j4mjEAe03FU7GLn9BzOAnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
	b=CrZ+74ku3GPEzXMAJDcC4OC+J8YNI1+hr7qVAC7WC1xc/pjggslCcmZ9rRo5gJErVQz8
	 4HdfYmdEn3PYeOJYgsGly4lklSxH8T3GwtE/oExKlMOM160tWGivtPla7xp+SEswn2N5A
	 B0F1JHlliXGYDcikHOKsTWONx/+zO5V8fa8BP9kCMVmPofGZNX2ETRK1jmcStUavdQPRU
	 MZdv0SCYoBg2LoxaxnCcojdGZV4Zoe48QQcsgHF06bWnU6vF+1VTAjgdiIYfgyL2zalo2
	 zw0dJZdLlzY7/HqXOfumC9BFPWhuuReLDpMMEW3MyMdbQG1Uj4oyM4v1p5edcku8x9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwzLTbqV;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEF60A3838
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CEF60A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwzLTbqV
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8479f46ecd8so803361a34.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 20:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283246; x=1794888046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=lwzLTbqV3Ek4HbFvxkQUBnQH+ABXrtHYDABYJ854e2zPvrNXi80ryjShhzvLF+lJsc
         Qu6CUTLeEKs3E/Td0KVKtpPV+bRRbz3QT8qSk2tclf1uWA68h3Up4SHRUkR5zgPlh0x3
         XxmoBHwp7Bv1Js8XStFlG1j/57cUY4EP1+VIpa94xPTSOfY2P8R8r5WW3V1maAMNzypS
         rkMoBL6nsTMSf9Yu/tdlCj3tdUp/uV2lLv1ABhLn3uCBAfkadh9rjV/Dswk+SQT5S74R
         cBSCULD+8Wsg2zygA6flKQT3n3RYgl8rmxX1UriU52RQsrrJLZ0sIoC+75b/WB+PtaWd
         pWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283246; x=1794888046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=xwjt1maWbQ/oqWKYJFs9ElnDVgfTWxVf8h1Mm1tTvIpUx5cyozow2ZZQmhSIIwod9R
         jEH8aJdmQqk6Uv7OFFnMgFs1EZRWSrxOZQdCEDy45u4nrrKUFwkZJWzg/stge3ZNjdpc
         0aDXhJxM7ZFA57kDXCuh3oSy/qyPTS58e/UM0Mn2jwbPUCThhdcZUhNjCBMuJ52yJyZQ
         /qFdSRcenSNbCfrEpZQEY9Lcg2IQRNiQ/LPLzlBKOvDewcabazEANS4nAt87pTRrj1dh
         CKN8IlKkED8Y1CEXnvDFoDkMotlpMz9ryHb2Q+bHNg+USJPB/REAG6Xvdx0xXDJocRNR
         7I1w==
X-Forwarded-Encrypted: i=1; AL+hErEdPC0Qhmq5Cr/9ns/wiNoKd8k9sonNWgbY0UFT+rXgTC7sMRf34vpeGL7JW2p38xQwTt4fHk6feDTw3cI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tvidh9mSReHoyTLqgf2v0EHMqsmYvlU/6NSCuQHCQZbboR5Zn
	EzaMiEZwDxbZxjxS8z+ZuAZBt+41zVsGzlhq4j7vVudpBp4V2Pqp/2d5
X-Gm-Gg: AYBFou05DulOgBXS89OkOECLrLZ3Its61/tJ3EdSZFoYO1xLcZvkuC/CfzNYy2uYKWP
	vhkjE41oQ2ut5xHna9HZ0bxGBhMAPs2nFIohtgU4bke83hhdOnaCtkZP7J20c5txFf2/L2VD6mc
	RGcBOeGwVRfQEPUAH+pGNFfoXvVJSry4jG6h/l0D2XLYucM7OiVQilBN08iGVe/gUCKfi+XyQbT
	Gp2tavE2bozGS6P4nMzu9WyLV71u+eZ+hNfrG9gB3AJF4L2CEut+bWqxYF92driErNAKY6EXCxW
	hkaNARqiUDgSa2jMhs2iJJrXh4Xn2Eu75iMqbCL+6+SfgsDlXAdIdhVAv7i+/5LtpNRvsbAGbe3
	zgChV16L70DfpVf8fmKArgLGpaZKlrTGzzhG/fueNgOUNZncLkfkqr23CxCc0UfRsk/3xPODkWx
	gtFfj/G8Igx0DkF0oZAXgtW8YXsToUg3FdR/m9SRJ/KeE4zCn1wEgI2bVlDFEhgYjbzlpXHux8T
	KLhub87YHLoCjNuc0NUzHIFn5yaPEzUpi3w2XIncxmZ8cfOSPRN+LWZ7fhWVp/SiOdFNKUf6CnD
	grf9SWfUJspdRyfff5Wj/+ciTRbcSNyhIBAQ/WzejB1aTBQxxvUg0DM0YDUl3mqkzx6qW37hCiZ
	JMsop/Dh26MMzeCVnmpPqUIEoJTP4E7ZDesoMB3HoxL1xdv3qddMxvNiw64umsbQnMXw1K40JZa
	12P8Vrh1JuU2hMztkUh9DKahrDDr9kBaC5zWk1aGW7vTd4zPCIQhEaMbzLSTRr8Fxx7gQ8T2LM
X-Received: by 2002:a05:6830:4aca:b0:7fa:ab72:9e01 with SMTP id 46e09a7af769-860dc8464a2mr1224823a34.25.1794283245936;
        Mon, 09 Nov 2026 20:00:45 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:45 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:23 -0700
Subject: [PATCH v11 8/8] serial: 8250: retain DMA resources when
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-8-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
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

