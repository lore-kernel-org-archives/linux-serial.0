Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450281;
	b=woxaRh16KExgVsiE0lqtJInu03F6PIm5XoSBmK9u/VZE70hKXFIc+/O2nMkIk0pbXfJu
	 ziecbELRUMVpcsl2bIrNy6oM+GpfHvQg8OzBn1UmwADztHlgNvPU9kVXi59teKZcv42xu
	 stvlxJTBQjHf0GO1FR440PgXhfFMnf1c9lMYmLOasPDSd7UMsbbRPV1vhWdl+MTCUPyFw
	 L5vuVhRghzm5RcCC4UUsMkm7XKCKoxB7pesdYypQtbSXQ8nqtrAbzLdpVXJABQuh2HTvM
	 Y8gY+sU643eEkVlDPXEgHPwmVIDS3YF/Vko9A+MBo+uEQ2ZmQ/4UMZiKLpHgA1OOWIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hF93A2swUvHoNDKG9XcYGoRrUhQY3sGOfHMmfcGcHo0=;
	b=FWQNGhl5HgLL1VyYJphV5kvUSQvuy1GcHkx6okoftFErLSPPgCiJ51Jp6wYGKEZff5WV
	 /X1CxrRCiPEIBFFuYApCXqc57p0OOHx1/2JTn1jLldIbjxSu+RV3wp3QqLAghpMSHlDVY
	 e51D6h1bv5+O1j/nYgGGjVFfRgZyOwkbyVXVnFCwjYZK6E3zitjxEduay+eJJ5BOX4bJa
	 2gg5hhL1XXMz11wZBHOrmdCuX4fSFZoJXdQHk6mv2k9Mmh7plIeRJLHHDGLmPBRdmUjQZ
	 xwLCJ8Cc59UlOOk+zpBSfhDs85oFLA8j2v3gRG8NQ1hWg/vHYNoGZ640nGOoUSTKC9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjW1FWQe;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9A606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjW1FWQe
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1846bc43c28so1845247c88.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450280; x=1794055080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hF93A2swUvHoNDKG9XcYGoRrUhQY3sGOfHMmfcGcHo0=;
        b=IjW1FWQeYtHMv+2CViyfUBhgYOzKDpB94cQEoKFA11u7hz9zlnd/8gU9X+43aC0cow
         sfNjO8fuwRJNBlND6zEvqMKisVvtyFqJrVsEA3EtWct7Pp6xLt68hg2HotBdjH/hw4oJ
         KfNS/1VjEvtdZ6WyiXJVWZK6WZqCgYXMOOCm51uVr41Pcb3R8v6UeR2BnFL1ODfHQ/QZ
         SCdUaVYRdOAaC2dZ/ujvEIXDgjvJsjB40G2JhCCla1JkXGzY8fsc+bRaBn4gbaaQXZNf
         OzPCIa+4dFr9HgYoXRolCDdM8vSsC9dpiGNuYFICi+5WOrhjIAgtLqt7ssNhGDupcTgb
         Ob5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450280; x=1794055080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hF93A2swUvHoNDKG9XcYGoRrUhQY3sGOfHMmfcGcHo0=;
        b=2ibh2nNkAso6Pdx4vbdFCKayozxjpjm2rjfFpNTSoZ9V1mZ57WUrxEHhUp8K7scgUh
         43aFgYwaJMiL8K7XaeOg1iKiv8m/vykvODKRzcFCjSftS5DJt2SFTTlGMye8zltFF+yS
         gQYOPQuXh5M1a36QjxCRbeene5WuwTMNKxEFOvmrf5FYNMaDfOpcb7CVr/lyTiKU9cNM
         MhxQCJwVtt81YPKW4+nKtlUIo1dgwwbSYtp+Y0zDIrQrkxO7U/bPWJyk1CA7SBAJM3MN
         i3TQNO4KxgW04nm24qcYkEIaNQ0AH1NYzHIfHL5TP9kiKt9dj3ZqiDArMpbNyJX/gLQe
         pY8A==
X-Forwarded-Encrypted: i=1; AKwUvBya81Oj8rUEMpzlS7GXS930TqsL08AX8ut6Paiz6KIrUd4rD/E+KKZQyXoB66FfAxKumNrrXHX4D7T7gMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIhelq0ScckeksU24wV7rbrOkyod8nPH9UbDQ4lwhXvzDFQyvv
	ejS47PNVceiMpcnalBg+68kOjjfLCys1Kp8d94qTeu34YZEHWMeAVisG
X-Gm-Gg: AYBFou0oBSBSjbmOXJU8AqFUJ3+m2hCDx7/+psdX/xDanLowGa+hOMrnoZIUQg3OGV1
	JY9msxWABROGLh+WG4J/cYhefzIxEL4E3b0XZLvqSKmFlU39CKdAKom+x5KM0igqgDIgOqryZRB
	tAmm4GKnonobMaEBOEY9EyiFXbpcz4qa+Lqdb4mgpLFmxh1yTgc6YzqYZmMFc4LQ+6n/9lknBPc
	DrShzoiLPXnddoAAiBc/qq3uD6uN9jCSNv9IdSrLfnVpvlJMrs1RE2lETjwv9qOm2u6+2LrOXor
	Cgs30xsepAYKivDFYWRF6HYRUkCS99evrkbV1kzENgBEuJ2cbz5b27DJpPq2GPtlNiAfrpaNIUF
	qyisoGd56BKOMf2CwPAz5pQ1wX7XlPO5adeyMJIPeJm8AS+gDJEQHJO/P0jx9u7bDCjNS14Tiv2
	E/r8aO1AlbhZ/rnsXkQylRcrdagXe7pPwJfmRjdaIHQy57goRKaeTEl47F6Oj7XuR0FBdzsC1lV
	/F1AzBDWQFrsxQQoWLItg8SzQQzmmhU2kOUTZ6ZFQU1A5tRqx/xYF3acoXokyYGcQxAPqCUtrds
	k2p+bhewwSiZVWDYyeWfEMhbBE1jzT+jSU1ph80+NRpVGcgt0z9/3WNABNxe3pAcShbN8FxXnbv
	qRMCeMW6Xz577EDUHK6bI8rBg1MoSSh/aGZZ2LHrYnXlsQbKeu/t1A7+XeVV/qGo1CAgaTVmjJF
	9Wr5IS4CTbglroyA==
X-Received: by 2002:a05:7022:5f15:b0:1af:d691:1b4f with SMTP id a92af1059eb24-1afd6911cf7mr850231c88.42.1793450280250;
        Sat, 31 Oct 2026 05:38:00 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm17300763c88.17.2026.10.31.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:37:59 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] serial: amba-pl011: keep the flushed TX buffer mapped until DMA stops
Date: Sat, 31 Oct 2026 12:37:48 +0000
Message-Id: <20261031123749.3783352-2-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031123749.3783352-1-samarth.colleges@gmail.com>
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-1-samarth.colleges@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_dma_flush_buffer() is called with the port lock held and currently
unmaps the TX buffer immediately after requesting termination with
dmaengine_terminate_async(). Since asynchronous termination does not
guarantee that the transfer or its completion callback has finished, the
DMA controller may continue reading from the buffer after its mapping
has been released. Commit f6a196477184 ("serial: pl011: Fix DMA
->flush_buffer()") introduced asynchronous termination under the port
lock, but did not add the required synchronization before unmapping.

On systems using an IOMMU or SWIOTLB, outstanding DMA reads may access
an IOVA or bounce buffer that has already been reused, potentially
transmitting data from another mapping. On systems without either, the
outstanding transfer may instead race with the next refill of dmatx.buf.
This can be triggered by flushing the TTY while TX DMA is active.

Since flush_buffer() cannot sleep, defer the unmap to a work item that
calls dmaengine_synchronize() before releasing the mapping. Keep
dmatx.queued set to prevent buffer reuse, disable TX DMA requests, and
let the work item restart transmission if data remains pending. The
completion callback leaves flushed transfers for deferred cleanup, while
shutdown waits for the work to finish before tearing down TX DMA.

Fixes: f6a196477184 ("serial: pl011: Fix DMA ->flush_buffer()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 54 +++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e6f652905ca6..863a050cf654 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -41,6 +41,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/workqueue.h>
 
 #define UART_NR			14
 
@@ -302,6 +303,8 @@ struct pl011_dmatx_data {
 	size_t			len;
 	char			*buf;
 	bool			queued;
+	bool			flushing;
+	struct work_struct	flush_work;
 };
 
 enum pl011_rs485_tx_state {
@@ -609,6 +612,12 @@ static void pl011_dma_tx_callback(void *data)
 	u16 dmacr;
 
 	uart_port_lock_irqsave(&uap->port, &flags);
+	if (uap->dmatx.flushing) {
+		/* pl011_dma_tx_flush_work() retires the flushed buffer */
+		uart_port_unlock_irqrestore(&uap->port, flags);
+		return;
+	}
+
 	if (uap->dmatx.queued)
 		dma_unmap_single(dmaengine_get_dma_device(dmatx->chan), dmatx->dma,
 				 dmatx->len, DMA_TO_DEVICE);
@@ -867,13 +876,47 @@ __acquires(&uap->port.lock)
 
 	dmaengine_terminate_async(uap->dmatx.chan);
 
-	if (uap->dmatx.queued) {
-		dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan), uap->dmatx.dma,
-				 uap->dmatx.len, DMA_TO_DEVICE);
+	/*
+	 * The terminated transfer may still be reading dmatx.buf: keep it
+	 * mapped, and queued set so that nothing refills it, until
+	 * pl011_dma_tx_flush_work() has synchronized the channel.
+	 */
+	if (uap->dmatx.queued && !uap->dmatx.flushing) {
+		uap->dmatx.flushing = true;
+		uap->dmacr &= ~UART011_TXDMAE;
+		pl011_write(uap->dmacr, uap, REG_DMACR);
+		schedule_work(&uap->dmatx.flush_work);
+	}
+}
+
+/*
+ * flush_buffer runs under the port lock and can only request termination.
+ * Unmap the flushed TX buffer here, once the terminated transfer and its
+ * completion callback are known to have finished, then restart TX.
+ */
+static void pl011_dma_tx_flush_work(struct work_struct *work)
+{
+	struct uart_amba_port *uap =
+	    container_of(work, struct uart_amba_port, dmatx.flush_work);
+	struct tty_port *tport = &uap->port.state->port;
+	unsigned long flags;
+
+	dmaengine_synchronize(uap->dmatx.chan);
+
+	uart_port_lock_irqsave(&uap->port, &flags);
+	if (uap->dmatx.flushing) {
+		dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan),
+				 uap->dmatx.dma, uap->dmatx.len, DMA_TO_DEVICE);
+		uap->dmatx.flushing = false;
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
+		if (!uart_tx_stopped(&uap->port) &&
+		    !kfifo_is_empty(&tport->xmit_fifo) &&
+		    pl011_dma_tx_refill(uap) <= 0)
+			pl011_start_tx_pio(uap);
 	}
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 static void pl011_dma_rx_callback(void *data);
@@ -1177,6 +1220,8 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
+	uap->dmatx.flushing = false;
+	INIT_WORK(&uap->dmatx.flush_work, pl011_dma_tx_flush_work);
 	uap->using_tx_dma = true;
 
 	if (!uap->dmarx.chan)
@@ -1236,6 +1281,9 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	if (!(uap->using_tx_dma || uap->using_rx_dma))
 		return;
 
+	if (uap->using_tx_dma)
+		flush_work(&uap->dmatx.flush_work);
+
 	/* Disable RX and TX DMA */
 	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
 		cpu_relax();
-- 
2.34.1

