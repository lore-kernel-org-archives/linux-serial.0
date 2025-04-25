Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B956228C99
	for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562277; cv=none; b=KB7989NAjUP6gq0HB8SlGUwju+oMj3Y5C4WPWKTnFSATDLGQRRHzfcIX8zzCPddkjdKkdliTpxryZ8mmO6poU6VfOqv6nw+csCDIKcymw0gZgnCMRrHYdu6UGfRPC5MixvQnBDI8ysURBEwDNemA1jKKJc1r2mh3KQRY16GK5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562277; c=relaxed/simple;
	bh=xjL65vzHaYnd2+Zu9zg+UVvkfoWrRNrqH2KTKvwr7nk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hQB4haJWHtEIJDVHdd3dqQQ08SSJh9rMggc3XJSKS9fRZsHdMhU7EB/vhH7LpXRqee6cqiVcGptcg05Sm+xv4VQUX2Gyo6634ZGbpLcOtKTAv49Akwr95qoJIjOSZTSeM1R5cLSi4AgvwTteDDKSwoQMYjjLjZz3AmiAbqLT/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kxf32QzS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kxf32QzS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736bfa487c3so1491724b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745562274; x=1746167074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lj+Ua/fxMyjIfoIv2F4j22EXalsnM7wsPJwCRLC9/bk=;
        b=Kxf32QzSezhfjzPDArP+h4V4ys7zLaj580A9T3qP9NuIXWmPahwEpnG2bkQy3slJsg
         yAzhv3zP80mZLhIFnuf8hyqqG7xkGv56OIU9m/gGdrEO/+juG2F8jV361jvHjWWXCMmI
         AP/CUhI+i0Z3Q6NF3m2HtEDkgXNFfrHZXh5dDHJTCeOyA1cu63wIdojws+ORZqzpZAIa
         SsvFFugmFtr/Sfc0oiI9qd4v5lPgmRHsWGoWFmSfOBCWmWB5ZG6bBofTyW7vZQrDPNk5
         LdLsr0ufdjIhtQiCqhVk8H32+1OCHudL6Qp7VWTlRYOD5RFnR1dsVDXheGTtVWsmZhNE
         CyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745562274; x=1746167074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lj+Ua/fxMyjIfoIv2F4j22EXalsnM7wsPJwCRLC9/bk=;
        b=TfM4KiaC8Yq4AKM5buF4HWi1SPqgWEeQx4mYuUwBqGoGRcr1TzGFlGij+J3sZTjrr0
         C6yHAoR/jSVg2DJHjQsrdfqX/mRuP2R4ad/IdJa6DMD2qPAis5uqs/oCcQrnXxJV0e6/
         hSTz6w0rUFnR8STPGBL3EmHNpIMrVgo9y1iuIyHFYF2Z6Grqeb2hvV6tPVO0cJxNFQDA
         IDDUSIsRgbACiHXVha+xyU2DwtY0wZhn5gNEpk7GBjT5W86NGbLyB5eGbcBDBAqjeN0r
         UL0yHJeXCoolPKvqMMN2F8WqDs2Ab0Ic+4IkHrNVKXHKVuByg44QkDe29DxBTHjRsDyS
         /vDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhvogODhnQ4jwknLxZaskCatEeab07x3g+GWH76wZD/udL6Iwwy7rm97QnUyNvGw0pCKh4OUDtJVdERt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmpqODHTtDlvIsY9ZWBClgEdnWnjCHKxWthtB394MEQevqsoa
	9VUSQGYFHzr2Umf+fBuMwTWWEloS2yILkFkupE/syDOVz9KFAmRf4/IVhY1VQOE=
X-Gm-Gg: ASbGncsWX/e+L2VZ2s+mDTUQDlt98fo1OwwFJ7ls6xisLyHWGcQOHoK26uBgh34fsjG
	+RdB2QbrLjpKJSuqLeSrNtlgt0lQKoTovHK1A5WPEEiTHUxRDv/CyRZDZ5n/9M7kbMOw9gpkYqQ
	kyyialeWu+ckkTYWFwppFJQptONR4mhQ3NezVyItsskB0XpD9kSCvltspf6ruBGUgZivmiNl7le
	6TzRJZuKfv8ddsT7pQcfYpRHv+A6OQw1ECq1BiCOCK6cE4ioz4n6MrTwvEZjOQNyzkUIVl6rk+n
	fGRZK+6y0/HFLnA/9siInmtMsYkxIQ00xCKKod5SMppWRGwY6HYPL7yMj6dUrOzHFi1TmACqYun
	lHpZlIw==
X-Google-Smtp-Source: AGHT+IEDdXd5kbSoH4Xib1G7dTZw88ksDYgy2jsOxQA8Z6WjXNm/WRbjW/6m3BSTIQudMRJ2BhtnkA==
X-Received: by 2002:a05:6a00:124b:b0:736:5dc6:a14b with SMTP id d2e1a72fcca58-73fd74c0d9cmr1421536b3a.13.1745562274548;
        Thu, 24 Apr 2025 23:24:34 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9fd26sm2414367b3a.151.2025.04.24.23.24.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Apr 2025 23:24:34 -0700 (PDT)
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
Subject: [PATCH v4 1/4] serial: 8250: fix panic due to PSLVERR
Date: Fri, 25 Apr 2025 14:24:22 +0800
Message-Id: <20250425062425.68761-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR (Receive
Buffer Register) while the FIFO is enabled.

In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the dont_test_tx_en label:
...
serial_port_in(port, UART_RX);
This satisfies the PSLVERR trigger condition.

Because another CPU(e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().

Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
to fix this issue.

Panic backtrace:
[    0.442336] Oops - unknown exception [#1]
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
...
[    0.442416] console_on_rootfs+0x26/0x70

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3f256e96c722..a913135d5217 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2380,9 +2380,10 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	uart_port_lock_irqsave(port, &flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
-- 
2.39.2

