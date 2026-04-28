Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309E359A9B
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358753; cv=none; b=bhbE4O7cjne7Ft5A8N+YO6VOLn+umd4zNjzSwO+w0X5Nh5QjFMPsE/qSanf3iXOWkJ6bBwCCC2MDD/ece5YNh/E++YvNsZ5JhOTA48DtHRobO9eMJ+CQDO/4V0GWiTmyiku9w/3EdVP7nM9kDFUQ7c961J3ZhcDgW8HIcdpToJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358753; c=relaxed/simple;
	bh=LrBxBwY6EkcnJTBR74rdDGe5lj8eS4fhoYBLHr+YRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZW9dEIo1fvhLyprcdy5NRW1sDSrgBc8qo8qSbcykEJ5HyrekY2elTST/dOGcXW1wNixeL11Wa+DOaQWxh1WDs5lHVo6c1pm0rBIg2XOckTSppiwc2mDYYr97cvadYHwHjkcbtsIvwsi9iUZs/FPUJ7ot1f2AecgoHnc6k/7l7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQulWSKc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQulWSKc"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82735a41920so4404470b3a.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777358750; x=1777963550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8w0oIZcJg0HWH7qp36mqtAMYVvykKhAQ4v6aLfKU44=;
        b=hQulWSKcRgvsxaMvMMLKTqaLMubTDBJAq2tyulAdTV1tAB4+V/gJUNl/IqMX6x7hin
         zrNBk8r2Mz+/BtobpKVgV7XSb/odG/0wv+9IwE8SIua75xAbqPu6xrkcxSX116lqF3zw
         Sqb/jpAC2aZuQOwLQSDv3VZ5V7gItqd7wkvj7hMCYgP0ixygHZRvYeerGPZ7EFU/FxOH
         8AK5fRx8N+JRBkBfV1IWn/yVO2d3LDEYg2VmAPmpyEqhX/yKWS4DUxfPAhYP8cmpwVqa
         8AgM8z+Ktya7fdBgisH+q9m7zUoIyM25xLU/RtqjY7GnAUNf6KfVPjthKC6tmKKvPkUE
         EggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358750; x=1777963550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8w0oIZcJg0HWH7qp36mqtAMYVvykKhAQ4v6aLfKU44=;
        b=NWZj1EwOUA2ZyGbd5nY75zEnSUgcHrWOtONfGmPXcrlp3JcMdb1/G/r2P/cyW+l6Kr
         WQ6a2WC4Nz9tLdDFQ0FHXYR86FjzH+NVTwzvqTNlZGFe0uHiJgyJ7q+ppw7UpcfMomfO
         M2nbDbCrBvrgz+zc/fGxn+EeIhhuaoKfAhT7MM2cxgQyLtnGtepNJrazkzkpUl9yc39X
         M/2kcYTBoZyTh4IvcuoM8yxY/2/fEnHzTdKkphrDre6bIWpYr04wsdzm4KwxqaUn8ZHA
         gZiVG8PEzNs2RuV93/I610tmODLxzWZzIG17ems4tEOdKaxgVKQ+sN81bRttyk+wq1iK
         niHg==
X-Gm-Message-State: AOJu0YztHK/jSXkO27FWm0QCibBt8ZMKOgiXv/wpwU2B5aa4PzLxwwme
	rdWxaoVO+h+tqHxsQeBW/VacnsPB1NyNpMei+ic7tmd6HlzJjXR4omBgQo62NCW1Yg==
X-Gm-Gg: AeBDieu512obCUrxcaAHv9ARg/PKb/GbqA+g8aYIaOZOTtZenBYnTQZXS0au3Ai+gJm
	qKux/1vjc21xOd88mxxHcmsbYJdkX+7AmcBYbja8Wfz2aE+G29FysFkgW0RVdGp2PIO61YfH+xd
	SNfa7SI/G+vEhqf9a97PvrRpr/4JMdMdDmtB0ZjizZy145FHyNHldjPQuNJG3wVyWb010nzcle+
	OxVmVvlXiOu49ZA8+Bal7Jo40Rbgzly73YtUEsH+hgzTRkc0NGj8AAsYhVmP4daNDr0rH2Grs7M
	l92fHJ1yzKe5FnT5SFZI9zVNXFBliOLWoaS886DCjhJS8EMG+oajJocz69hQd4NKYxKIwg3Q3xm
	TguMYCZyXEGLLH1fUuxhE6CzWkloDYksrf8E9pSpHW1T0EPrZZ19cc0w9mTBDXALnXVDmpKT301
	AfZGCMrNBX09UPk9HlrSPCdpSwdsdOkh9uqYpck2AgYbloDbEb2BEAZIzzoVOC61JGRfa4s7Fpo
	XdacC+srw==
X-Received: by 2002:a05:6a00:4387:b0:82f:5125:a324 with SMTP id d2e1a72fcca58-834ddc488d1mr1861650b3a.36.1777358750356;
        Mon, 27 Apr 2026 23:45:50 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf3122dsm1468905b3a.32.2026.04.27.23.45.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Apr 2026 23:45:49 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tobias Klauser <tklauser@distanz.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] serial: altera_jtaguart: handle uart_add_one_port() failures
Date: Tue, 28 Apr 2026 15:44:57 +0900
Message-ID: <20260428064511.8934-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

altera_jtaguart_probe() maps the register window before registering the
UART port, but it ignores failures from uart_add_one_port(). If port
registration fails, probe still returns success and the mapping remains
live until a later remove path that is not part of probe failure cleanup.

Return the uart_add_one_port() error and unmap the register window on
that failure path.

Fixes: 5bcd601049c6 ("serial: Add driver for the Altera JTAG UART")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/serial/altera_jtaguart.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index d47a62d1c9..15588b6dc3 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -379,6 +379,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct resource *res_mem;
 	int i = pdev->id;
 	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -418,7 +419,12 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
 
-	uart_add_one_port(&altera_jtaguart_driver, port);
+	ret = uart_add_one_port(&altera_jtaguart_driver, port);
+	if (ret) {
+		iounmap(port->membase);
+		port->membase = NULL;
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.51.0
