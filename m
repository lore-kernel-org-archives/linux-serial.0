Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAD3783BA
	for <linux-serial@vger.kernel.org>; Mon, 23 Feb 2026 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879239; cv=pass; b=aRJ11fRXG+JP+cwxbmntooJBOnFXKPUW+YhhIVPLhYhddmaCcZTpZWdGE8m1fSZIzpYsg3rbkTwJTOUaRwJ6KNtYIjQ4ZvoPWgUgsNdtpIyn8BYwvKi0u8/F3TR3yusAHT77DoTdcGWQIhP9w79ZT2s5QkrtgX+9Bgqlw6FfZwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879239; c=relaxed/simple;
	bh=tB/Bh69YT1o5AGl6zuMHY8RN4uTpr/OJyhpDSgAOaRU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Xceo+OSxK1AFLjHbyMnhsGQIWhfXLkVKg1MOEMUaNklI26xdof/l6YBHIRjRKaNd+rq52s6meJyY7jcpPbHtVSOvnYQ8BcQAShMozFSGZOXrKXnHfhBvg9jscThjtGTBDp6OPx7ksFC1CPv3bEYCrsJajQc5tpZ54z7FqpjGFRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=atzPsd1L; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="atzPsd1L"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so45246755e9.1
        for <linux-serial@vger.kernel.org>; Mon, 23 Feb 2026 12:40:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771879236; cv=none;
        d=google.com; s=arc-20240605;
        b=SSC98+2CmQgIHdrHG2YKsALCPeGwFGXk7b2D1pmqnpPVjTNK+jXKlcKkQFY2678zJi
         CtLAY0CFebFB7tB0S3AUC3+dhYg0FUR4eZVl2iHpoLDBuxcqucEm4yMKEGNohBg2R2V9
         J+uPi47WLYck0FYwLpfjRvo/1Q/+GW86git7tCvlKhbwnKpb1iJ/XsEsWdH1wRkoC0ST
         d2GuGL9Ktn3O90Wa8RbeW3HzeRN3Zp5W1jZqPbifwuNTQsgOdchfiSiq65QgdG8Y3laF
         Oxt0fILriMuiFAnCvyre6f+SUpmW3ryz2sdLs03ECaVjRWcmPLnC79hKJPLXwwr+sCZC
         IoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mbL37sOWut6us6TJEOfcO6gTAIz76WnjRpvpITqUljE=;
        fh=n/FzJjftoLefyaTFuKBWAHL1ztu4wPP1oUrCWH7nSys=;
        b=UAVBZUPMoq2d6Tc41lg+Rw7hQ2mfvmHBz2iQK0+Qj7E+gYMwNrfsPnxF6IXW/u1aGV
         qyLG1Jvq5EDxTAeX6gI3Y1rINR7K8lE2DSGAezdFOpZx1DI4nPYv/KFeck/EOxLotTZ/
         5fybJlvr2pvwEg59BoM4Y3QHbh9B1vsnOsjyshBpEjQQQz/dHuzNX9cAdZyHuAXo6P9f
         oMFjFb/E4/DBrKTOCXE/3N6C23FTITuhTVG9HdUD3BK5wiH1vwl71feFuAzziBJ9HI/Z
         ScmbMLfVo2/iVzOc0EBrqpvUDSR9/ObKedbw9e6FLCODmi9W35E4XwoamQ9cxG4Vj4F4
         rYmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1771879236; x=1772484036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbL37sOWut6us6TJEOfcO6gTAIz76WnjRpvpITqUljE=;
        b=atzPsd1Ls+EH4Cwosd4A2xW63INCSWaMPw1vnL4OwpF7h5KYCMXZdh0OH0j42WgU4X
         nxpYipF0qk3TpPJR5gyNB58UP6YVue56/X1eQtmN7l93clObvsZPP1Gn+v8SSQgOj2M8
         d3Dl4bQKGJgnV7mJ3y327PttH5qBTv5xtaBtY//zGRxib4GXc++khq1gyttXLPeGWVJq
         vHy4xslpsL5CY4RxWh7kuio4WUvlhl1/WbxfSECxxjO7KydIss7Fuj39gPKHEmXdbCaN
         vlUPGlSgNbOzZm8zoAOHpZCt4ViRz6weK0wwhhd5bq3qvJ/XysIsmT1Zr+7ugyD3IkjB
         6TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771879236; x=1772484036;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbL37sOWut6us6TJEOfcO6gTAIz76WnjRpvpITqUljE=;
        b=J3AeYCRaeirBi1xmOk0YFBxubS8WiRPBRwYZg+M8QQq+pbXdHDa5VfXSVdiNftiNyy
         fW1srNgULo12ZAUxoKLxSqCHZ7ac4BMLwu96mG+LQTnUnk/79RQVtlB0XeQq1UmFMEJh
         SSZKhZ9vDYhz9n1eqy37GQCSaPlJuBOHZkTKxK99nLnJnCQD8emh23dZmRFP9DV149gd
         Kznygw49tKC9oZyw/e4zt0N2lY/vLgB5Fzuz+P7llBAW8s4SyZRWAjvlvf+Zv+hZNyLv
         /9o9KS6IA5FkSmePfBUTQvTq288kA07IKWJ8W7mFL+r4Fr7mg0H49x7tCqrTjMN/iINT
         ENBA==
X-Gm-Message-State: AOJu0Yy1KTHqRWF5Hbsg3K5CAgBEgIIu/5Ik63fK+u+WGuwVtv0F3BR8
	4v7pWlnDilI+/27tYmeqkwxb981czMvXz9G7PJDE0oFCyCjBNePb3bLWLMD0p1FRZPTXp7bqW1d
	DxD/sx9j4A/Kyw/ed+RTneefpTq4lmw1h29Nqo97LEQ==
X-Gm-Gg: AZuq6aLXWre8jq3hD6rIDa7H39Bse4GpLIrNkYvWf+SeRblGh0xiPVIJbP9CEl4H7uS
	iYKHtaiEGeUa8lEu4Jkvn/sZB0JdcyxieFtlIlmxFknuUXIMlcO+AdwN1yiKSBsyXlme3A/N5ta
	gUvny0YKScuQ9c8yv6I9P9yRPnD8Yd2lUC+5wu7zB2WxAdI/CXhPjyPAm5o0hSZoIhNQIQtTjbl
	5ucnGjs83M6DELu0Lm1WRJcUxPyfYuYSq/ZYgKotwL+1bHn95Y7jvOuIu0IA2NmSxcr0JbpQIqY
	8Y5YwcyRGeuzrgtxrgJsXGdmh1dh2//5nnhGFYQ=
X-Received: by 2002:a05:600c:528a:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-483a95e9570mr157817555e9.17.1771879235557; Mon, 23 Feb 2026
 12:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ravindra Rama <ravindra@nexthop.ai>
Date: Mon, 23 Feb 2026 14:40:24 -0600
X-Gm-Features: AaiRm51ddYmXnVL3Gv-fyrm0xNTajUdCZY3MuT87_JoPXxKn2AHK7MTM8av77MU
Message-ID: <CA+mnHaW481bx8nJBNkkgS+oB+=Y=+qeX+hP0q6ObULt8=ewr-g@mail.gmail.com>
Subject: [PATCH] serial: 8250_fintek: Add support for F81214E
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The F81214E is a LPC/eSPI to 2 UART Super I/O chip.

Functionally, it is the same as the F81216E. The only difference
is that the F81216E has 4 UART ports, whereas the F81214E has 2
UART ports.

Signed-off-by: Ravi Rama <ravi.rama@nexthop.ai>
---
 drivers/tty/serial/8250/8250_fintek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c
b/drivers/tty/serial/8250/8250_fintek.c
index b4461a89b8d0..976c5748905c 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Probe for F81216A LPC to 4 UART
+ *  Probe for F81216A LPC to 4 UART and F81214E LPC/eSPI to 2 UART
  *
  *  Copyright (C) 2014-2016 Ricardo Ribalda, Qtechnology A/S
  */
@@ -23,6 +23,7 @@
 #define CHIP_ID_F81216AD 0x1602
 #define CHIP_ID_F81216E 0x1617
 #define CHIP_ID_F81216H 0x0501
+#define CHIP_ID_F81214E 0x1417
 #define CHIP_ID_F81216 0x0802
 #define VENDOR_ID1 0x23
 #define VENDOR_ID1_VAL 0x19
@@ -161,6 +162,7 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
  case CHIP_ID_F81216AD:
  case CHIP_ID_F81216E:
  case CHIP_ID_F81216H:
+ case CHIP_ID_F81214E:
  case CHIP_ID_F81216:
  break;
  default:
@@ -185,6 +187,7 @@ static int fintek_8250_get_ldn_range(struct
fintek_8250 *pdata, int *min,
  case CHIP_ID_F81216AD:
  case CHIP_ID_F81216E:
  case CHIP_ID_F81216H:
+ case CHIP_ID_F81214E:
  case CHIP_ID_F81216:
  *min = F81216_LDN_LOW;
  *max = F81216_LDN_HIGH;
@@ -255,6 +258,7 @@ static void fintek_8250_set_irq_mode(struct
fintek_8250 *pdata, bool is_level)
  case CHIP_ID_F81216AD:
  case CHIP_ID_F81216E:
  case CHIP_ID_F81216H:
+ case CHIP_ID_F81214E:
  case CHIP_ID_F81216:
  sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE,
     IRQ_SHARE);
@@ -269,6 +273,7 @@ static void fintek_8250_set_max_fifo(struct
fintek_8250 *pdata)
  switch (pdata->pid) {
  case CHIP_ID_F81216E: /* 128Bytes FIFO */
  case CHIP_ID_F81216H:
+ case CHIP_ID_F81214E:
  case CHIP_ID_F81966:
  case CHIP_ID_F81866:
  sio_write_mask_reg(pdata, FIFO_CTRL,
@@ -304,6 +309,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
  switch (pdata->pid) {
  case CHIP_ID_F81216E:
  case CHIP_ID_F81216H:
+ case CHIP_ID_F81214E:
  reg = RS485;
  break;
  case CHIP_ID_F81966:
@@ -354,6 +360,7 @@ static void fintek_8250_set_termios_handler(struct
uart_8250_port *uart)
  switch (pdata->pid) {
  case CHIP_ID_F81216E:
  case CHIP_ID_F81216H:
+ case CHIP_ID_F81214E:
  case CHIP_ID_F81966:
  case CHIP_ID_F81866:
  uart->port.set_termios = fintek_8250_set_termios;
@@ -446,6 +453,7 @@ static void fintek_8250_set_rs485_handler(struct
uart_8250_port *uart)
  break;

  case CHIP_ID_F81216E: /* F81216E does not support RS485 delays */
+ case CHIP_ID_F81214E: /* F81214E does not support RS485 delays */
  uart->port.rs485_config = fintek_8250_rs485_config;
  uart->port.rs485_supported = fintek_8250_rs485_supported;
  break;
-- 
2.50.1
