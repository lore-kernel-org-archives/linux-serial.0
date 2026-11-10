Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280395;
	b=AMY0Y93qJj4p7EoPTqqQ+hOffZ52dx1Db3lRF4mXtCRfPp528IVWF0iSMJm0bREiuyp/
	 z8auH5q+W8z2KoJNHW0rXLMDYOLKJOljGyv4UB6wAji+60OQpByRnT7jevac1Vg77bieX
	 1L4R74sMC6ZDf7c+mtZi8Q744xtEKKK8xLVC0jCATsufv7yFzJJ4WUoJ5awvz7FMi1Z1R
	 rYUsRtkhxl9esSJf5UrgfG+lpPJFNZNUUJNlz/m8On/+FeqHnTsTht4RtAUphlWd1dDtR
	 yg1sSIrtW5LhBimkmjJl+75uJ/0IjGkKUf/dPzl6Uf0K/QW08bUlr3a+39nZ907Aqmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=KsGmsSOFoUFqhki7bSOzws9koK/vjaFo7VoIU6A5xpA=;
	b=J7jENGauFpKAovk9GasQKWaoWuZE/Fa3cRmWrRDN+mwk92t+Qqp72eGYmKruc2yY/LW6
	 5H62vzCTaXcCzQc9QZEYTccc1QJv7eQYzErPJ0UZGFLO+8y6Oc5nI0aJJg1GpuWLPhB6B
	 pdKsESkYav0WZq3iDr2Z9PyhYOkfFEiryc+SHXudL3WQj7NPXXlOpcu+GpWPS4p99OsAj
	 hWREK3kjOYJn15lku51omgsPBiywx5NLooM6/+c4bruUUrfckc6SP2/B4usLqLxj8fp8C
	 xWJf0lMNIC2625aZGxqbx9Dv+SurT0INS1XHtL7Et9WM4xrsZ5+9KaZ1FiyeCl1Iulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKcvETLe;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61F606A33E
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD61F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKcvETLe
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53dbe9b8d6eso1283534b6e.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280393; x=1794885193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsGmsSOFoUFqhki7bSOzws9koK/vjaFo7VoIU6A5xpA=;
        b=TKcvETLeC6xPYlP4w6XWNuQkLC3mMyxIu21UmG3PlogpK0vckIq+hJO0JL3E1rsxQj
         Qtpflds+Wz6GD2FKnKMbNTITSPDQrxHnQOqUZrIi7Ohzv923YlM3sDm9fgj4hdOEodST
         glafdD3NEtBZAOgTv1m+d56tF9TvdgPB1w99fMUGkMAJcjU7YIDpx0AT2Grk8HycnfYT
         K5PQTgq3SBY6KQfUAPNZfIammSuBJZlOfCOQWFL3f1e2aFL3yU4UYxQAWyyT29dhisVh
         On2RDgnWyRx93m1S2LT2CeKGsydFcuiGzjY8Z4eceCijd/ppDPUuLAW1+I1Qm/KzKFdr
         yBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280393; x=1794885193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsGmsSOFoUFqhki7bSOzws9koK/vjaFo7VoIU6A5xpA=;
        b=X3kHcMsEdmNpzz5rpFk1IF6nkhUJWE/2HiyBkihbgsSN1K+UZfo8iiqdwnRgt7lDf2
         9KzEhRnCINlq9id6xg1sOAgpIfvVozGcu2sNJ4KMGRuBihyygL6kpPh4KXZu3tP3zUOu
         UqG9yWVBU7KEpHgRWyMzyw1O4S0KSZwePRgPYPMwCLipzs97RGxRvJfYtxqadp4pxgiU
         c5L/+ibaJFtYKR9nFwIjnVZlaMuBDtbsvTqQMvd1MZeoNQWOtLBvVgU4k0RzhY3CK3Vd
         ba5asDPhPGqUudo59ke0IaI5TjzkRcAz9FQSZg9qflDz9EEOGwklGA1dXtvSc/+e9Arz
         dyQw==
X-Forwarded-Encrypted: i=1; AL+hErFPIiCCGYgxKcpTxK/vopxPQmqQP1cSlzXyXV0hU+WeXaaogtto+vs7xX9OnmZQdNdIxjrpmy+Y3YCyP/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AGiDaPR/e5k1HEjnIszRDB+ThvlH2UxvQU+qTAdXtpp8UR/Kv
	fPuwJsRh7hQ07ad3vncljEG97V9yQi39yiYtrhAdGLUb+Prg3GI9ioAB
X-Gm-Gg: AYBFou2ytzafgXfKY7NHswdLgBI6RMfxp27NOxNN/hSfxHxbTZdMicoYjFSpg98vOPO
	cN5XxfdFC48hJReNFk8e0Crj/65RYYrAMVvkOO26UiyA9Vm0W33fwv6LNb9Z91irYZ1EKoh5+oQ
	hUWHUMzBiZtDaiIvxpzqs4wfPqyBKMoF9NXqHvBAgRlOxcCpSdViArOBYvv8Y3v3gxdPU06IlHo
	kaRhQCety7ZrHakBxm7s1sK8FOP9E5Ms6/gLadqUgllWEqpJH9vR4YEvrMJgvcx+Aoy4RcAT13I
	SUQeEh0454hT7+z/FSvYq1WItGlssfdmCGFfsfSJrAgy2hCJpGZOOH+Rx2eYyhSAEoLdjwORVWo
	aI5zqtnUMIajsPO9s8+HXQ83ZcOHMqkbhhi5mX137typtbaERri3gH/QxlcCZUy3yIVDvkWlVVP
	MhbYJ6kL9p8JFQvoBEshJtaKapgCTepBdGPxgqNsJXlmcRtPx9+/Ibk/U7Glt+xvqE7TzpHUbYm
	ZeeuXh32PruOW/DDYcyHDfEEJkuvPc1z0Q3tTMaSAQ0F4VAFqsHXtjteDXa4RuZzUhdj2HvQma1
	yZYJ8hPbiNqvreHHfENMJKITDFlCoBH9/YXp3VFFHcyDAB2C+VHZotV6+7w4vq9SdsxxgDHWx8Y
	36Iy7EkyAl9ljf8Oa3R6QrVIZXfMVas7Dcvi6kaXvdvipf9hYktLosj6pnMRbwgOsjzMVI2UOHQ
	h5742+tyRlGKvjgeHOdqsoUT4tYuVoxNQ7/R+DDLro3f0wVlJ4YfCq
X-Received: by 2002:a05:6808:11c8:b0:568:195a:3bb0 with SMTP id 5614622812f47-568812d0fa4mr697292b6e.23.1794280392814;
        Mon, 09 Nov 2026 19:13:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:12 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:50 -0700
Subject: [PATCH v9 01/11] serial: 8250_dw: allow port setup to report
 errors
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-1-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
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

Return a status from dw8250_setup_port() and propagate failures through
the DW and LPSS probe paths before registering the UART. Use the existing
LPSS cleanup path to release board resources and IRQ vectors on failure.

Keep the current setup behavior by returning zero on both successful
paths. This separates error propagation from the configuration validation
that will use it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 4 +++-
 drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
 drivers/tty/serial/8250/8250_dwlib.h | 2 +-
 drivers/tty/serial/8250/8250_lpss.c  | 4 +++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9cbe076463e0..8fffb1f9ab0d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -766,7 +766,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	dw8250_setup_dma_filter(p, data);
 
 	if (!data->skip_autocfg)
-		dw8250_setup_port(p);
+		err = dw8250_setup_port(p);
+	if (err)
+		return err;
 
 	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
 	p->set_divisor = dw8250_set_divisor;
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 91b3607b64e6..4a06dec6e263 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -208,7 +208,7 @@ static const struct serial_rs485 dw8250_rs485_supported = {
 		 SER_RS485_ADDR_DEST,
 };
 
-void dw8250_setup_port(struct uart_port *p)
+int dw8250_setup_port(struct uart_port *p)
 {
 	struct dw8250_port_data *pd = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
@@ -250,7 +250,7 @@ void dw8250_setup_port(struct uart_port *p)
 		dev_dbg(p->dev, "CPR is not available, using 0x%08x instead\n", reg);
 	}
 	if (!reg)
-		return;
+		return 0;
 
 	/* Select the type based on FIFO */
 	if (reg & DW_UART_CPR_FIFO_MODE) {
@@ -270,5 +270,7 @@ void dw8250_setup_port(struct uart_port *p)
 		pd->srbr = DW_UART_SRBR_0;
 	else
 		pd->srbr = UART_RX;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw8250_setup_port);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 7191cabfb086..4d32651956ab 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -100,7 +100,7 @@ struct dw8250_port_data {
 unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud, unsigned int *frac);
 void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac);
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
-void dw8250_setup_port(struct uart_port *p);
+int dw8250_setup_port(struct uart_port *p);
 
 static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
 {
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index f1b4b975571a..7ace0515038e 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -350,7 +350,9 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	dw8250_setup_port(&uart.port);
+	ret = dw8250_setup_port(&uart.port);
+	if (ret)
+		goto err_exit;
 
 	ret = lpss8250_dma_setup(lpss, &uart);
 	if (ret)

-- 
2.53.0

