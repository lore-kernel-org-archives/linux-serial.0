Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9746446821
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833911; cv=none; b=mLAYE8TLHrRL7FEAlhgGCReVpVczfp4zyBYcw+PL1OwCEHBH0LyiRO5DXgo/8r/LgLEay9mhUCMtg8OW3mWCaJ/kPqsbAPJD7CXGUmAGVFi8dpGGqxUpUTrJIH3Be8ibG9cI6wgNXg85MY/EA3I85wbv/WU3W8s/i2k+83hPQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833911; c=relaxed/simple;
	bh=gk6JcyJKTdGD6/CklPk8oD3ZXcxR4v8iNyYK3AygeO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k67tcTmXUAY5+ZzGNDqjhGrmcDiBPsq4eMpdwQ/LL3cp/j9FLs8FEFRZ8VBiE7KkR2yKfmkzv4pZ5n0zRi7AX9V7fX2MeQD+U422w6HL07blY4+rpFgry6kwuSwR8iZ0CyCMI83FY6OLn+UjFNWaQCMx7lElAVyXuctz+SxhjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gOG3vMqr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gOG3vMqr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b966dd74so16684155e9.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833907; x=1786438707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=92DZp8Jau+VN4V5EfNugjZTHDMsoIzvzLmLfhOU2IAs=;
        b=gOG3vMqr9FQzw85olRyy42Ok5ak5kP0Awls7rNdctN+LxE14/I7BN603jMw9T6f1U4
         VfplqLWcMzWKJwBwvBn7CVuQMgnQAY8wkTdF3Bfuj1yTGlJInmC7Jdo6qV/jNSLqA//W
         dQ1eUOUeRCleC1X02GNU4MLLqfXWcUN7Fl1JFeBy/1NmdOMdzwR+glW/b9XsB+3rhBjf
         SytuvdNWyH8ttjzHVdGTx92HciFXfXKo69ky5ysqUCDjBwOrNcEfPbr7jA1vL500pJfk
         b6tXSvzNqtvhfgSTya0uLiIYJwVBjXiXJnu+XxegkkieV2hK963gsOkd6uH5p8bmBYRL
         pW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833907; x=1786438707;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92DZp8Jau+VN4V5EfNugjZTHDMsoIzvzLmLfhOU2IAs=;
        b=riuuCqBiLGD71PGi8lPirmutCasir/qRxEx3q61VQ9n2SCz5jaeo6GsMoj5CmqQwyo
         3UTua3Jl3PbLOQxKVzkDd+ZIA5RShmsxDsGndF29JgQWwEXEbSWRA6Iof3sm/6h6JfMk
         N9/r/nslk/K7ChdxRSVl6SIrvY4XxfBbF6M0qd+VeJwpqUi+mZrke0IyN2E0fZTMIEHd
         ErogtEDF2QFJiYjZ/W+J707r6lkPT6RHTxYsBvobFIV32gC441Izo7NrsSJRvx09GAzs
         mtMK8xBflCLfFzBGvH6TP3Am4yQ0w94ptF6FoncaSVCe3wjgyEMP7bQO/XyuCiuPh+ym
         Xvbg==
X-Forwarded-Encrypted: i=1; AHgh+RrfKWE+YwKEU8aGDInbQj7MbX5dWcqMFtU7GOUMjRvSz17Egt7C98oIf3374onXO2Yiloxse9I6V5LerHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJp3EIsYFS7OeZ8sexoOOpwE9qU9WU7DyrXljNBOGpJze8duNW
	G0EuoDTcKHhCCdRResrLZx9i8anCwoOUIPVIrQMC4FyvukfFbIYLpFXZNu84vEpy/YU=
X-Gm-Gg: AR+sD10GDAkCXgfO/caePWFAB41aW+F7md4YKEtS/CWhkGX70U75Dh7JYcJcosxUAmn
	QNZZVWPFALd1aVzDqKNIeuFg5tABma1yQUZj+q5GGKMZQ9EMOYi2WwEc6klNG2OdY+8XILJdpMU
	Bzz8NqqBasychl4Fa5B5b4JOCi5UxogBIZwrgAMcYzcsQ3ol+TBrBQR/N9TB1DbZ4kGeRNALpvx
	0PbwL7wybpxk4jhJZv/+WiN4SGKWi4+9Qsyoe6sx69T41b4MWnHgj6A0l0B0V9eTYWP2uqeG28c
	TvlLM7lNBuhdk5tzMnpESfWE3OzkjWaOqRudY36dZlJTd/P+WHgP8U1bn/EE4S1eUnVb+3e8lah
	KNDK/p7j+YwWaH8ArPrftjtjIkalSTU0gpexG+Nieaamol7zlTGPyysxOYmSmr2P5ot/CNpqgL0
	eoJf4iyGPrww524+dvPl/44DdQj7io0y55HhcchYz1/GHoc/CBsMT0nELQb9dghm3nmO17DSmKj
	O53wlq4Pniw06Tk0c4kghLcbsF/YjRyUtySIFQnUJltc4sbpyF1
X-Received: by 2002:a05:600c:548d:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-4980c674de0mr339437805e9.19.1785833907008;
        Tue, 04 Aug 2026 01:58:27 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49949fef72esm81915375e9.15.2026.08.04.01.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:26 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/8] serial: txx9: Simplify knowing that .iotype is always UPIO_PORT
Date: Tue,  4 Aug 2026 10:57:54 +0200
Message-ID:  <b90344819432e493f54d557ec06e734e3392724f.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3377; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=gk6JcyJKTdGD6/CklPk8oD3ZXcxR4v8iNyYK3AygeO0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcamXaDiS3RBR0+qbBwNAwVWgqMVXzklKa4F9s t/YdciWIyWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGplwAKCRCPgPtYfRL+ TpYnCACULkPZUr2OmqjBZ4MUHej3MCGBPub2I3LblGvYBNm2YfQfDoGLZuAYNBbg0qBVyTm3mJM bUxKi6H8sMtNnKBtLty0PyEZMZSF6V82uzdDwH+7YRmxvrVe9rLnmWTmr4Hqsdpl+VxA0b39+fj GEGSIMOltQHQ2MlL6Q+O83TD/UP0N90zNodtJDuQNnM2scpvOxqkotvIO3RqRc1Vi7QssajpNWs ESUsFFdTH+3JJIBP9+EQPKWLioiJcmYC5X/AVMd/Y1Q8O4uDPg+ZbAWiiMDF/jXIdUSx0FgaaZo voB1fD6WCn8TXkmCdjK5cxf0WiDKKRhx5+aH1V7/a8zdz8+e
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After the previous commit it's obvious that .iotype is always UPIO_PORT.
Simplify some functions accordingly.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/linux-serial/01a84877-9cc7-8136-d5a8-e368a36cda93@linux.intel.com
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/serial_txx9.c | 69 ++++----------------------------
 1 file changed, 7 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index ef56979321b9..bda7f7527b8d 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -158,25 +158,13 @@
 
 static inline unsigned int sio_in(struct uart_port *up, int offset)
 {
-	switch (up->iotype) {
-	default:
-		return __raw_readl(up->membase + offset);
-	case UPIO_PORT:
-		return inl(up->iobase + offset);
-	}
+	return inl(up->iobase + offset);
 }
 
 static inline void
 sio_out(struct uart_port *up, int offset, int value)
 {
-	switch (up->iotype) {
-	default:
-		__raw_writel(value, up->membase + offset);
-		break;
-	case UPIO_PORT:
-		outl(value, up->iobase + offset);
-		break;
-	}
+	outl(value, up->iobase + offset);
 }
 
 static inline void
@@ -698,57 +686,15 @@ serial_txx9_pm(struct uart_port *port, unsigned int state,
 
 static int serial_txx9_request_resource(struct uart_port *up)
 {
-	unsigned int size = TXX9_REGION_SIZE;
-	int ret = 0;
+	if (!request_region(up->iobase, TXX9_REGION_SIZE, "serial_txx9"))
+		return -EBUSY;
 
-	switch (up->iotype) {
-	default:
-		if (!up->mapbase)
-			break;
-
-		if (!request_mem_region(up->mapbase, size, "serial_txx9")) {
-			ret = -EBUSY;
-			break;
-		}
-
-		if (up->flags & UPF_IOREMAP) {
-			up->membase = ioremap(up->mapbase, size);
-			if (!up->membase) {
-				release_mem_region(up->mapbase, size);
-				ret = -ENOMEM;
-			}
-		}
-		break;
-
-	case UPIO_PORT:
-		if (!request_region(up->iobase, size, "serial_txx9"))
-			ret = -EBUSY;
-		break;
-	}
-	return ret;
+	return 0;
 }
 
 static void serial_txx9_release_resource(struct uart_port *up)
 {
-	unsigned int size = TXX9_REGION_SIZE;
-
-	switch (up->iotype) {
-	default:
-		if (!up->mapbase)
-			break;
-
-		if (up->flags & UPF_IOREMAP) {
-			iounmap(up->membase);
-			up->membase = NULL;
-		}
-
-		release_mem_region(up->mapbase, size);
-		break;
-
-	case UPIO_PORT:
-		release_region(up->iobase, size);
-		break;
-	}
+	release_region(up->iobase, TXX9_REGION_SIZE);
 }
 
 static void serial_txx9_release_port(struct uart_port *up)
@@ -983,7 +929,7 @@ static int serial_txx9_register_port(struct uart_port *port)
 		uart->membase = port->membase;
 		uart->irq      = port->irq;
 		uart->uartclk  = port->uartclk;
-		uart->iotype   = port->iotype;
+		uart->iotype   = UPIO_PORT;
 		uart->flags    = port->flags
 			| UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
 		uart->mapbase  = port->mapbase;
@@ -1081,7 +1027,6 @@ pciserial_txx9_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 	port.flags |= UPF_TXX9_HAVE_CTS_LINE;
 	port.uartclk = 66670000;
 	port.irq = dev->irq;
-	port.iotype = UPIO_PORT;
 	port.iobase = pci_resource_start(dev, 1);
 	port.dev = &dev->dev;
 	line = serial_txx9_register_port(&port);
-- 
2.55.0.11.g153666a7d9bb

