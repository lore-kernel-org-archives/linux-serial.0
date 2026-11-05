Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911935;
	b=qGaW4MeUAyBt9FKJIvj0pwR0qp7Vr/SZMKVPc2j7irW+c/WHeciWFHSx5Z2rO3/sCr/H
	 7ps6AbfMDjXmcTxZJVIEuLuAAgb3UEHR+i+lssrLVNQYA0yzW1fc+7WBBFk2VUNOXa4Qn
	 CVNqYljaqeBDScVbOmMFEgzHUn4FjbUgBu31cOjRH6OysKC8FUDxIliGmfzXZLFX6DPvo
	 oEVjAZA2ZPHyep1nSbeC5euYOycec46YymRK9hZPfoLb/Rjpy5FoK+rgHS/S+s9ACk3fb
	 vcQQqBHnQt3Re8WtLmVYRNYid+CgwKaGKxnDoOLLtQnWRTagjbmLAUR4mJgn9vzirxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/lE1h7vRI/sW6l31u0lxhMtA1G4uNToUgbvAzqOb6yc=;
	b=Uk79FURbo69qc84XB6Juyvtd/j2BHyxgKvr51qvqu+9roJjXtmjj5LNg7aJY2yV2Sk9/
	 DBNRUqD2o/CB/gTfGKxvHBzEIi1zjvwtVdRTRoPijnjVsEQfFoaJEMG2nxslq8XL8wHbX
	 jh/z5ALn+Vplcm0ThtE5oJphbonP7YwMCLAZ0E7H7tzrAhMbN89UYjcOw0VYwcGYWJOQz
	 9sxVrhoNG8CpBsdOW2bxzsofkC/b7A8K4w06gQFi+gMt8uVLV912QghL+N8mvHPO4A0ly
	 ZHJ+vt8pB+W4jteYhBtpZigQiHABINOGHkhmOedKH6mNNbyH9Wn5IYpFSSCL4QvMfEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjJFfOjv;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654B606A339
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3654B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjJFfOjv
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8241a56cd70so1559254a34.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 12:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911934; x=1794516734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lE1h7vRI/sW6l31u0lxhMtA1G4uNToUgbvAzqOb6yc=;
        b=NjJFfOjvN6OJTs3+ELek/WM2NFYhKA8wuBUCcV/NcpcAQOMD4pbyCT7DIj9R4Q3750
         Dxj0lY4YQLN6U2n5CCcHaDOW6YgldlFsaf1LFiwPnMZ9nXDg0cuHo5C3JDrMnf9iqjPQ
         lZz2Tc0My7nu/aNOvv0uEdY9Fh4tDZKZkAq9ECYhgOgEjRj5SljbIqV+mp55uq6kZODy
         HC1N0WrLCfkOxw3lHfba1dIoVeMTE3pAc600+IA8rBpKChSuh/q/y4DLfM3BGIR2JYR4
         CjFb5yxnJB8hv/KoSXC9t1Ar9uFPt+xzLAwDKrXW3k3kysjLjbh4P0e4SlmtbRZd7LvK
         yTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911934; x=1794516734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lE1h7vRI/sW6l31u0lxhMtA1G4uNToUgbvAzqOb6yc=;
        b=UHxOyD2+K919+gML0QOTMoe2eI5UpV5PEyWKKD5AcWufc6LBE+IU6kq2CN6huKhCC4
         NE4C3G+VrRD51Ft0tTHq1db4LEShLtTPzzPsL/Z83FflJGX3vgHFpNc533IOrp9E3jTH
         3r7cbfY7JYuj/oM5Gfs0vYW02QEHncTxTlXOoXMqGsxRjaRnl5ERciJHrRPatVn0qCSg
         EvGHR0VTqdWrN0tK+FzuM/ToNeH+gNtCdDYdSsnOJIHBGfR/TxR5i7Bb3rcSEFJB7e5t
         9f1e17YHFFpuzlJCs7S86FFVH4GYY+XGri6VGlob6rrHrsChBOHwZeQ/r70CrHJwBKfs
         ojEA==
X-Forwarded-Encrypted: i=1; AKwUvBwoHnydqzOuDmfz3anLvXrGKqjVbxH38rtvQnRAXq3Qcwfjwkn/CGTeQAFOd8kGzP8NRyqF/Hx9CXe4SDQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fCKIkOa4zZUeDN6xB06F+F2sgJs5su9qMJW5yQnVZ27BZ8OS5
	AF8DaqmsVGNF3M5VA1jiLouDrgDsZEZTiFLujM04HB2TJP3X0zN+7OPp
X-Gm-Gg: AYBFou1z8lICmBh7/bZDGw4/okzu/H5UxP6LFX2WmFySLxlRoGjqTPPaBSWQdkP4ram
	8/x+EwBnmAL7kE7iL1iR2lEFMkhy3Qb2Ol6b8z6KWQdr5/SQXxnFFOe47D96eS2gxVmgBJdMRPJ
	6Xm4ZBYDqlVe+f2xlSrOUEwCNqr5Nx1a8lTROqPK9E9WsFmRdYELoTxr1G5dqCDWsgy6591pxMD
	/O+x+m6UtiPW5STeWuLjAlGn6RAUqB6tvhj+2G/TDuASGiDhyFJXcHQAht9ybxWBwj9AOCsytai
	q5ZATpyUFNY0iFhnDxSHim9+JtSCyXzPuqucjzx10LvKkaGV64BRxPElj9CbWW0hu71+gzWID7O
	SeM+UXw3//tD4TZMho5o00QIJ/kYLf+APWeYzjilr7/Xn+2ZwIf96WufW8yck63G990m0i3p882
	JeulxdHIiUSu6qxi3l5JwpZ8xHIN+K/KLo41FPFCaPdHHlsya/S99xS4Xlejh2VdY2LqX3QvfSc
	+fwUAt6e3UBIyzFkZYy4BZ9dALjR9iU/1csHzaMaValwV6cWuVe9h6v5U97U0HZDFAU4E83OUkn
	6kWdzt+LDaA+9/SVJSotGrCH7ZOpODLkPD7A98Vzny7s79sLw6GdUUf7hjZuRU9hr6s/ut+dTAr
	GLT759opoQwQ3AYwnvPyffFb9/gZiYNUOahw6osQaIpon1S7tYDsUSCHgqR7ON+1B1TMZHrIOjX
	wN0/G7Kr/3Oj/0pRjg9+sgPxF8Wiyirn+FMjL/BNVxpsHKjlAcVJnLgKmNXlyACcdTNvwXNQii
X-Received: by 2002:a05:6830:2e12:b0:843:cf07:7a99 with SMTP id 46e09a7af769-85f1d14ff4dmr511092a34.31.1793911934069;
        Thu, 05 Nov 2026 12:52:14 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb298fsm292276a34.6.2026.11.05.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:52:12 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 13:52:02 -0700
Subject: [PATCH v8 01/11] serial: 8250_dw: allow port setup to report
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
Message-Id: <20261105-submit-h616-uart-fifo-v1-v8-1-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
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
---
 drivers/tty/serial/8250/8250_dw.c    | 7 +++++--
 drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
 drivers/tty/serial/8250/8250_dwlib.h | 2 +-
 drivers/tty/serial/8250/8250_lpss.c  | 4 +++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9cbe076463e0..80b2b673b422 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -765,8 +765,11 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_setup_dma_filter(p, data);
 
-	if (!data->skip_autocfg)
-		dw8250_setup_port(p);
+	if (!data->skip_autocfg) {
+		err = dw8250_setup_port(p);
+		if (err)
+			return err;
+	}
 
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

