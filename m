Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA723CE
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723004538; cv=none; b=Ty8PhjBt6NF3tufaHCIr66pgYkRVs2/IVwG4DPugymP+imKRoey/9xmXrvG0LHon7qq9dAVCKWPmyd8SkfUdxIrldl/TXutowuHKccippFfTNrgt8ys8Cz08vQmZE5TgjkxipdF4Y9wr0xuj0WVaY/NjdV6ry3z1Y3bI4ahZRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723004538; c=relaxed/simple;
	bh=OUDVZVpDM60+WJw/4nQN+i0/BS3Fu5cb1j+2laPnrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEPCefOdsPujQxgYWWIDNEAPMFO5ZzRv6tYM56DTfCJeZR488dtLiMXPCQM4MyTS8L20HUSdKgAzuXZCQ1QQpl44gl4fFjSqXZwWwE8wl9OMy0xRRosfd7FDkjc0dfWU1+kqjIU3nGtIk5310YVIVp+YYDPw7W9lItLv1nrRCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FgZNwb1Q; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FgZNwb1Q"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-710bdddb95cso137330b3a.3
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2024 21:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723004536; x=1723609336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODrrXCKFl27l0TdKNyRcbT+VPRTMv6P7XxyHAeczN1w=;
        b=FgZNwb1Qu/oxiem+m5FjFN8p0unqv9W0p1n4PM1be5YiFrTjmadoSW3o0lecs9Jje9
         SpqLJWVNY3wUkkwkZLvBFe984Pi4Bb5Ycw0KWoTd5dy77a8pV7ynANGMSBnB2ZGQwTfx
         Etnj8kSSoL4uhHs+iSJeXUmtcTBOcGJkzcZlu6Iw+hVgQR+El6ZaTDsKxHVvx8+Cnb3Y
         znTDKgF2FyHNHAzmTlP74o7HEd9h3FPkusuuSJ0c/sJ0diH7zRlxZ34xC8Kna98O2tGI
         lwaaAJGFBuOEGE/4FDrH8IFpXpOLiE+WlU+QC9VJiaNdDi+eT/h0eizw0KA1aKGVh5l1
         7RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723004536; x=1723609336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODrrXCKFl27l0TdKNyRcbT+VPRTMv6P7XxyHAeczN1w=;
        b=YJf6grK79t6y/2MIMO0jvO7tBEWi/dcQ5k5vkEVQKn+LRYQ83AhYjCMnCLIVaYcl1w
         VQHHuI5cfiLT4FWRAEAUgtu8Xt9FWO8yXcUV6fD/Vjg4VLMfiy0hWYLAJKm411qgnL54
         B1y3wASdjrCxMaANUrs/0U308IpQeSsYkWIME3u003xR5tSqYA4nHsaeJiWNG/Wkx7me
         LNd6SDTJ9quGhOTog4qhDUafPBoSE+jFm+QoJT5pCb5xHu5qDrxN847y2ptnoUAg9Q8a
         m31y+BL6wsuEa5RUjV+5zbspu95tYyEQtUZHjhAbkPeh849sACRLQvWalUIJzsaGa497
         KXRw==
X-Forwarded-Encrypted: i=1; AJvYcCXPYbift43irRuFWnemGC55HXNtj54mUvnBHq1xg2h9h+Xq/Tk34WO2HttCdEDjnJWu9QIkxf+fmeKChVJJZFQQD4ZvOYmntJBh6mHZ
X-Gm-Message-State: AOJu0YzmiVJW7MmJoIX3JecYXKZhY+CLHIypEDqT+xpzOy3h16no6qbF
	HTXiixG/IxIxy5mDQbzHFn6vp6x4nJ/SWRzQTkaVMR4eC07UGpml0IY/NbA4qKw=
X-Google-Smtp-Source: AGHT+IHo+QNBUmRfFn/4e0S3w4ZD7r2yxF/jnyAMK/mgIKa3pyo24mQ7IvIDkoO38jS2ZwactIBmLw==
X-Received: by 2002:a05:6a20:1596:b0:1c0:e540:7336 with SMTP id adf61e73a8af0-1c69953c6d7mr19039259637.6.1723004535952;
        Tue, 06 Aug 2024 21:22:15 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec49b7csm7630532b3a.63.2024.08.06.21.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 21:22:15 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] serial: 8250_platform: Fix structure initialization warning
Date: Wed,  7 Aug 2024 09:52:10 +0530
Message-ID: <20240807042210.1608026-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use memset to initialize the uart structure instead of universal zero
initializer to fix the below warning.

drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform_probe':
drivers/tty/serial/8250/8250_platform.c:111:40: warning: excess elements in struct initializer
  111 |         struct uart_8250_port uart = { 0 };
      |                                        ^
drivers/tty/serial/8250/8250_platform.c:111:40: note: (near initialization for 'uart.port.lock.<anonymous>.rlock.raw_lock')

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407310023.h0JgJG1C-lkp@intel.com/
Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/tty/serial/8250/8250_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index bdfb16bed4f2..d8c3c169a620 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -108,11 +108,12 @@ void __init serial8250_isa_init_ports(void)
 static int serial8250_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = { 0 };
+	struct uart_8250_port uart;
 	struct resource *regs;
 	unsigned char iotype;
 	int ret, line;
 
+	memset(&uart, 0, sizeof(uart));
 	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (regs) {
 		uart.port.iobase = regs->start;
-- 
2.43.0

