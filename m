Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873356;
	b=qFiLmPjYo64Ey3B+R8XQ1OeV66IwaDcqm/kj/9/PgyYzXHyD94oucGAPTD81A2Lw6OvI
	 67G6tYORcRnUqCIWjDeITrZ1L70gHVnuQJjMTDOhYLKhSTf4NoAk1g0xJwo9fHGokDgDC
	 HWg1OW1pJzqiDHtAkGnKImwjzDc8EMNTzt3KTxzFQdqDmSTG/RUezj76if5UXt2L+5gja
	 vWYpScAfA07HQkVIdrT5YKxEb5P4SF7dgyJ97JJCiRN6EWqcBafhwyQ7cgSHWDVZhtLlD
	 DDp1JluNQ9lrA5mpSkOYYcjoMQwJjc3je4P9VENH6mzpraQpsVb5fSOv1pIE44BJqbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YTxJJJ8fbTcAU9VqNhqp+UqN8RZ1Zq5MlC0xiBzcrfM=;
	b=ZI9/++e1f1/xEonYdpNkID3AFD3lYetB3EgT6MHGgAoUtM1DCmUyvCRQEhbnYtC+LQdD
	 ObQEkQMAfeOlRu/1IF1PBmR4wO611EglymT7DUbvxrekBRaXQJDgUHVEZEEs8+RlaZtjH
	 gH7dPkbgIuaz2lYGu0p7lVAY4Itr/Cngw8Wa//N2/Y/koFBVw0Hmdq/F2wAhMveFelI1o
	 FKkv6PG59bz90f61eOPl0j3Q4VCG2E8MtMz+Sui4KOEycQMom4VvvsuR5BZyZzja02Neq
	 UuQQ0MHy8KxLd9KFg/accwPJ+lDRpL/rHbMolfy+yjdJ6l6V63CCTZR+/0VBzzzv4Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i6G+YSE2;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6C606A329
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B6C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i6G+YSE2
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-55651e7de9bso1043278b6e.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792873355; x=1793478155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTxJJJ8fbTcAU9VqNhqp+UqN8RZ1Zq5MlC0xiBzcrfM=;
        b=i6G+YSE2VtuPXvFmigV45DZZLCH6LB+XkG5kfejVXRhCgum2x/GkbzfSq3f1FtjFLt
         A/k/PV/HiOSWfoX+TuzckdEWAdfd0jVZZtNsWh2nGw2rQTKgHcck3DcZ4viCwL+v1cu6
         Gi3M8ht7pwLkefdSvbUizVO3r2f7Z/u5nJ3Yk29OFmRKrX7N0SkJn/3IsdEwbrssEHXq
         QIpqpkjoLrKmzMntlP34ejWW3qK1f4w8EOtQwvVY5PnhWk+lwGNyPOmoKIt0Ev3xIKUo
         gH7oZmipSqJFMpi/M8iXt+hvhMdkqVRaguhWtx2ptIvEiQ9nL09P4B2dlisWxhpM/dWe
         aS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792873355; x=1793478155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTxJJJ8fbTcAU9VqNhqp+UqN8RZ1Zq5MlC0xiBzcrfM=;
        b=cWam1fm2JZh+Jx7sTxz/t9I3WjesbQLut3q+0+x/MFXzsIslM6F1LQkVau+tpkpPF5
         4JgiXksS778QsHUiO7eAZWnp2RPmStvdayVNCFNvHZN/bJ42wdN9HCHM2mRmBFwu4+T1
         U36SdLFiHnAS9aD06DZqOKu3UowzVVDH/hZ9Wtv/ZRCVPO/Zie1YYHcSqHXV0Jl27qGe
         Ty9b1quY6Ml7oAa2ponDCwPLXi+8pylBJ2n6NZ8Pf1zX8NyjOsGWnPJcVwoXK+SVYBx+
         Dew2xuadFmJmnwmlJ/zCzsyjP6f7UFVXImRwerHvb+JHV/Y9ORRQnSMpR+yk5DZ2GK+/
         KxAw==
X-Forwarded-Encrypted: i=1; AKwUvBwTI+mjlQ59JPFkYazHdbk4gwLg94KybUMjxSINXCnPJyRETBjbLY0wdb/YiLC2ssXgUWoBYIN6nh3FfXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsPRfF3sNTtSSkAS2NEZyzlUEDoZHbl029FF7GYfWKsDrZfhvO
	fgcOpe5JLaCHzNF4Cd2XuknaGKa68dltFaVPtCBb+E/fdjxytz9g7ZfM
X-Gm-Gg: AYBFou0T887U4q4pRQcFt1dNuvJlpd27tj/xXuFGizZKg/IC3F8J0cL92iwu+9Du6XQ
	0RfRgGHqRuOkAZBkXKyYPa703WRpH9KNfS8kOenT7W+BrTtEknuz6/TMJiKDUVydZqCqWrdthK5
	xI7Sy1uDJM+NPXePtQ76TiG1EmwHPpZDygHR39yFg25Xudk+5YGAu4wB+pr3o1TY2THoJwoipwZ
	WTvINJvDUTn6YCxzYtgI/W4KBD4hjVu9lbb+i3Eil6JELgz8F/2GcpUnEiEajsttjk1G4uzmhXY
	fNkOgFv1H5Iv+lHfLK/kgfSglFanQbCIGDKhJfDE1ki4jRVwcYEK4v+V1HbDD3ceLH82VavQm1o
	S+/YZZA/nPawpUsP+73F4MfJIF/xRAmtHlWuRbXE+Ui6jpdEKQANpacPS1X0elDFdmmMTCSQtqk
	FSKZW0EkG36dHiMwgPNCunVDxwaniV0Ynl/KSoUcYen6AinN36/IfK7M12gS9da/qTNZFWJCQRq
	H4SHEg0NUlEJP9vAo65I0eCHQTeCaOOsrYhcjm/CZcs+gKT+oJ3YZj9F8Dbyq5bBjKsso2RmOoT
	80sAafIhR7+OCbB/iDVTV2UyCufdRRWUVY8cUrumrk86QRWUCMB0mdhnuIYSucFB8of5C3YwIN3
	lLEnqSk58XQN+DIzcNH1c69Wj/yrlz/LQeBC5PNWmpc+t6pIh7VFiqjjdllWuOcz+UrPBKYyY92
	1QzGSZy8nhI/BbW2Co5pcdIUsL
X-Received: by 2002:a05:6808:1786:b0:4ec:d521:9124 with SMTP id 5614622812f47-55c002e11f9mr2173304b6e.30.1792873355240;
        Sat, 24 Oct 2026 13:22:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0424775dsm1815063b6e.5.2026.10.24.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:22:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:22:23 -0600
Subject: [PATCH v3 1/4] serial: 8250_dw: select port setup through platform
 data
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
Message-Id: <20261024-submit-h616-uart-fifo-v1-v3-1-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Select feature discovery and DMA attachment through a platform-data setup
callback. The generic callback probes the optional registers and attaches
DMA when a FIFO size is available. Integrations with a fixed configuration
can supply their own setup before the port is registered.

Replace skip_autocfg with the Octeon setup selection. On 64-bit builds,
Octeon continues to skip optional-register probing while retaining its DMA
setup; on 32-bit builds it retains the generic setup. Keep generic setup
for devices without matched platform data as well.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 48 +++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..9c171c5775a6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -64,6 +64,7 @@ struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
 	unsigned int quirks;
+	void (*setup)(struct uart_port *p);
 };
 
 struct dw8250_data {
@@ -76,7 +77,6 @@ struct dw8250_data {
 	struct clk		*pclk;
 	struct reset_control	*rst;
 
-	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
 	unsigned int		in_idle:1;
 
@@ -595,7 +595,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_out = dw8250_serial_outq;
 		p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 		p->type = PORT_OCTEON;
-		data->skip_autocfg = true;
 	}
 #endif
 
@@ -630,6 +629,25 @@ static void dw8250_shutdown(struct uart_port *port)
 	d->no_int_count = 0;
 }
 
+static void dw8250_setup_dma(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	/* If we have a valid fifosize, try hooking up DMA */
+	if (p->fifosize) {
+		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
+		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
+		up->dma = &data->data.dma;
+	}
+}
+
+static void dw8250_setup(struct uart_port *p)
+{
+	dw8250_setup_port(p);
+	dw8250_setup_dma(p);
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -765,14 +783,11 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_setup_dma_filter(p, data);
 
-	if (!data->skip_autocfg)
-		dw8250_setup_port(p);
-
-	/* If we have a valid fifosize, try hooking up DMA */
-	if (p->fifosize) {
-		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
-		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
-		up->dma = &data->data.dma;
+	if (data->pdata) {
+		if (data->pdata->setup)
+			data->pdata->setup(p);
+	} else {
+		dw8250_setup(p);
 	}
 
 	data->data.uport = serial8250_register_8250_port(up);
@@ -852,16 +867,23 @@ static _DEFINE_DEV_PM_OPS(dw8250_pm_ops, dw8250_suspend, dw8250_resume,
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
+	.setup = dw8250_setup,
 };
 
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
+#ifdef CONFIG_64BIT
+	.setup = dw8250_setup_dma,
+#else
+	.setup = dw8250_setup,
+#endif
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_ARMADA_38X,
+	.setup = dw8250_setup,
 };
 
 static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
@@ -876,16 +898,19 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 		     DW_UART_CPR_DMA_EXTRA |
 		     DW_UART_CPR_FIFO_MODE_FROM_SIZE(16),
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
+	.setup = dw8250_setup,
 };
 
 static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+	.setup = dw8250_setup,
 };
 
 static const struct dw8250_platform_data dw8250_intc10ee = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_IER_KICK,
+	.setup = dw8250_setup,
 };
 
 static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
@@ -895,11 +920,13 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 		     DW_UART_CPR_DMA_EXTRA |
 		     DW_UART_CPR_FIFO_MODE_FROM_SIZE(32),
 	.quirks = DW_UART_QUIRK_CPR_VALUE,
+	.setup = dw8250_setup,
 };
 
 static const struct dw8250_platform_data dw8250_tda54 = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ,
+	.setup = dw8250_setup,
 };
 
 static const struct of_device_id dw8250_of_match[] = {
@@ -918,6 +945,7 @@ MODULE_DEVICE_TABLE(of, dw8250_of_match);
 static const struct dw8250_platform_data dw8250_apmc0d08 = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_APMC0D08,
+	.setup = dw8250_setup,
 };
 
 static const struct acpi_device_id dw8250_acpi_match[] = {

-- 
2.53.0

