Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6C13D600;
	Sun, 10 Nov 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731237444; cv=none; b=d3h/pSJ9XvM8Rr7vB1qKa9XGF2RdRCDAiNYGPjACB1jLmHnBzFrcFcKyVvplcdMUgQrOAv+ebKQctYtBtc+AmmRSoy5pvPQmdN2CxK545iBZpYdZAsTntA8GenWYoVM7EF6I7tgnXGAlk9jC8BUv7W5/379W30Rr0GXks8NV9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731237444; c=relaxed/simple;
	bh=yoWjm0XRqOLVjsy3PFi7Za+Mcz55k2ULoVmbPjSpmj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIjIjmmBEuZt5XSIDajreSVlJdt/kGlYM7jPE36+NUoqiPPUPrjST89cUhNNbzROPxagATRjqNY0tN2u/kiJoFeFZ1u3iqqXcsSUgSqAZmAnqAHFzPm7NAfZly9/72xxH+5WnB+oVhLxCxxB14Se61wuCjko+L3KBev7H+LxqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F90ElSPr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F90ElSPr"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so4623112a12.0;
        Sun, 10 Nov 2024 03:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731237441; x=1731842241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/dyL3oREILD25QRwM7Myswpp642In7rJWpzkAIDiwU=;
        b=F90ElSPryixonCzAMEPzTrnqnLDScbz+uxegz75H/xJdtF1iKxE0p7J00HlKRuJ92w
         lOaFmZwMtSsXDbJG+cjoeyGRWaKu9SyQ2meimgXHODgofIfd/e3fzvL1wwqySpgIU1oR
         Ehbu0sl116N/Pw/WrKoivEd3qSA2zchDJTvVCG8jfJuZDs6/Z2L3uOdzC3opm1Rc3N8P
         lvSYQ766wmezOrL16qeMuqk2Pmjz9EWNLRFqv4JxmifFfUYxQTOA4YZ1ratJT1IQmq+P
         N0aW2FIIOqSwORzeiz3CT5aqsT0AJSM+GvlWMsEo4w6qMMEbfdjBxYVVA+CnAidFdf/w
         W5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731237441; x=1731842241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/dyL3oREILD25QRwM7Myswpp642In7rJWpzkAIDiwU=;
        b=fZBglI+yDM7Qp+RbGNA4tyO5z0qIHUO2XKbAOMXbJEt50jCN8ld1shZXkPGu/CSjqE
         m2e7BihGJPjFuaQ8RnPCKVqFnjSV5JIUCXszxT8jQWKMbLimy0+nBhTSduaYC/wXckwc
         4I6e3mdNaBxPx8Y9/S15BBOv1X5QCLHSyuQ7mKE5LxTqcj0saulua/4E6SP3NiIiXpaA
         CsDUiTvqMt9WGWcRfm+nB9thel3UENRsGxc6FHbtXWki13+YuY5AFJao2ZlE4TxaMC93
         FIIPO8LHJWlR1a+vFc/ffXu1q74k/pgtU8G64NNkYNvDGWehmdvBWo40d0OUJB2nYKeB
         MmOA==
X-Forwarded-Encrypted: i=1; AJvYcCWJAoHrUR71QIMhv/C7GsHktT/IZvPgWl7Xa7ke4dxpJR1QKE+IwtwfzdLRZg0+opM0iVfeUgMSVxGzLtf+@vger.kernel.org, AJvYcCXGB2fjYvxM5Sv15VxpvfblBgER8xc2dHxQ2rXTPyWJ2PkgElCFPN1bACH886UFe5MsZ5Dot7l2T0v/KZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcULNNcouCG/NltTcsJ0mPxRIpqCmESop/TQyg3mhi0F6kbUS
	Lt4aymsgaz6xrlnQ9BIiGEZayHIreeiZPxhdnePSjvSocT4JDRk8o23LUHOcUkY=
X-Google-Smtp-Source: AGHT+IHu8ryjX2DwIw+wBIhJQQIq+kJ6x/P8Lq1zDEp1or0+F4+QNtf6WZHRBOQxYI+TJZMowwTq+g==
X-Received: by 2002:a17:907:9690:b0:a9e:670e:38bc with SMTP id a640c23a62f3a-a9eefebd05bmr849340166b.3.1731237440946;
        Sun, 10 Nov 2024 03:17:20 -0800 (PST)
Received: from DESKTOP-T8HPDSG.int.xargs.net (77-56-160-4.dclient.hispeed.ch. [77.56.160.4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9efd2fe9fdsm232078066b.132.2024.11.10.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 03:17:20 -0800 (PST)
From: Filip Brozovic <fbrozovic@gmail.com>
To: 
Cc: Filip Brozovic <fbrozovic@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_fintek: Add support for F81216E
Date: Sun, 10 Nov 2024 12:17:00 +0100
Message-Id: <20241110111703.15494-1-fbrozovic@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The F81216E is a LPC/eSPI to 4 UART Super I/O and is mostly compatible with
the F81216H, but does not support RS-485 auto-direction delays on any port.

Signed-off-by: Filip Brozovic <fbrozovic@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index e2aa2a1a02dd..ecbce226b874 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -21,6 +21,7 @@
 #define CHIP_ID_F81866 0x1010
 #define CHIP_ID_F81966 0x0215
 #define CHIP_ID_F81216AD 0x1602
+#define CHIP_ID_F81216E 0x1617
 #define CHIP_ID_F81216H 0x0501
 #define CHIP_ID_F81216 0x0802
 #define VENDOR_ID1 0x23
@@ -158,6 +159,7 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	case CHIP_ID_F81866:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		break;
@@ -181,6 +183,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 		return 0;
 
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		*min = F81216_LDN_LOW;
@@ -250,6 +253,7 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 		break;
 
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE,
@@ -263,7 +267,8 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 {
 	switch (pdata->pid) {
-	case CHIP_ID_F81216H: /* 128Bytes FIFO */
+	case CHIP_ID_F81216E: /* 128Bytes FIFO */
+	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		sio_write_mask_reg(pdata, FIFO_CTRL,
@@ -297,6 +302,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
 		goto exit;
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 		reg = RS485;
 		break;
@@ -346,6 +352,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
 	struct fintek_8250 *pdata = uart->port.private_data;
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
@@ -438,6 +445,11 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 			uart->port.rs485_supported = fintek_8250_rs485_supported;
 		break;
 
+	case CHIP_ID_F81216E: /* F81216E does not support RS485 delays */
+		uart->port.rs485_config = fintek_8250_rs485_config;
+		uart->port.rs485_supported = fintek_8250_rs485_supported;
+		break;
+
 	default: /* No RS485 Auto direction functional */
 		break;
 	}
-- 
2.40.1

