Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FF22D7A5
	for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2025 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562293; cv=none; b=Jf5TrKiecP0dlxr96KFAD1EQ2ipDOgXduzSJDoZh014aDRaWu1y/NYcX4swAXmD+yycmnB4Q9J3rmQ51cr9AA4RgUCWOMd5d9eo8ZMlh0pyu3pRY0myl2VzgNAnRoZEK6RWsaz79Rvs6V9vQR3kXEVaK6+PsdMiPVM59QIFwkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562293; c=relaxed/simple;
	bh=LQ95Vn+tu9HRCgEKYvi6s7BkWHtV8kryNAYsYGrRkI4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ck7jicaTBij8YidR+TpASun4a/YElhYz+iNQ2bFY5BYw7/bVGCAUEqLzEL0x8s1ZDqryYInC92uWEppnVAgCSo6MDP3hIP48FpOTonpkZOcrAA6p74io6Vat548X/6Y0Yi/TkOKKIb1eBlEH/10Xvz59ubSlb1dOvKHcG2hG+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d0LbQN7i; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d0LbQN7i"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-739be717eddso1422799b3a.2
        for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745562291; x=1746167091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbKfQhlrgV1dvkptAfP3aiGbVJaK2h9Q5oUHug4Z1q0=;
        b=d0LbQN7iFuV7MwJuAyX1niiaT0vljgraw4OKPbUNwE7EhH0b5inakDr+bPATwhCqQI
         rakuHVXQw/6f5VbKnFPj07mm1FABtfRIUgA12bl8I91qHfQqDu5KiEp/BtPCMQQ+TMnX
         ZF+1osSegoXMwr2MapldNCYAwo4JhZJF0L6/iOFl7V+IMV5xQbdXVQwXNOMhySKC1lIy
         39jGbuTDahMwrIRZcdgLyWnJnH1nRkKbucmRINa5DGf/bEAZEYY3Ou5sMBzLcBtpawyI
         CLBtVPKrlwpr7YPuLxgbXeWs4N1li6VND7Y2445C8lgiTAxX3RbGD0homdt5UVz9ShLt
         Kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745562291; x=1746167091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbKfQhlrgV1dvkptAfP3aiGbVJaK2h9Q5oUHug4Z1q0=;
        b=GPxaBhDFGgLlkOnrbG79tCqL2Pof5UaDfUC6VzKSoK5lCraIGBBOkaW5W3OUzoT/J9
         v7T1CzL2Iw1oewXGYCwCyd4Esod8Jx0ztLA2FCteXbcsAdq25RiUvomOf3XRild3p/Lc
         Yd+pN7UXqcNqKPpQuNaZJl4ePe+yZMPM4hVKgGrgjrzUwNy7ofbR49QK/uMHJEfBT3Z0
         U+8UR9ce1Ib9CWU1lW5Tr5xI2AKEPJoC1m066thAeZRQTWKA0DgbXf0HkGgfFPJ9olnD
         qZh3X5JR4dcuTglECX/2klrdixLMSZQishJeoz937R6qVtdRWAn3+KoYD+9QXKKrEySK
         Do9w==
X-Forwarded-Encrypted: i=1; AJvYcCV6jVbFUYFTM7J23IdZYpdGO+xCZ7Nr7e71p/VHoI0quvQ+Qj57+u7BdocfIpXGOHXWEjsZ5MGg6mKBKTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xh9c5uBWpAVuKtwyxiCgjk/NBRg3qicPAP2PYGPd5uKQaVXf
	dOK6ZFsS/YZIPdnMPY2Qo9b2tLH9Ft5g1YT15n0Wjk6KJXYIviOnqPyphRGAwNc=
X-Gm-Gg: ASbGnctOzHHDYw+V305yuJ9hSzSYlOwwri5S+TaMWjWyVvk9DS8BQuXcA/+x8+38uTC
	raiMJAKHgGLK9rBnGjEIpaJlQfw+lqReMEK+0o1bs/crZYCFzUy/wNNM4Vafaq9mOcol0uQ1Die
	A7mu2myJJz6n04+y5N3LMmqW/BLlnntk+fb8RlkmLOC1vfoo0/GGXdIQ8VDzkP0A8YUlCE35Adi
	KSK7gF0brf1Hm0/k0rFjiF9L3NtuCY9cmqUj/L+q5Jg7ryEFEVDUFc9unfAY4RWWofZJcr03LpL
	zC/RoUtFtzTj2pjBTh32/fsb4txWXIIpj3OD0RwgaywlbwjKBMO3LPyInp8Lhy9S8gj/hUGENc2
	WOEe0ow==
X-Google-Smtp-Source: AGHT+IGcbZQtP6uVVePTGOPuBjQ8FV59Z2pbuXebZ/lw/iyZ/2Hsb4J6vuN0bZPf+LViOoXHP7YXbQ==
X-Received: by 2002:a05:6a00:230c:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-73fd75c4cc5mr1455328b3a.14.1745562291301;
        Thu, 24 Apr 2025 23:24:51 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9fd26sm2414367b3a.151.2025.04.24.23.24.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Apr 2025 23:24:51 -0700 (PDT)
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
Subject: [PATCH v4 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Date: Fri, 25 Apr 2025 14:24:25 +0800
Message-Id: <20250425062425.68761-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250425062425.68761-1-cuiyunhui@bytedance.com>
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case of RX_TIMEOUT, to avoid PSLVERR, disable the FIFO
before reading UART_RX when UART_LSR_DR is not set.

Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_dw.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 07f9be074b4b..1e364280a108 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -273,6 +273,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 	unsigned long flags;
+	unsigned char old_fcr;
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -288,9 +289,19 @@ static int dw8250_handle_irq(struct uart_port *p)
 		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
-		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
+			/* To avoid PSLVERR, disable the FIFO first. */
+			if (up->fcr & UART_FCR_ENABLE_FIFO) {
+				old_fcr = serial_in(up, UART_FCR);
+				serial_out(up, UART_FCR, old_fcr & ~1);
+			}
+
 			(void) p->serial_in(p, UART_RX);
 
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, old_fcr);
+		}
+
 		uart_port_unlock_irqrestore(p, flags);
 	}
 
-- 
2.39.2

