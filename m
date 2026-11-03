Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742007;
	b=Z7yVR8sYX3CAYJicZhtSypST38Lwvc38GFy/8j4xzl3KZi7N2oHRVwChEArWQ54nvQe+
	 1B0d0zx7MK9zmHuHOClj2iJkXwV9o/P76B+PzDh61SjJ4AFXtXuCa1y5kdyEGsKVwUbTw
	 JaQspuk2u/yn1LfnWPppKqlxbXlTRlonfQA3fTpaB3B7I4V8v4fbtRLiQ5wFYe7e5Z+MI
	 3Bjy6+yQDL+EOCFJHfOGdCuMHcTfiosI4TEvqwqMRtd/wzrmmHnTuZdwClY1Np7Iszucn
	 oIoZIuYpRjLlV2bgCA2o7TcPsj3E0qQ4bVM9IMARHYHnC+Zteapvh/k5a3yS3MsYZVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AaGB+sHBwtYVccxB8PUJWA10dOr1SqV2RJG8RV3nZJ8=;
	b=IVXXBRn2NnEJo+UwoP+DAziaYUmR2CtrCnLGw3C/MMI6amxfxH8v8RDIWhl1qBkxwFXE
	 3M189DpfhwLsnd1TxU+TmG6u1spPWdflF1Wr8kd2q+ug25Ehgs0mkKeVooXkKYg9BcecH
	 d6YYYZkJnnhMIPIxLNeF96DnO+uCC1FULx2nGdyW4IwvkEptbtSRHUj62uVD/fwwQYlZ8
	 4VG9SHBeHYg+Rl4BdrT6zDqQ057Z9LjJKp+5pnHzqsDElDjKNLKzppAJ10TJFSbS7pPUn
	 kT3YBfzGE8XxbieUJPvKx34c4zc4IXniZCEhypTSINrfjmQ+IvkpFbMbJ9XXitMrWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=re1wsBE3;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06246606A330
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06246606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=re1wsBE3
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-844a8bf7e25so14668a34.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742006; x=1794346806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaGB+sHBwtYVccxB8PUJWA10dOr1SqV2RJG8RV3nZJ8=;
        b=re1wsBE3N5usOw4SMgvBcZi5X1IlLIbBEsqlNIwEN0P8G+Vwv9Og1ZP/8DHVM6Dw8c
         ZT0tNq/mWh57pbDNcekGJPfeOm/FPYxv1GByDUyuTD6z52XTS8DZMD+Y5P3LQ2sRpF4N
         JUUYgq34+HCzgmBek0XQhpin+i8y2TafiKZXhIjZugWmMbpLtL20xkuleuKRYhiazBmY
         AvKP6COJLdHweYkysqw0spaDo2mWsiqKUe1s+RdLFjO7LsbUbTzgKlciA86Q0l9yZxXo
         9NCWj1CAoWYiHx/wLJF2vnupbALRk1dHNrvRjNxNCpTbxYvTI+wSCTIOn1Dvg81Rs6mj
         sT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742006; x=1794346806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AaGB+sHBwtYVccxB8PUJWA10dOr1SqV2RJG8RV3nZJ8=;
        b=BMbUFTJIgOBZvDj6WrJQ6FFsKwfO3NAkJr/fE1PNnWz+Gh3tmw81DR7lfZIq/vEbzk
         vt8wW0erRsATEW9+ZpJP29YN6fDMmxPzNfHS/u2fEVnAd3pHjuFJz1C3orMOH4sQ6zhk
         AOLTK6YmfGZ3pfpLVIvsdV4DYHWvv3nRrubyl1EuCKsetU9o6Rw0ukBG/ZfDjR8LmkVF
         sf3VcVy4Vg0NsoyNdbAFnftCQBQ+MXzKR46XQzlJ3Mkenh4XPlU8YWDJZynDcPFS9rxe
         YMV3V2eUmLV5Fegh4rwAhG/knV73b6bW1/zR9FMo2C6PUEDpu8qTFqeE4+ArMQM9hG/M
         KW5A==
X-Forwarded-Encrypted: i=1; AKwUvBxmqIYf3zSe0+lQXGwWsCjftiGtzjDL+LKIJp2OL+7XMG4UJhrNjhJOADczOobDTT68fGnoWRZEvIU863E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8buMl7MHTdSiOKe1CSPMjCpLTQvO8CT1fD55BSTtC3pGZ+L3Es
	V2nk3arXHnxkbS3Bw3emMbD1AvnkW8Uiq2Ju+i2wTTlFaFAyzdLQcmFUVXK8gCFw
X-Gm-Gg: AYBFou3TZ8ULhFwGt+DfVGWsb8e7wNbg/GAArQPwzjBvUIgB0pYAwmsEgWLI6fWKzbF
	YyWx5nSDmOI7IVjelO6vYHMT2o+mC4qDFimlKOFoJ5s50KXO+DKG1/fJ0WjXzQLj6BM8Mo8RC2k
	tWgm0lKdAznrH8Kma6CZr0XhNlVZHB1fVizONUGvCrjUOBchjnnURsxv/TFBTrNGACnCWoKF8XM
	HI1wGEg8EIERgjGsinz/XhGV5gh/lHJVb081NYBQgeiuGFs9fDJSG1GgbwXm/YwPCVkxVVaOwD3
	LjK4AN9PIOtLjQ4jS+emBdow+5XTvZ7snIZDxHhhRqM85yAtuCUZZGJOcH1QCHC3v1AighlUWwY
	qcK6mfTd6BI8isy6lasDLQgVx2UtLlebdukqnO/GM0EXHP5uy3aZMFVPp6/zIFGBT1cKPLHxnEJ
	vn254pAzhxXoXz8UMaNhDI5NcxZ/asYky0XyrtE+Z+B0T9EtYhACT1+4z+ep1y5BLEAmDZIiB6n
	5Tu7uWNey+t8SNn+TZHgXJQE3df2xbQTtNbv9b+JM7uvD/eTc+4hN/ChepStYXeQfSMFvWJI9HL
	3Dom0saEe92IAJCtuWlBtV2wTmHWaKlgElq9a4dHXVt0Yv/hhWc5o4eJsZwJcDmTrWEqZJLy0Kn
	fuzPigjqAkLFt+rmGPF8rNApU2GNpqbkIXxKQvkOfJ4dONj9HSgGh0ZDOGubWfwvRUJ4i6y7gj9
	f8SCITVGaUzXqVp3LkiezzoyB8B3Sedu8PZZIEsP2QJ6PO6+MHIvDe
X-Received: by 2002:a05:6808:1a0f:b0:4cb:26a3:a0dc with SMTP id 5614622812f47-5640deea675mr10671861b6e.20.1793742005972;
        Tue, 03 Nov 2026 13:40:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:39:54 -0700
Subject: [PATCH v7 01/12] serial: 8250_dw: select port setup through
 platform data
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-1-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Select feature discovery and DMA attachment through a platform-data setup
callback. The generic callback probes the optional registers and attaches
DMA when a FIFO size is available. Integrations with a fixed configuration
can supply their own setup before the port is registered. Allow setup to
return an error so integrations can reject invalid configuration before
registration.

Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
platform and continues to skip optional-register probing while preserving
its existing conditional DMA attachment. Select the DMA setup helper
directly for this integration. Keep generic setup for devices without
matched platform data as well.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 41 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9cbe076463e0..a546cf2de7b6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -64,6 +64,7 @@ struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
 	unsigned int quirks;
+	int (*setup)(struct uart_port *p);
 };
 
 struct dw8250_data {
@@ -76,7 +77,6 @@ struct dw8250_data {
 	struct clk		*pclk;
 	struct reset_control	*rst;
 
-	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
 	unsigned int		in_idle:1;
 
@@ -596,7 +596,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_out = dw8250_serial_outq;
 		p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 		p->type = PORT_OCTEON;
-		data->skip_autocfg = true;
 	}
 #endif
 
@@ -631,6 +630,28 @@ static void dw8250_shutdown(struct uart_port *port)
 	d->no_int_count = 0;
 }
 
+static int dw8250_setup_dma(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	/* DMA setup requires a FIFO */
+	if (!p->fifosize)
+		return 0;
+
+	data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
+	data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
+	up->dma = &data->data.dma;
+
+	return 0;
+}
+
+static int dw8250_setup(struct uart_port *p)
+{
+	dw8250_setup_port(p);
+	return dw8250_setup_dma(p);
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -765,19 +786,16 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_setup_dma_filter(p, data);
 
-	if (!data->skip_autocfg)
-		dw8250_setup_port(p);
+	if (data->pdata && data->pdata->setup)
+		err = data->pdata->setup(p);
+	else
+		err = dw8250_setup(p);
+	if (err)
+		return err;
 
 	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
 	p->set_divisor = dw8250_set_divisor;
 
-	/* If we have a valid fifosize, try hooking up DMA */
-	if (p->fifosize) {
-		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
-		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
-		up->dma = &data->data.dma;
-	}
-
 	data->data.uport = serial8250_register_8250_port(up);
 	if (IS_ERR(data->data.uport))
 		return PTR_ERR(data->data.uport);
@@ -860,6 +878,7 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
+	.setup = dw8250_setup_dma,
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {

-- 
2.53.0

