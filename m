Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778695;
	b=Av6OUxsu2oBLX4xzpf1dLFz/uBWpPN4kjF4WvUEsqV0MbohNvGE3NJbjH0ra+U6oiSv7
	 Pb+V7G3OTAhzJnUxJvaKanjOfCYFMZHMlDBOoiuZBo0DNlIeiowGTExRgsaHDd8EwML5q
	 l0TEmJD8ITeg1J2u6cYMpq9pMMebvcMpDJpMSROmulLlTXzL9n/KAYiy0+oEzyMzn3+DC
	 Sbt3JsB7YilLv29VXzuDAPWHu5cQamrkQrO+lLvg/vmKiyIBBf94fRHAiN/zzac1utwXa
	 INFZYeQEbhHqMMJ/0vXjx1qugD+zGhuzEq7tUzyGblWN9jhCaXtaJvkuil5UwKGaryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	b=rTj6gllYG+Lv5AyHY13kPnN0fupj+j+miHglpnBQqG0x1cXXO4UIa7lgc3E/vbrd8vez
	 1f9VF9clHx7fn8QrqHB61LAakaceKOirRI0rdTo5bUXJdZHu8IhYYPdKHFVmTKl/6IJVr
	 vMc1SUk3GELbusb2tyLT3fUNrYJvKm4AQW569TUwYTDzbTJ0FAc6dKZELrBoSdlUnSO2d
	 zkZ6FH/TCPMZLqLIIo4hbQAIIlrsFXAUotZqktQ8eUuaZaudm+FbSPjPIcvaWZ7ohqrlN
	 eEbxU9+newt79RCnS51YHtXDSiXFD3nSIjR+sE4Br0c2CEquECGkEMMlXOVcTgYAuAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1pu7kER;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5F606A332
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 18:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD5F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1pu7kER
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48e94879f02so425898fac.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778694; x=1793383494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=q1pu7kERnZgamfiFWXGhwve1ItyZ5fdtQl5KucJ9oWetk+5D10lEKBqAh2iEkVJD6w
         g8XBbecVWK00jgakA37TB7zRJ4zO+hVW5I5kLFVf2fhsbiykilgJhbQWDQuHSW41tNOh
         inzBmuIjZggSna7730tAXLOj0U42Xeln8+eCaBj02S/flq6x19sumjszehiC/vmogoDS
         4znMDt+sg4t++y2qk4YcuEbNVbIws8h47BXV21e+p1Coqct53be+yDQBgAfczHS+3e9n
         3WIIhNzNoC/gYqrAQOeKrjnGfWNMLFviTSk802pfx/FS0/R3oPrf1X88PyRlKWivGM++
         mn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778694; x=1793383494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=KJEU6/r6XVMDf+8NwYBlVS+T7lUMETP1Q0BiRVo6FlqE0bzcUD8ZqdR3nhHwVXRvx9
         8dftQZ3zMsIXrf1sTylx423lCOXE0CdLaYUPhD75QthSNmmOBE5LW6bH7V7DA2WeH+78
         3ZibdIZcpgkib1XHG+oQPmByFdt4QAezkCaOElFkUKMcj/hzRriDV++S8bq8mU+X8o4w
         FNIHLj0U1hYp8QToB6Cb0Hly16b0dz+CXUdpO0EIiSIynp/gFRdlWBuyecixLTI3/LkW
         3wCkjuOxOb2N4BI0CA9wKco45RPyjwcUesO7Yb1CJUop07lyw0xhS/0fzyJT1mjqcLOe
         Nq2g==
X-Forwarded-Encrypted: i=1; AKwUvBxYsecW4EnV8fsLSiPwL45WTFKIBTFRze4hba2up5twuGzu+cNxCl9iKOz6qs02qOnci5sdCT2XoJeWApE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLI4fM4Ovpe9QeVtrdrzEmgD8Fdd/BItnwOGeAKnmeXzf6Hsm9f
	BiEEIxrzQFAP6A8wmmYW6785auBZitVJBGComg/TMJQWTXSENK58glR8
X-Gm-Gg: AYBFou0/xDPiJwqtnCgrP1thi9rz5V4g/0IKPR1w0A9IUIPFd5qvM4RwSjll11r++0A
	7rAtUaVP4L+1UO4owSG92aJrXlgblYBgDiR+XfskyVZWlVN04KMbWElfX4Vg1CRPQsOooSlWW2J
	x5M28iYz1m/Lv14ezpIsHkVSaqIK8zlest5omGhlUF9ZgOw7VsZfjNWynYRKtMwAcyGGmUXXHAy
	lujj66R//kKGzFXA2mzAksRJx6UVAx1F/lp0oC8H+uyV2ZktB9kAZsinuiOaUKK32RBOMsBUckp
	/bc6c5iPRFhB0dL4Y85ry/IV86E3aPUryRlZLNHX48N98qn9uBNp8dRyySt0Q/vdZ6IBzZlsgzO
	qi7Ip4lod3lcDfzxkNz9jxKqt25lHJLjySSPIBO6T+FW8oah3qx25aO5DkiVK3x9HnqpAvzmKY9
	hHPZqxJZDBPZm8nrv+RKrbJhxFxCb5TZRktKWe8wmBx5MSAsqnWM7naB/OKr+zimdz6IPQddx1M
	D8UtI+wDirmnBq/B7dwMJNYwIUQm1l7cKAqV6oL1t0i5ioxmX0QJZdFDnBktlS1eF1GMVgetDxx
	nj0dkbOuixReLRwcyBn1kwiagsNIgAP/GZ5AOm0CgvmwrEdxZ+BM3H2NtVFoUuWTQY0lF+tVtqT
	XrJVeEX6dp34rASsZ2W2gLlw7KFvlJcRJLMCgie9A1KLNPOUk6x2qvxu2ALNm57pky1HdxEbw/g
	rqKA==
X-Received: by 2002:a05:6870:a706:b0:47d:a12f:3951 with SMTP id 586e51a60fabf-4a83f51992amr101879fac.39.1792778693667;
        Fri, 23 Oct 2026 11:04:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a838207cb9sm544329fac.5.2026.10.23.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:04:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 12:04:29 -0600
Subject: [PATCH v3 1/4] serial: 8250_omap: separate locked TX DMA
 completion processing
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
Message-Id: <20261023-submit-serial-8250-dma-cancel-v1-v3-1-d78f9e4c4932@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4805b644ccb1..b6f108d34854 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1080,18 +1080,13 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 
 static int omap_8250_tx_dma(struct uart_8250_port *p);
 
-static void omap_8250_dma_tx_complete(void *param)
+static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	guard(uart_port_lock_irqsave)(&p->port);
-	if (dma->shutting_down)
-		return;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
@@ -1123,6 +1118,18 @@ static void omap_8250_dma_tx_complete(void *param)
 	}
 }
 
+static void omap_8250_dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (dma->shutting_down)
+		return;
+	omap_8250_tx_dma_complete(p);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;

-- 
2.53.0

