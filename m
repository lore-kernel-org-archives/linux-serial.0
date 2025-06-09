Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDB280CD9
	for <linux-serial@vger.kernel.org>; Mon,  9 Jun 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455072; cv=none; b=V52GS83me54zigvd2ZyHNZjX7DN9ihfQcmDyFZzaYQaVcZj3+PBzIoBxRpPEKfgUG+Dw/6eiNNOhdwHccozev3FAN+shG3XiRxh4qiOLWxMop489VylNi/IKkwNXif1rLahrFFoClLfOqPZie8KllMxbJpx1iiDekeuVrTa4FwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455072; c=relaxed/simple;
	bh=Aw74MEKOMSP3CtxTaewVFE8Ntfz0jyoHZgR+tmeysak=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vnfs+8SFWEinyQ2YvxdGZH0LaOQ3Et7h4bd6PFb8u4sKvAQzoNJ8Kzrgy/cOwDY69Ren7dDXKQTE+8CLbxIIAul8itMxtXLM538dtS6dGsiPFAmCYpuruma0XLXXS3dgyoofhDSgi6IYxSgH6qk4e+PLmENwrDhFKiJ8YS11gSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D9T/nIOB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D9T/nIOB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231e8553248so39725795ad.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455070; x=1750059870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2r8WQzb+JVgSyOxnE+i/6qtzBR+LExX67w7PlIfP4M=;
        b=D9T/nIOBr5rD/jqydN6oggzesNBzh6UoD+sv4Kbdx9WnnMuxasFCMbDoAvnsmT2Jhe
         z8h2A1BBRDjs64nxHHtHaj1lkdWgHmIEH/dWEU1hDS2VZ4ysNIGHLP8vViy/ccf7hrKz
         HP7674AFLHJ28q/3tweJKae+Y6VgtkNnE2XpfTQrIlvKxbVIDAI6ikR8SN/ymfsT5bIX
         D8YaJZDs7J0RX8Akqbhj97YAPuCXtAfB5BYlk/EDTZFYg0X+n9BYtZVSrOxaEufANs9z
         bnWzGaJ/nAabwI3iL7TZdVnS8au0bFN8L2b4yJm4NzZ/Wk+f0CdO8WmKA5qLZm/Melo0
         +Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455070; x=1750059870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2r8WQzb+JVgSyOxnE+i/6qtzBR+LExX67w7PlIfP4M=;
        b=gV3JWKx+jEeNX/LrQgNjkd+n0I1nqaHhuw3kxM817L51jwv01/q56a010vru6yRrhd
         X4iPuX7uS6VOAvW0iqFwhV8K7KNw2VouQDLTNpLS+jO81LJ3tciwsrskarfDpMdXg+Gt
         c2QqNHbC4C2lnmnbDDSR1m1IV7JNdwEmmpriacyFlQb1APLqQ9Bw8eiHLALZ9mrOBlO+
         c8kHuSM7YU0hMuKtrZQOsEwCRjdWLbujQ1gVKWKyKe4WDkvwn/u4C4yRAkcN7xpmV379
         42Xoy2Sky67s03NuxyFR/6CoqfgZiRXyuDJAlUuz+Sbb9TnnaGXyIaZjiCSci7jHs+JJ
         VO9w==
X-Forwarded-Encrypted: i=1; AJvYcCWcdq8F+YluHl6WfBuI9NkKTyPvmnoU9NGXn6q3NNygLLjNh+YAUQZP8GvNkoQuky5UuSmfB/6ywGnnuZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziouIPsmzgbD3uULfH4OHyA4uDC5P7SMNrsQ6VnUw+7PKtJ/Vv
	yke4d6W9DrTZ7FPU1/r4AL0isifBABEQrILebfqsJJODzWfKOTglrSb4e+LWRTbAzgw=
X-Gm-Gg: ASbGncu0TxZ1r6lBiYa7rcRMmwqP1HvpdX1KGCN9mrYdwa8gTPJAYsbJ5zTNyT1tKDk
	s23wG094Sanp5YTBMLCFq7PZM0t7/HKmuEhjATZF1ZZjMH4nmbrD8LZTpLbbrTYXYxJ58whS8P4
	3rTL5zsDpCdTKbL1JsNSVyGEGPYre0Pib9QdmNhQ8XBmdmxvV9weO7Psbzf/5d6NSt7XdK5eBQt
	9qG1xlxiGEKamAV/HIqE1hhoemXvf8myemuuKglW8AIC0ijgfKEL01QPrPEy/wCVD+x1ino+9NJ
	SaFzR3MIgDaLjCFUBNBhD2xVRhd8zjmk6ML8uLmQMFk6DV7EHZbQOMQCQTSxNjwODD5eJpQ0zjd
	rV9nbJ0tmrIsdCsiSE5n1/aZA/2MUER2TC5gSjok5CQ==
X-Google-Smtp-Source: AGHT+IGpx0fPdgm1EKp0dazP5RH9EWCW35YAP9lCiJDVJ2NhKqFRJ8viahaNntjBxyQhSeZ1tKrS8A==
X-Received: by 2002:a17:903:32cf:b0:235:6f7:b918 with SMTP id d9443c01a7336-23601d225cdmr180747485ad.28.1749455069674;
        Mon, 09 Jun 2025 00:44:29 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:28 -0700 (PDT)
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
Subject: [PATCH v8 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Date: Mon,  9 Jun 2025 15:43:48 +0800
Message-Id: <20250609074348.54899-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250609074348.54899-1-cuiyunhui@bytedance.com>
References: <20250609074348.54899-1-cuiyunhui@bytedance.com>
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
Cc: stable@vger.kernel.org
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
2.39.5

