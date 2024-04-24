Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881D1422B7
	for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962144; cv=none; b=J5AkYuLS8c8ggXKtLP0hY9jpYlIaeLLiIuBGdB+3dtY37MtiuU2qyH7VJKOOSDJzXvJ/vnJqc4YeATyGVUEZ/cvR0Q3LTae9w0KrG4ALnwURXpw2sGoZETm4/SPLD/YW9ize/b+6B2b+yIPTNhL0XeX04S/dwhrY1m7l85P+k9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962144; c=relaxed/simple;
	bh=tz7Oii86HfqXKdwoE4jn2iaMVvXTeikBn+Xn3ghijUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tkrp4NX6jKDe8CwEyuwHQjRgxFPPnZZJSAuCT/690j2LxZ0/jOYSO1KNdCsLlYKrJqk3KTHCn4/ZWph4lUt6hT0PVWs33Mm2Zy3n9kfX0rQLrhLJvR9kr8YkBCGmXPh98fuGupmW73PZeh9CkRo273pkc6Z1diYL0U2+sAXQK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/qGcbEb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/qGcbEb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3f17c64daso44433435ad.3
        for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2024 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713962142; x=1714566942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5X7I2pd4YE3kiP0pgemZkKwYiW8XQQ/yrWjXfFYyKc=;
        b=H/qGcbEbN19xZL4OXU3zgktrE4MvuLKlfCyZrrO/bXiahI/DMoFL6RicsurevG36z9
         Secx688uFBjGYPPE72Md9/tELPWvN3Rcjq1aYDjz4jUj5+O4TQKveTyDIOmnuwJx0g6B
         Gc1AKajwu84X9aEbsaci0CAZkmeWAXVOVUxtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713962142; x=1714566942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5X7I2pd4YE3kiP0pgemZkKwYiW8XQQ/yrWjXfFYyKc=;
        b=H8Jqdg4Y7lzAOmfno2joRFQThF0qytFKqewFXGlNHLhXT2Tr437MfwRP9hDPyl8w6o
         Rp5tIODdI3EszAotzJh+2biYW7pkCFpAsDnUmd+RxcLHAJMlnvTwJ2qEMFCUn9iw0iDR
         p2xjNw0D6qlNn7LaUaw5lwk40H/Fh1b+urnwprw7p9PCsqHcXpZ74eZ9C9QQhQu9/+VZ
         hq8kuUFQftmvcZ66+pyPN3A7dpNT+LcLRSZeyJSGswbFJx/MTvfQLdrtoCkGgQTQkIKE
         ammL8KBpUoFqU4WC6+bOECuq0WiH+VVw64txI3o3GUzb7g5f7L15Z82MTjM05Jg6rRMD
         S2IA==
X-Forwarded-Encrypted: i=1; AJvYcCWr3EVgXqg2YTDoc8xhR/RioYYVOC73hQxcLb+bm5swlAx0ADhpQzb5IRVC++Ign5KN1GaffdK6rs+vjEWb0LPZwtralXz+VNR68h4Y
X-Gm-Message-State: AOJu0YzBuQaGllr+Y5Q2s3WnrR6nR/HoLxi9K+tx0AAhyOo+9Innp1Gi
	bWAWBQ7tMu6AABOfNOytisKYK1sLmZV8tnqpj0TwoD7/wjVER/BSS97ZxeR15w==
X-Google-Smtp-Source: AGHT+IEuUAZNA/Wxz1q95leP9HcOFZM8mHKpCqv7tHCLZaCxrPO0Fns8nowhDeSKlbiYYDqIEIkIfQ==
X-Received: by 2002:a17:902:e889:b0:1e6:34f9:f730 with SMTP id w9-20020a170902e88900b001e634f9f730mr2468612plg.52.1713962142435;
        Wed, 24 Apr 2024 05:35:42 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:836:835b:e0f2:a3a0])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001e28d7329e6sm11826176plb.91.2024.04.24.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:35:42 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-kernel@vger.kernel.org,
	Al Cooper <alcooperx@comcast.net>,
	Archie Pusaka <apusaka@chromium.org>,
	KidmanLee <kidman@realtek.com>,
	Hilda Wu <hildawu@realtek.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] serial: 8520_mtk: Set RTS on shutdown for Rx in-band wakeup
Date: Wed, 24 Apr 2024 20:32:47 +0800
Message-ID: <20240424123331.2872272-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Rx in-band wakeup is enabled, set RTS to true in mtk8250_shutdown()
so the connected device can still send message and trigger IRQ when the
system is suspended.

Fixes: 18c9d4a3c249 ("serial: When UART is suspended, set RTS to false")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/tty/serial/8250/8250_mtk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c365a349421a..b7ed55eaf05b 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -209,15 +209,19 @@ static int mtk8250_startup(struct uart_port *port)
 
 static void mtk8250_shutdown(struct uart_port *port)
 {
-#ifdef CONFIG_SERIAL_8250_DMA
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct mtk8250_data *data = port->private_data;
+	int irq = data->rx_wakeup_irq;
 
+#ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma)
 		data->rx_status = DMA_RX_SHUTDOWN;
 #endif
 
-	return serial8250_do_shutdown(port);
+	serial8250_do_shutdown(port);
+
+	if (irq >= 0)
+		serial8250_set_mctrl(&up->port, TIOCM_RTS);
 }
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
-- 
2.44.0.769.g3c40516874-goog

