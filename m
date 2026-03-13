Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3A34B183
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431300; cv=none; b=UIWUtxEvYtIUNMn/YFyA4RQp6gdN6lOmC+xeIiErcUBlK49Aig0D+ixKzrd2K5rmkTCU9nPz+rAkJO90YEVxpm51rNiApU0cwD2ICiBaQ3Fci301PanULzLgItTvz+bsERUoTzPg1mP1Wo1aqOHTaoCxw/p8INFyPBT1Kcc9QAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431300; c=relaxed/simple;
	bh=59/FT/ZRiirhnPJyeScbEpjQE+bQSYnEDUDWDN0QaGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0ibcVUo/tdeNR59Fz96LrhdmnIzhzSpfXCItHWPU3FVnpPATEQFXrubi4Psr6ThtOg1dUf+1AswU9eufcFwb087BSD+tEq7KkVdDaLNCJBQckf+UQQL79LnrYdZrkOOSEx/S6QQYrPD7NC69tB2gI2DOlZwiOqk+uitCI4YPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=W25RtGVQ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="W25RtGVQ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79853c0f5b9so22506987b3.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1773431298; x=1774036098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI/lBNvmQEarIeV0+efxvYzBpNM+n0lrFVQtTAAmvzw=;
        b=W25RtGVQg7caYdLtS2P/F+sULe+inwz8LJKf9BfuLN4s9OFsJR9ElWc8jivxVC/Xb5
         H2NVceIV5SBrdJb20h4UpRPNiBRdOS8bYZ8XCgmXUpqrJnU1w5BN0C15zC4USb+Om7Qj
         Wpxbe+37se54eYEaYCRKS5jCuTQ1aVlKnXaHjwpADSIr8SPH+XQNx88gmv1NGU33Yxzx
         KhGO4WeV8TwaQJt7XlHMqXcTIizOdCv1Eit0mNG/JaM84i/mWdtaw8uxwGVg13vGEvm2
         PydYiqu8a61cHQQ4D6MofKV/m9uFsg+4B7uK9dyaG2rgSBoDlDVZ2xFnoi1JaCx19szD
         +JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773431298; x=1774036098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DI/lBNvmQEarIeV0+efxvYzBpNM+n0lrFVQtTAAmvzw=;
        b=NUV5CRDHS6WWHwWzgmTE4TNSiFqiJ5jbmz0h7z2NHxksMW2G1kdMoaumThDBkHeVU8
         TYjX2jePA2quYR4Ytnalnu9x3Zp1CE9H0Z3m9KLf6GBlDdipDT+/dUI3sSQU5FNxQXSr
         kb5U/Ji4VYWa9nJa+WrUalRg9o/fOiaTcXkkCTRdD1Q27Utj4Q/SYRV/9UNGBEKNAzbJ
         IyeqykK1UxdWmrCrJo2HhwOy9ZS7MSjgP6uPrK+Eo+LUQaUy9EdxOKE2kQRDMuG7ndLo
         cYpCyT0nKTh/MQR0i7zIRcOQGiNrAHLN6Lj8HPP2uvyvhOXlMC8ejN1MLHqxtzoGSErz
         FhTA==
X-Gm-Message-State: AOJu0Yy2XUgnFq7Qd3JSI+PYvXfUaYWLZs8MpJlRg+2vRVivn1DEJiYv
	E1x915xBqVDnFeZnvX2hR3ptxnGQq/Z7N2JJRyoDpDG36ir1Aw9Qvm+H/H2OlMrtjl+1b1Ez6fd
	kJGNwn4Y=
X-Gm-Gg: ATEYQzw6YeCDWp9l/9ryiX/GzBkanNwQj06B86d6mVnq03QImEeuP+ij39yWArDv1Bs
	mLHZFuipMaYrLv+o2uJcg2D7cbHgzAJOiFpN7/TlwO7QGpQhPboYnEDFF3RrIK7+jo2qlVapKO4
	+odDWBoooC67tI9jpuweWzbr6hgUvD/uvbHZWbUVZ/wCK3yw0dTVsM3r/N46bQxq6qCH7B/OtLF
	UF3IRHfrtLNafq++d6clhU3BDtN1BZ1xjNwuqgG76Osg9RbzMqYFfDl9DoT6LkAZvFyznz25NWg
	+7DWw6l83I6eWqHTzZVhWjARx9URo4EIHuBbG3JSK50DrG9c/7QViqFPmUbYZP8A1UqG6zuo5g+
	Ow2oTjctihXuTDZQqauTLgSwBFOF8Q7s3VF++0DpJ2jIHgJVyDymCIovKpDkEHi2m9q6Z/R3xBT
	9zXI1gBHygMu4o9W40G1l6TXaF5GjSOrmXQ5Q+wmIS7Kq8C/7AmAsy
X-Received: by 2002:a05:690c:d95:b0:798:578c:2ad7 with SMTP id 00721157ae682-79a1c1a7098mr53967817b3.39.1773431297798;
        Fri, 13 Mar 2026 12:48:17 -0700 (PDT)
Received: from Mac.attlocal.net ([2600:1700:90:60b0:91dc:5e47:6b38:ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a1f86f73esm14031017b3.29.2026.03.13.12.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Mar 2026 12:48:17 -0700 (PDT)
From: Ravi Rama <ravindra@nexthop.ai>
X-Google-Original-From: Ravi Rama <ravi.rama@nexthop.ai>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	Ravi Rama <ravi.rama@nexthop.ai>
Subject: [PATCH] serial: 8250_fintek: Add support for F81214E
Date: Fri, 13 Mar 2026 14:47:27 -0500
Message-ID: <20260313194731.2671-1-ravi.rama@nexthop.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CA+mnHaW481bx8nJBNkkgS+oB+=Y=+qeX+hP0q6ObULt8=ewr-g@mail.gmail.com>
References: <CA+mnHaW481bx8nJBNkkgS+oB+=Y=+qeX+hP0q6ObULt8=ewr-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The F81214E is a LPC/eSPI to 2 UART Super I/O chip.

Functionally, it is the same as the F81216E. The only difference
is that the F81216E has 4 UART ports, whereas the F81214E has 2
UART ports.

Signed-off-by: Ravi Rama <ravi.rama@nexthop.ai>
---
 drivers/tty/serial/8250/8250_fintek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
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
+	case CHIP_ID_F81214E:
 	case CHIP_ID_F81216:
 		break;
 	default:
@@ -185,6 +187,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
+	case CHIP_ID_F81214E:
 	case CHIP_ID_F81216:
 		*min = F81216_LDN_LOW;
 		*max = F81216_LDN_HIGH;
@@ -255,6 +258,7 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
+	case CHIP_ID_F81214E:
 	case CHIP_ID_F81216:
 		sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE,
 				   IRQ_SHARE);
@@ -269,6 +273,7 @@ static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 	switch (pdata->pid) {
 	case CHIP_ID_F81216E: /* 128Bytes FIFO */
 	case CHIP_ID_F81216H:
+	case CHIP_ID_F81214E:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		sio_write_mask_reg(pdata, FIFO_CTRL,
@@ -304,6 +309,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
 	switch (pdata->pid) {
 	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
+	case CHIP_ID_F81214E:
 		reg = RS485;
 		break;
 	case CHIP_ID_F81966:
@@ -354,6 +360,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
 	switch (pdata->pid) {
 	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
+	case CHIP_ID_F81214E:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		uart->port.set_termios = fintek_8250_set_termios;
@@ -446,6 +453,7 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 		break;
 
 	case CHIP_ID_F81216E: /* F81216E does not support RS485 delays */
+	case CHIP_ID_F81214E: /* F81214E does not support RS485 delays */
 		uart->port.rs485_config = fintek_8250_rs485_config;
 		uart->port.rs485_supported = fintek_8250_rs485_supported;
 		break;
-- 
2.50.1 (Apple Git-155)

