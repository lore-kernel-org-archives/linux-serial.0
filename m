Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF61DE3AD
	for <linux-serial@vger.kernel.org>; Tue, 13 May 2025 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104162; cv=none; b=N6eOKzB4/c7GKLmN29MBpsE1V5MsFcXkrfrs9GchpkSE45xKQEUHid9mZ8NPsZ7WsIpiKnbbrSxOxWxBqkl5DdpxDPDpY3XIH0jr1Awdh5r/QZwbtlZONM85L1JNxmx6GhM9NKMLONkeDtkCpwlyotjv50t7zdDTWUKEpUBmWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104162; c=relaxed/simple;
	bh=U3HUF7yFnNEiDperbXxcBPVDrFqRpUKho+wRS7C8/VQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjYq21nwFkTUPtk1oucCdM7GyyamaoEJoGsGf1owRwE2lcAcQEoaMpsAjVQcZm8OjF9U9/+mALzAH2yizF7g5fXjJc27u7OUOuipfdYsTSGI3AV3y/c1GHHg2gCXp0XLBCmm8a5UOhRRXiyrmJL4pxm/xfa26WcVHsX2hGKHUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iHi/u6Ih; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iHi/u6Ih"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22fb33898bbso63265805ad.3
        for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 19:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747104159; x=1747708959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJ//Qz5vc0HabF9giMyr/yKvvCyXTBy5K+QmIID+4no=;
        b=iHi/u6IhduYFn5qxfS0SH6PbHG7UFyUbfoDVOVvvSSFAyGL+viVtCzXrqwhv9u37BZ
         +9054oHTF4H/GKokFNyTueRt1iNRJOxAkLEfJyD/MdJ61c1IqTnhBtsGPN7cSwopwSxi
         zsY0FSGdarPvPVMFKNbigt9eUKlgnGFlCsIxi7jzFfSrCSvPAiLANToEPy2SM8tBgue5
         ZFBS5mJHYHZS4KsBa/9/fDyXJbu6TO0sXpK2BsVd9C0H6VYQt/nmag4ScbHwRyqZshzx
         hIEqxsFCTmidjPi+Z9vDxJ6iEj8ihsmTxodR2ecJdoBP5ZzxkTw6MiQMhIR040fRoAYH
         dkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104159; x=1747708959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJ//Qz5vc0HabF9giMyr/yKvvCyXTBy5K+QmIID+4no=;
        b=e1/NniNzOHj9hArYwDM2wOnnunjbpZ0QLl1iCF7lINI7aK8J5BdjKhPbn/m5WwqCjq
         ZjmJYEOUemlZVDOo47Bd/puwnibX5R6ibfy8E4z4tVuQgADNtheJ6wQ9Fdc8rX0fdbRo
         qfV/Y5nsjwCCzA1PkXDZvOdofgBzfoxsR+H0RpWsJfKFELS02+435yWA3+PS9Rq7fksP
         pdsnD2ArGVUt2GeIIwlxXtSUn7wnoYFlWD6UI85GIOK8HxfKqj8hkqLqJH3PYWLIHzAQ
         3X0tJGtueL0rKNnH+4yKyjASQr8fEgbG2csXXNc/N2mzsPzmN5D7r7YvJrhhxS0BA4x0
         2CEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfT/o4wNm5KGGUmSHSeMOnrWoS+Q9fOMxvfZKuFcuKglVUAPbXA6r4FCB6450Kg9psYyNBDLuV5J1Oxfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwaTpiVOulJltlk1fwsYP9Y6P+fwOvgl9xZYJj5K6shw8MXQ6X
	j1vCx358xhAskNjO8gfL+KKD+KU9ixvU7KUCjSqV3gB92I/HBWa1ZehSSsDmrmw=
X-Gm-Gg: ASbGncvWMRYEkt9gVWBXf7mXxLlKMnvGpoRj96u2+r7O7vHLVGyoVg5Xkfwa333JdLM
	Y0ZfQ46FDmTFMk/RBkEuko4geGdkRFgfvRQDOtSgVTZ0PBGbgtFjAuny8eRlzAkk5qO1CJPECoa
	fyLqHDL9i4SJWCf087PBT0HL1ZEhjQrUqX4LFFsqzxU/AVjNlhG48U55NmLrvzjaRuVh59DIoks
	qVTbxCtgpTWfMB+CauaA0Sg/2XEYHkkiHthoiMQ54Tb9APdB+FvNQWJHGD6Hvpw8qzCJ2Skqxh8
	+yyiBzxprYN02NXhoTu9KLwbHYDEL8cQIaTJHm9vpCaGCO7fgGJbeeeTWTKJEdeGR6sd7foHrvk
	DasgPX8WMA92gJunO
X-Google-Smtp-Source: AGHT+IG/OqJAMfYi56gF4WSoCCQ1o4lALcvgXARWEyOtGciAj0s3Q0lOLU3fyIUwo37gtqcrz942qQ==
X-Received: by 2002:a17:902:d507:b0:224:de2:7fd6 with SMTP id d9443c01a7336-22fc8b79585mr223387855ad.25.1747104159314;
        Mon, 12 May 2025 19:42:39 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829f532sm70592595ad.228.2025.05.12.19.42.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 May 2025 19:42:38 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Subject: [PATCH v6 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Date: Tue, 13 May 2025 10:42:12 +0800
Message-Id: <20250513024212.74658-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250513024212.74658-1-cuiyunhui@bytedance.com>
References: <20250513024212.74658-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DW UART may trigger the RX_TIMEOUT interrupt without data
present and remain stuck in this state indefinitely. The
dw8250_handle_irq() function detects this condition by checking
if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
detected, it performs a "dummy read" to recover the DW UART from
this state.

When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
while the FIFO is enabled and UART_LSR_DR is not set will generate a
PSLVERR error, which may lead to a system panic. There are two methods
to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
UART_RX when the FIFO is enabled, and the other is to read UART_RX when
the FIFO is disabled.

Given these two scenarios, the FIFO must be disabled before the
"dummy read" operation and re-enabled afterward to maintain normal
UART functionality.

Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 8b0018fadccea..686f9117a3339 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -301,9 +301,17 @@ static int dw8250_handle_irq(struct uart_port *p)
 		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
-		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
+			/* To avoid PSLVERR, disable the FIFO first. */
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, 0);
+
 			serial_port_in(p, UART_RX);
 
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, up->fcr);
+		}
+
 		uart_port_unlock_irqrestore(p, flags);
 	}
 
-- 
2.39.2

