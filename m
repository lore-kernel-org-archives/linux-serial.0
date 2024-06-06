Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E98745C2
	for <linux-serial@vger.kernel.org>; Thu,  6 Jun 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703920; cv=none; b=bmPm8f6wcECYUhxca8Lj2H8Ju7Jpdd/ygelYx7UlKP3I6c5beufB3W9tQ58WJHPK4aOnb6psCemLimZPp7kRjS05RZ5IPaSTW8qbkycLpRiXYIauoYXgTotLOWNuZ8ChWOfOa+Zull1AJoICuHU9JbbL/QbjSArwzlItj8PumUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703920; c=relaxed/simple;
	bh=om/tUMkX6OS8Ao+4R6UxrpZYLDopfROa6xD3DiyiTRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7ItHG09RzYlefl0Q5e38uYw+vNIVYj3mC97bxKCC8s2oZ1LmhhYgcjPhfCGeQHWYGJ/znrZ/LhuotlWrhKbHhU2h11MIlUnRlh+N9etDn/1CDWcgGPgdiTK5MOXbV7TRTWzKTzV0eSUOjEjCVEMC7GkohZNtoKG/GnF+VHF8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=gXJ5OlJt; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="gXJ5OlJt"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6818d68f852so165132a12.0
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2024 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717703918; x=1718308718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1O9YIWaISmK5NIxJKMIlNcYeBFnqMM13+G/DI3fqzw=;
        b=gXJ5OlJtgwKM0MiLtg3J0Etg9R5xTUpbPCr0WEqFvA23NN/ItVYXsXfM/mKC6hsYpb
         aePVa6nRXZdA9JBb6mbZGjzuEIabCHk7GUG5PK1qq7Bz6FBwEqXTDx0mAIVY6j/Xdfza
         XfIAoYt6Ob934aA/XRWx0GxBU+K9xrn8fyung=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703918; x=1718308718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1O9YIWaISmK5NIxJKMIlNcYeBFnqMM13+G/DI3fqzw=;
        b=kQddNYPfu4R05mvzPYxx3qywc0nkml8BAGetMKfAtJFzvvPAXfhM8N1M/GQHQL5KzY
         xCUIytBG8b61QTNfzXT/3kW2hnKoHmynfV+IOEQ133cH3auEueM7c7sRo9O0NDJoeJzG
         zLMCUk5C/zAprSu0zMk22gJJg9xNkuvUsuDvQSG8dyZdGqfBmj/nTAfJ0DIZgQRkFmcB
         f1XBIpmSAwib2+MiA8j6i/+EZV6vVw0zx13z3ov6JIZOA07c+InBgZuj0kkM2zUzcIQh
         2Vh8eGtp+3nsJduEDlxdopTDPI6pNd5Z/CfniMrVHP7ovzT/e8l5pQOYeNEV7lHV7xJT
         FAjg==
X-Forwarded-Encrypted: i=1; AJvYcCVZt1/u2diIs4nrtNPmKWOzK/c5vx0h2qKN3h5HFMzLA6MKs4Sqa4TS272EcX56Kvd+KZ5kdYaOA2r7IKnFA3Qos9rWg2X8E5qTebMd
X-Gm-Message-State: AOJu0YyQheveBP/LjVnV0XdP7pIg0f/VFxCGIi2x6mKAEoaRBP9YZQqf
	Ao0sSAfMdNGEUkLySg+/2xDiYAhaOa3uvYSA4D4OhAnaPQsEw7JQRPeyjmFjB8HahRMUXZp7J8M
	eOOez3A==
X-Google-Smtp-Source: AGHT+IFZAvRK9sCokOpd775+K7Vnh3U8s1WAuk5KbQdzYOD2AqYp6+WQBgnCrhT26V0ykIG4QPYGRw==
X-Received: by 2002:a05:6a20:6a23:b0:1af:a4a5:a26a with SMTP id adf61e73a8af0-1b2f96945c5mr703169637.1.1717703917778;
        Thu, 06 Jun 2024 12:58:37 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394f20sm1446787b3a.55.2024.06.06.12.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:58:37 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 3/3] serial: bcm63xx-uart: fix tx after conversion to uart_port_tx_limited()
Date: Thu,  6 Jun 2024 12:56:33 -0700
Message-Id: <20240606195632.173255-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606195632.173255-1-doug@schmorgal.com>
References: <20240606195632.173255-1-doug@schmorgal.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Gorski <jonas.gorski@gmail.com>

When bcm63xx-uart was converted to uart_port_tx_limited(), it implicitly
added a call to stop_tx(). This causes garbage to be put out on the
serial console. To fix this, pass UART_TX_NOSTOP in flags, and manually
call stop_tx() ourselves analogue to how a similar issue was fixed in
commit 7be50f2e8f20 ("serial: mxs-auart: fix tx").

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 34801a6f300b..b88cc28c94e3 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -308,8 +308,8 @@ static void bcm_uart_do_tx(struct uart_port *port)
 
 	val = bcm_uart_readl(port, UART_MCTL_REG);
 	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
-
-	pending = uart_port_tx_limited(port, ch, port->fifosize - val,
+	pending = uart_port_tx_limited_flags(port, ch, UART_TX_NOSTOP,
+		port->fifosize - val,
 		true,
 		bcm_uart_writel(port, ch, UART_FIFO_REG),
 		({}));
@@ -320,6 +320,9 @@ static void bcm_uart_do_tx(struct uart_port *port)
 	val = bcm_uart_readl(port, UART_IR_REG);
 	val &= ~UART_TX_INT_MASK;
 	bcm_uart_writel(port, val, UART_IR_REG);
+
+	if (uart_tx_stopped(port))
+		bcm_uart_stop_tx(port);
 }
 
 /*
-- 
2.34.1

