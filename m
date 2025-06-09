Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9C280337
	for <linux-serial@vger.kernel.org>; Mon,  9 Jun 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455050; cv=none; b=mTVZFpNbqR3yWVBn5tiJwDh3oM2Jvzvv327983oTJW9RAPeNh8NfvQz4QS4TA6LXLzBYNcce6P1r9BsvPE/WzmYptHeafLHpEGA1LNT4+Ckk+zq37aLORQyTgN0UxSuTSpHQvpy/dpewjyanJisE2dNDmaO+u+C4zfgCsy7Znqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455050; c=relaxed/simple;
	bh=Yay0E1IktJ5U3dv9Jr5sXBr5qazP/zu1WzMA4ShslGg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EGG6wY0HwNS5iRXikTPpaoPS1XTNu3nO9ob7HbP6EYnCEqahZY2s9ajNEjcbQcLf++oxJqfqK1l8Wdp86u08wgTYJCH65IfBp6yHrG3g7pMPeWIgekB3mmfTBQPZ0v/DjOgddtd67wrHB0iz+FR6p8FAmA2PaxWxCQ+nZm1TjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zjw2bvIG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zjw2bvIG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235f9e87f78so35360105ad.2
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455048; x=1750059848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=Zjw2bvIGPVF1gEa3KglU/w+QSyYvW9e6HVircu3B5lvU5QaEglyDT7CIAtU85a6lKV
         2F0u5ll9HNhfs6Onpryu4q3uee3ZOOMLPV+3CgSDyoFTXw8hdTDrwXZw10mmikQ1vLJN
         dCvIKgOcKU9ujVqSb/Wlgy5I+WyYL5J4mkTEyDj7GEx2ptth9Et+xTs/8TRpW0kjwnYv
         fzKhFa8Kt7jSTJq8pVjw6vKamI2WTqH0xOqIT7E8oaKdQEzV/wHwTl/wUs7YRh2Qhe9K
         Ocn+ee7mY2NvmSlSHl+8aJtHjAYOSRiFRfEaSFL4GygTEOe1fojJ/uvniohKKzSIIgdc
         kU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455048; x=1750059848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=LGm30u9M7lm60c/lRp/pt85uelWOdTwD4s1CCsYCTo4xXOaig7VHb7Lgj5DvOljKsh
         Vbdr8BVHFD6eLT/IKA66Tu3E4tNW2X6CwxkoI14sfaI+epeizg8T9TxO9QO7UniLFHOb
         SDBGRUmxrEK2vu+s3c4ECpTTurx/B0B3nyFQjMCwfMLT9kRNtM+qZX4nqHYx33BXREoM
         3WILiKiq4N6aNFxn9YnRMt0AlBv9xVc/ezP8mfvQslap5/xlTsZEwDg02oDR3FZIZCNg
         6AzhOlYGxefgV7aYQ9EmSUHyU9e4qKgyxNcqqzFxZnXtIq0llVDF6YxjQSa8FqFWKv3S
         5iDg==
X-Forwarded-Encrypted: i=1; AJvYcCUnUGZ/CvVmn5UJjfxIROkqgQm4+KHtpO9BXrvYwsbcrFNG+Ccw2b2wiMG58wJwYvywt5nUHvW23jICVf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyViC3iBLN9vrxLv906Tkbks/navGqPUioNzW/NN4BPWFdTEsvq
	zwxVQmRi5ly8iSdziOjk2n0Aw+nis+nrgYwWo5G8DDx/3gplMGICK2CZcXa7A1QFxCc=
X-Gm-Gg: ASbGnct6nvD+gEE/y1wiC/SotOaxq8C3FmxHT03+Hb3HlvFFuik2iqBUnYB51yd3/++
	6sR51VtCjpYYw7C0KmL+Uuv5sFEMfKQok6qT3QVoGKrA9myxCnxIHsIu00wEO5bZfV0Np5+7KmN
	HkB1Xugue0/8/TW66Z8AY9HtS8R1rgSyUhaVsflv5+7gD398cG4R4U8dwM5qSF/D+cpwvIXko0b
	UqkuRCDeFUjVAXe3J+LFd9zKHKkVKgBwLibH+8wAKwS70QIqr8m2KFPxQHPdZScByXUutuK0I1V
	re8D6PIy3l2/XHoBjhwMguN0lZsraZzOZ/kpdrukR+Dg1ZXuxSTfzPFVAAx3GBCGEXDbfLAoOO7
	FnVlLFTLPWAZMVBZOQYt2LvXmMBtE+wgly5sEl4VIwA==
X-Google-Smtp-Source: AGHT+IGfhLJOOr7W048JUz9Br7St9/rblBkEeqaO1eS84wCT9RHG7Sx6FmIfAdyIRIjtaw9ZkajVEg==
X-Received: by 2002:a17:902:d50c:b0:234:de0a:b36e with SMTP id d9443c01a7336-23601da6138mr183133125ad.49.1749455047769;
        Mon, 09 Jun 2025 00:44:07 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:06 -0700 (PDT)
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
	tim.kryger@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v8 1/4] serial: 8250: fix panic due to PSLVERR
Date: Mon,  9 Jun 2025 15:43:45 +0800
Message-Id: <20250609074348.54899-1-cuiyunhui@bytedance.com>
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
Execution proceeds to the serial_port_in(port, UART_RX).
This satisfies the PSLVERR trigger condition.

When another CPU (e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
dw8250_force_idle().

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
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6d7b8c4667c9c..07fe818dffa34 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
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
2.39.5

