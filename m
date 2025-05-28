Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996B229B16
	for <linux-serial@vger.kernel.org>; Wed, 28 May 2025 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748413604; cv=none; b=bxjjrwkZBemZq4oTeoF+MUyHayTSCJYSlgRclvEOUVLddcIXzbth/YnHUIvdQK/3J8lN8cBooOo3MkA2ren3aN9iQwpnckIIlWPdKCJIJwK8EtlMWoMrZQ3zJSh3VDROolVBaSL2DmnxDz9Z5ybc150rWn+qpxM+48EJp2kkq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748413604; c=relaxed/simple;
	bh=Hl0w23mrzQVVxb+O6fUHIAinrRyuTfuw7GdMc0h4XGI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjbwtJz95DM+kWFQOwKyG/T8wkq+pfnpga+AvOVDwPcmgQPZZvuRIYuRMy5YOR4MjJW264UuUW1ektBxerJNZBiRGluGDgk2L8wsPcfLM18nUvP4CL8AcsyFU6y0MHBECisKDvDg/WkuD5MyuRdUc4C6KvilmvZ4vVtr/FzOCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FW3JdXuT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FW3JdXuT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2345c60507bso19693705ad.0
        for <linux-serial@vger.kernel.org>; Tue, 27 May 2025 23:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748413602; x=1749018402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egKi337a/czANHevIeQRx3Ni+h1cnqrDQFS+UirVS+M=;
        b=FW3JdXuTBJ/YJzb0HQkHGhSolA7EsopwF8zH6ZZ1bM3MrMpifKi0ux3cfh1B+yP5Ug
         L4DEcjTIpifzCKlp7UGNyO4rAWbJhPM0bQO27ID6s0mKaQCZo9cqZgkG+Pm098gi/lxu
         FlB7urvhqu54RguIy65oiWGA7SVViuFW4Zc/wQT0OFxACeJXHMukfup+sVDAAQmVmFYb
         A59hc1nucpDJWfAKfUBJBC/jhUAYhZ648GC20TOY4qLFV991tlR3fwsBElg/WeOSuIcC
         2WuFhQ82SmhkNqUVdX0eCiahfIhPnOzlXC/LRufcH1MSGJxcYQmb78u3hEKBJrugS79h
         atSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748413602; x=1749018402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egKi337a/czANHevIeQRx3Ni+h1cnqrDQFS+UirVS+M=;
        b=i3FCT35e6Vy1O/YrcU9NQETKs3VHESAvhS9E3tROTpnfaNYSXeex+ZytQjKNtygAKU
         PdEzh6cxvKucYropzciYO6IEOyRzojiF2CvhxXxYTOfVmNwC04OxtGMpyuz7K/tb2pe7
         lpPrRhHiC2e0HAbslEB53oFrFJRSJ/NeWsIh8lbF/bJ8UMzucaa3reagF0jteBi166Wf
         qOmO6XlpX+kVG0ii8fTBUVR6x1Bb4tLi2BDUQ0qJiGHP4YlETtHPlVVSUE7LzfBQeob0
         wAjS5DKcgBNjlHiSP6ReBEqj+fk5p0GuSJ4ogE0bo52yoLDItTcXZDAb4iXXwtdK+Te+
         UZOA==
X-Forwarded-Encrypted: i=1; AJvYcCW1cOxEb8UvlTLpojTl013iEfBbUZkWzooRAOxd08WCNtczGxqAj4rxU0yl5A7IwyeMB/UCtIRr+YMXjWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4ZgROAs+9qDiedEvoHVAplEHSWQe7YhWnTY2/eSLNroOn3KH
	M/6rSnPXo1sRIhqnfpkL8byW59/ReebiucQyDDIM3ztcFF2WlcFN9RrrwAYrONYN1ek=
X-Gm-Gg: ASbGncuiZ77xBGZpcSSDx9BD503IgOw5JiqPT2ecBTSir0g3GwqJRJMK6aC6M4/uxuH
	oyM/nYLYoww9TZTbMF1+JsTzwIyS2vHa24rMSPFkYlNvvDI7HAt4e7xxBW0KjTLx0IOXr8QAIFb
	X6zf1qBnjDTnxV60eLivBXb1mM2/NUW309Rmuq2FtcBqZVPyBu+Dc62H+p/5CrgZk+w6Mdmlsmw
	KtvVbBxWhRcBEPTbgkMprd3TEbUNY9ACsI23Lx/yiylmXbVM+4OPU5hOgpvhoOA4jLKeJDDkhXl
	CmA6hlec7J109BcxLJqlE/+4DO+Hpl+541zRPDnRdvcjA36QMoOpmzcpbQ9ijN6q1l9asUub6L5
	nDgx91hEyLIm9TgNmUWey
X-Google-Smtp-Source: AGHT+IHHp2wXUQjEdDIJNL7mrh4ujlV3e+koW9KDIE/Yo3qAyu0LXQJ4yBHqBGF03QD+PyHMJ88zuQ==
X-Received: by 2002:a17:902:ce0f:b0:234:bfe3:c4a5 with SMTP id d9443c01a7336-234bfe3c615mr41162865ad.2.1748413602186;
        Tue, 27 May 2025 23:26:42 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35acf6dsm4619515ad.201.2025.05.27.23.26.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 May 2025 23:26:41 -0700 (PDT)
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
Subject: [PATCH v7 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Date: Wed, 28 May 2025 14:26:09 +0800
Message-Id: <20250528062609.25104-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250528062609.25104-1-cuiyunhui@bytedance.com>
References: <20250528062609.25104-1-cuiyunhui@bytedance.com>
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
2.39.5

