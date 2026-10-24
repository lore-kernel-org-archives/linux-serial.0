Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792818995;
	b=s1gyoh+4KemkUYADxxMswjgGg/VuX60hFoDgjmX+E0u4hNEkKN8UR/Hn0vb4DjBgGOlA
	 enaoXPkowrfFQVrUsUEpQZUrAMo/wJ40EozWUZVMWcuop35u90EPneP7w8+jLSLxlHv2W
	 RDU7OWnwWvRBIEDlZoL4q97EeGbdOB+PllUBFuqGPaVK1wx9egeKGmjxUVMWTAQAAyXPK
	 Bj8kSVRPXso9jwiSnobv6U3YbBbDisxFdXzhZioomTxzXoLrMYs2ZKSJFhCXYQza4d/Xs
	 JvLnBHHW+D9/5eqb3bFmAUD4CJNZJMU5yJRN7oPQQkqozyMcYx010tHv/TdsaCvEwCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792818995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HXzEtDGwOk5WnadgfugPpYWOH9KPkM2ozlPjHTw35RE=;
	b=F7VQVljyh9nA9Cod7qCjNTF2DI0LCo1C4MSv27n+jq3wtz3b6Ug58/Gp14D+rn1rD/qt
	 W80tq6hVO04luusOpl6+BIMNpc2KzPbNtScixf4JuPsqYi15//IsE+QYplCPQSNQ4adcB
	 nwK9dm9x7iSDkz0ch5wrYbrHZdq+FIFB6DVnLQP7tGe68VIgJlftupTWw/pOLFJVfQRhK
	 1Ri0BG1QDcO65P84EVnsDcBWG2965jPp5L3L2Ro8pvuFVyyCOQsJdya4F7dOqC2vYY9ME
	 BptZN5gHAPEhk5octz7/IKNdxCre9pWC2/V89oC9sv4sAna/r/o5A5cFwZmnVZVQNqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SJKOCatG;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C45606A322
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C45606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SJKOCatG
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a208d93758so15613915e9.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 22:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792818993; x=1793423793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HXzEtDGwOk5WnadgfugPpYWOH9KPkM2ozlPjHTw35RE=;
        b=SJKOCatGK37boERyX5adGldwj8VveNPWPKFSXYUFSJSWYrq/74OCGXFP4va9YiM2Mm
         4IoLbLjA6R1AvYVUIprdLmF+V+8Wb6q3rrbCQf79icXZo3I1389x0AqBQptVsjfPr/n/
         YiIt4KtOkddKO3KNPDAuYrBlsQQmV9r6PqOJaqP3bE4TBDrM27OHz5+FyBubY2jvKynB
         xhyxYjmHz5hBt2kW10BEj1YwgRNRU6F1dmlj152u3uqca9uGSBzFb632RPE4w9lFSYJS
         muPJ+Amt//Gxqgvbp2SU150EOWeSq1X1wHiMD546DPnuM9dlS0dQpmTasRFuhFoCUxXc
         tNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792818993; x=1793423793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HXzEtDGwOk5WnadgfugPpYWOH9KPkM2ozlPjHTw35RE=;
        b=Luzx77LBwphS2N7tek8a13ZQVZPPsVBIl7K1qohlz31lN7+yw0eNadidKxQ3RmL5yA
         nHsVyPX3W3zg2btFo6zrNdcnVy+Afy2tCNI8u9bwx3c1oosrc22mcBUClwCHiCWMTPer
         LGWmFpdHVA2IDsiPZHf3zpkjGbU4Qsy5D5t9plg42BP+4rf4o8nuR652JuhJzw9+8dqK
         1D3Vkgqw65sKA6e5x/Vj/NZsrlFWZ7tXJkMp74N1Eosfx20Um4H3MxJ4kW9s6HILwvNJ
         nHdPNEselqA54huJBIGfUkqo8OY4RTDlBXXgxL9ywhG6PXPawjFzM/9MbRMFj8W28mRO
         jwxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNFkf3fFGFBvusOELMshuYd1TlTk9rohkpXNEG24AkFxDbMc4DDaBpTAdn+RqML6ucesAQ64SktTepovY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKA6N0MCxBITOFSRyZKG2qnkv9nwfLC8aBNLDhkPLxg0TIOwjxX
	/5nna8cnLRtnjjjZK9ZPP9DTJ+ygnBKgGTq2Qmj7fe6WaL6azi1+LgcjJBZawAGlSLwAvgr1a3W
	cWh9P3KQ=
X-Gm-Gg: AYBFou2vycsaDOwkiuAHqZ7Alkke3+EA29MPeOzJxF9ZgmPEY48y2+UXGxs8zBwJ32J
	x7KuurD2DKHnXKgDgpgr/Y/foIfJUn+gRVvMiZnw7uIoCnYt77NvTCuCanx0THgNahpDUcOQGQA
	TtHTpVAXhziAU/jqQ0yC7BeIXqKiv7sYSBm6bfPLO/cwsDe7I4A2KqgWCn4sQWSdu2gn9RV9Npm
	JTzbXCxqkj3rXkIqx5Rnx6RDo/yXFefZ177+3Os1TNSUfCc4XtPhdp5tUAhSG/Vh5DWDo+mhZbh
	81Tzq1cutfxcBs9xC6p8HGNv50XIqKue/4pr5quxbkjA0LTHAIrUbeuPpvTreOehnKuTru+a721
	lnF3bDUnmFygRbZcPdJ0BOPVDJnEjbXkHb5w946un0bKGdZRtdmNLf3ctkEMCXpc/eXNu0SEh60
	ZIH6tO2MS/SvktUtp6jrl9YNtpE5qF34oyZ6gON6SV7sdsLxVy8kR2mUkr4QZsffVCHwk2Ye0tg
	ABOxdPxgvtd5b8kbFDnFCFokdOVQ3khWpcTF1UaTILlHvgpWh/qod208S6rWJY/TcjRrP16Sx8J
	pBUeizyHa/8=
X-Received: by 2002:a05:600c:1906:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a35acc3f50mr11902195e9.34.1792818992913;
        Fri, 23 Oct 2026 22:16:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:89bb:701c:1852:56c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e9aasm27604415e9.5.2026.10.23.22.16.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 22:16:32 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 2/2] serial: 8250_ingenic: Start the X1600 UART from 16 clocks a bit
Date: Sat, 24 Oct 2026 07:15:15 +0200
Message-ID: <20261024051515.55639-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024051515.55639-1-olivier@mgcrea.io>
References: <20261024051515.55639-1-olivier@mgcrea.io>
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

The X1600 UART samples each bit with UMR clocks, adjusted per bit by
UACR, while the divisor the 8250 core computes assumes 16. The driver
never sets them, so the UART keeps what ran before it: on a HiBy R1 the
vendor kernel leaves UART0's UMR at 8, which by the register's meaning
doubles every rate set here (the line rate itself was not measured). The
Bluetooth chip on that UART then never answers: "command 0xfc18 tx
timeout" from hci_bcm.

Add an X1600 entry that writes UMR = 16 and UACR = 0 at probe. The
offsets come from Rockbox's X1600 register headers and match the UMR
read on the R1. The X1000, whose compatible the X1600's falls back to,
may have the same registers, but I could not check one, so it is left
alone.

Tested on a HiBy R1: UMR reads 16 and UACR 0 after probe, and the
BCM43430A1 on UART0 comes up at 1.5 Mbaud and streams A2DP audio.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
The test on the R1 ran with the same reset placed in the X1000 entry; the
R1's device tree lists "ingenic,x1600-uart" first, so it takes the same
path with this version. Build-tested with W=1 on tty-next.

 drivers/tty/serial/8250/8250_ingenic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 0cdadacd7019..40307189021b 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -25,6 +25,7 @@
 struct ingenic_uart_config {
 	int tx_loadsz;
 	int fifosize;
+	bool has_umr;
 };
 
 struct ingenic_uart_data {
@@ -40,6 +41,10 @@ static const struct of_device_id of_match[];
 #define UART_MCR_MDCE	BIT(7)
 #define UART_MCR_FCM	BIT(6)
 
+/* Clocks a bit, 16 for the divisor the 8250 core computes, and their per-bit adjustment. */
+#define UART_UMR	9
+#define UART_UACR	10
+
 static struct earlycon_device *early_device;
 
 static uint8_t early_in(struct uart_port *port, int offset)
@@ -298,6 +303,12 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	}
 	uart.port.uartclk = clk_get_rate(data->clk_baud);
 
+	/* Whatever ran before may have left another count: 8 on a HiBy R1. */
+	if (cdata->has_umr) {
+		writel(16, uart.port.membase + (UART_UMR << uart.port.regshift));
+		writel(0, uart.port.membase + (UART_UACR << uart.port.regshift));
+	}
+
 	data->uport = serial8250_register_8250_port(&uart);
 	if (IS_ERR(data->uport)) {
 		err = PTR_ERR(data->uport);
@@ -344,6 +355,12 @@ static const struct ingenic_uart_config x1000_uart_config = {
 	.fifosize = 64,
 };
 
+static const struct ingenic_uart_config x1600_uart_config = {
+	.tx_loadsz = 32,
+	.fifosize = 64,
+	.has_umr = true,
+};
+
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4750-uart", .data = &jz4760_uart_config },
@@ -352,6 +369,7 @@ static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
 	{ .compatible = "ingenic,x1000-uart", .data = &x1000_uart_config },
+	{ .compatible = "ingenic,x1600-uart", .data = &x1600_uart_config },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match);
-- 
2.39.5

