Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563605;
	b=tSywE0PZSvPk8sNjrtj0+JCvp8GWHO2I3AfbNW/QngN7hx85fdQyk4jZxP11tGvrEV6H
	 +Vpsnjv/VT6/mEr768qxovhBrIyJlJZCsvIjt1uodX7bTR6XXo1KOXyL9faHxvz54iWQN
	 q2qEAEPcuQAFStlYmihFCfepzvHrL+vZQRJvqdK2hvH16BtLVD5Z4bfaVSMrsFz6isuxI
	 mJtG+ygQbAAACkjUhTafW3LNJsIYLSMTlLDIG+c6VEx3/HRz1BdfZmmri012p4ySyBZP9
	 9cxUITApzvzHPn6c9pvut6idnCmlyKM7DTuQ13dUmGcKY05HZgx++hcAkE04FGOg05A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	b=2sh9Yes/UgZSDCgMM+k7xPph5AGZwsDDc3GUwMhRWzBSIn+BJ5usyiIcoxCbsaE+HiO5
	 GSMgilBNfU0A2z2cdhHCCwG/lszT84zv9kthw4EJqSqp3RJJaJ2VnODhCmcp7vDDvRPac
	 8VUuQDoCxr7xn5pn9awIlV3m+lDivxKFmVxoUrLUn2wPin8PShJO82vuQ/enuyvzjx1lD
	 vQoGvXCRo9k5CuGkO1PDNm8T07tTNYjKzAjs4b73HKnssaar2ZMyw4QkIuVshbVKVg5Li
	 8iwdxc4r1D6EMiOp/nG8JgHwBUO9TSDT+Ok3u54QOmv56zHyqzuzqd7WYaDFdeCRMdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O8DeprFB;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00A606A330
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 09:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B00A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O8DeprFB
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4ed6d69bdfaso1117546b6e.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563604; x=1795168404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=O8DeprFBEdI9bBIP6cKC89EnrWXR5oqrxsfN4CwMFW9t/NxDrSMpK1a9/xEocxH1y1
         b+RXDH9+zuv+3SAdXBFE5oXl7C7HmG+dBpMulLB3JleTH0LB9/FAo55I/160EuYSo396
         jCp9jSHXAW/tJ27Guqg7KvXaxV2AllmEVxHEcazsLc3vsOajF2rJynD1epfL9FhPZ3oB
         ugzAtUnCmUqwQVYjXagqRAtPn0WUTADLAZGxZ+n2gRQ90Xu3shz4SdBokQkErgpUlSux
         Lm6BNcW/B/IqKltOHyM0yDJ7Rmz+VcZPu13vLtpqWzxolJ/CbeY1DSd7uzCNmUJA4YSe
         cFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563604; x=1795168404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=DghaQz20HK6FWoro2sQwxGfRinW5Xgev5A34xO2QhL5VK6PUflNSBXpPkhgSIZ339q
         SuDglJ5/OM1eYaDCeDty5XZGxXV9UQZa6hYGPsaoHVzUnGL40zGCLOsVw1MnucfuReT8
         2K6Idh+WSwpubVZQBVpET+YtxSnl/KGKQXk7xZJJEPrIgMpGBo8eIFBKTsqHjGZ7RgN8
         ITlBPmADmWmGotih5m15I/BQ6IbypZb7FENbAEOTQtPxK1gIbn1UEL5N74MaZTH1E00u
         cxChHDXDfNAsfslx7POeepD1Yf7Qs/u6CLc6dddB5R2niblk99K5sCXllR4W6cp+ozDT
         V+2A==
X-Forwarded-Encrypted: i=1; AL+hErE/rgN26nBwlUd41k8WkRwP5hM8zRWP438Q2YDzCMyKbXD1UAa92TlWQgXcctU+qMfLBHsAylk+7zKFJYk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8J6QKbJDuSnpYixSXxo1aKvWq5P3/bMOK8oTDmwyqnmIH6Vr19
	3TdagJucXpEoIsV+DAEGhvSBYDS/gNcVJhTDLAlYRjizOYiZ0lV4SgjF
X-Gm-Gg: AYBFou12Pejw3fGy+mnQhAFU3Z8ddu/+JBw3YxXrZpXofkvb6HNzP69T+wqWZX90/2F
	apSCM+oM9ZJlGXcNzMc4NgRt5Jpt06o7QgwRf6oktHoHgOsFhITzUVW7d5XYlr7aFdATfYj08Xn
	BwaeZ7REnBzj2TAagxgL+0VRDm6c1O5eyHLeGYBl3WMns+SSN9Ob615VOAWsEZ/DeclN5g5jMGu
	R9/8BR48g78wH51HI622d6zGyp732CUWHgAg/cXK/JE4Z/BALpNVvFljLjVWlBK/Zrpy0YpnI0i
	kQ2AWNyUONIecSKu6JR1OrdNOQOy2m0piaTKv4ZWlCgWqfqRch9jYKRP6tFw3P3GA1/jVHvAYCx
	zZXMxh1aJ+VB+FPB7fUy4YEEI7x/U+cjDu1c8AdAtDrNFkir4PyDOa8d+TcLCinn11Aq4blZNxU
	AA7DVU6XyC7qDBi3LKKtk/+A7QbNoFkpYshBf2sSETJLmi9bs7u+c/2jCgdkmbzMkDgAxwI/2XX
	ntSGhWQ2Bq5EvY/qOUT9E8k8K5d8+AVKj5LXuSazYnsUyPC33ZQsAtXra5lUzn//tkDsOywEuqV
	uJm6pXJ7frnBxCxj6pJ7SsT+FiO9v1kiBT9+KlyXRqnv6XUd0wQz5miEKIXDJSYNGGXnhzJHaV3
	YzbQy+CExLScHn1LWSVJQEUUTjRaWjJOl0heQHZkup46M8d/DJTDgbF14ZoQC42mHtPvyNYvmWm
	PzefJu6w+67PRQPlAULsZ5nuerrnedZvCShLojTeUw1X40Ex1smUlWeFwAkeG0wad2HLECFirl
X-Received: by 2002:a05:6808:c1b4:b0:4d5:27da:a492 with SMTP id 5614622812f47-56e65a26806mr1379942b6e.44.1794563604182;
        Fri, 13 Nov 2026 01:53:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:14 -0700
Subject: [PATCH v13 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-1-b857f2617ece@gmail.com>
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

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
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

