Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6827AC5B
	for <linux-serial@vger.kernel.org>; Tue,  6 May 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530613; cv=none; b=QkE93wwMWbF1AXELhKB1lMlqqTTG291VKtgGWGepfG10IOfton+GueIJSrpR57epYqPkClixxiU5NoNikFeSoO8xk9t9ggz54u5SpeQFJ5sfaTHxx8iEt8XT7ZYlyg3HrfL7YT4CHxOlQPromImJS57bNK9g5E+c6HSjB6BLCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530613; c=relaxed/simple;
	bh=xjL65vzHaYnd2+Zu9zg+UVvkfoWrRNrqH2KTKvwr7nk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RVDKO6WH/GKHkMHik4leuITQFFnyey9M4MbrH2/edMYcgVY119A5eIi8CKMirpUMqX425IGMabj3f7FveX6seoB93rbjRvqtrcOBWDvAMqj19iOkQp6BdEgTWgFqyUeqguQLsEDLlgnvMjznvZh3GFwsCVh6+ZEEnMpeQRE/lDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eRXQ5XhT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eRXQ5XhT"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b07d607dc83so4617885a12.1
        for <linux-serial@vger.kernel.org>; Tue, 06 May 2025 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746530611; x=1747135411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lj+Ua/fxMyjIfoIv2F4j22EXalsnM7wsPJwCRLC9/bk=;
        b=eRXQ5XhT6sobBVK6SdyeCkzoJBQY+Uj9EA8VYsyVTDRZ2E6zgvPcYkMdkcbIqipQuF
         RktkxhUk+zROq9iv+XmdDDxaqWZS3bjVcS8wRH1fr2InH1XyXJECwWNQvF6ytCtUz0zu
         zFyO5J6sppKI7XThFy5Fj+A1plCuyhMyJC6aUUEPBY7ReH/O8U/bi/fjE2ROGaLn12wj
         RZLXHXLWKHY9SSsr+q+oBnXLF5YFvCirU9d6rD1ESqmMHCl1OoSMd+OJFisG4q6i2f9e
         o3vgeGI1SyACrluZ/+z/Za4ZxZxi6Ia9N2+vc41t6hn5NpGIFjRd9FcY8FdnxkYMYlE6
         WPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746530611; x=1747135411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lj+Ua/fxMyjIfoIv2F4j22EXalsnM7wsPJwCRLC9/bk=;
        b=mpV2AObD3deYfJHTYGP2glLNvD64/Jg01kVyIoeQ25YacB0AEeL+ENMur9bzVNNBYV
         5UbXX2DkZ65G8jVtYxggWEkdRU1RCJUgZ6HD+BQ6nUWv/xZbIsJw4+XEPk7S7hQ9nXox
         7O8nTvw/VMWtVJU0w55S9DgeJE1KxbqOePkiUYl9v5mjVYsqzmOllceoj/8JABOBlhJz
         jFAxAx9SEu/nEeBdhDsmOizuzuA5EExZ63B54gxK3bPBEphQgxdZEfv8QoXxrEAmFMvr
         WSL+Vxvy1VEOE5gd+rqJGWP5j0B3SbpJCszZU03JDfNsflPEiZWRucYIks8CGqUAyS6p
         yWdw==
X-Forwarded-Encrypted: i=1; AJvYcCWiWdl88WBMzNY3f9WKP2CFcmlDny05cqoQgbrK8yjss18jcRAmOb3vC+Lh8J71023/cV8nRmqXazAK+W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpwHckj+i/yQNoxB9QxVjVexIHa5NAp6LTTK9KHiNFD717SLK
	PhakPHToeqpDVhXKBns0mF05JeyRMVwI/6BySJp5RQampK8DkBawxUEMCYlHNm4=
X-Gm-Gg: ASbGncto4donvRZ0Z+vVUFs1qVJAgPiUIZPi9UDtggQv55fAMxW//FbgyhlOgb8oPEy
	LKMlXWZuSLqmLy4OQyLVsKyAk7ziMql0bXmfDyapcH342k4wtAlK5MvgSRh81bjKyt6oR1HaaXr
	aXQrZvLeT8zQYUbGQpc6EAFwbK3XmOCzb8igz9Ksgzm/GmvTfG2Yq9pUKhxTwnUMUr9U5ymnEr6
	RcYPOYG9cbO04FRfHg22TKGUs4co7Hx8uom/jKeobiUAu6gHdFaTPTrWjXn+BS4K0Ga/6+PYHrB
	qAlHrBxSJnToqz0DqvcFs0WBFpBG5kkf6JHmV8LRteSDh7cT4/dU4xJ4OmM8VMfHzP8Jd5Gx
X-Google-Smtp-Source: AGHT+IEOXeQAPiRigAJRM+ag8kVULH/CPzkxnG0tEFjbXvabNNYE6kFbgeM+fhK2lrsDJD43flM35w==
X-Received: by 2002:a17:90b:2703:b0:308:6d7a:5d30 with SMTP id 98e67ed59e1d1-30a619ab240mr19584577a91.18.1746530611028;
        Tue, 06 May 2025 04:23:31 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480ea0dsm13630303a91.37.2025.05.06.04.23.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 May 2025 04:23:30 -0700 (PDT)
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
Subject: [PATCH v5 1/4] serial: 8250: fix panic due to PSLVERR
Date: Tue,  6 May 2025 19:23:18 +0800
Message-Id: <20250506112321.61710-1-cuiyunhui@bytedance.com>
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

