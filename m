Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFC28D83A
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403919; cv=none; b=e0F+fke2IxNcXViuJ/8xydeRpIC3jkz1K7nXRwqMCHntlhUDQJBfeys3m1usikczHYtoV4rPebwWw4p/kbDU9BLWA5S7CX9dGQHVfjr4K+iOBDv314X7rxhNWg0MuiRldEVMkzZ9FvpHvVsSPXwWDIE0hUqKDpx93PHgv5rBLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403919; c=relaxed/simple;
	bh=35gorawSDcrg8QbS+s+M/Qi8sq0tSP1dR9KzDN+4gxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwv8RPNNzZQs2GIG9FlgeXOr8F1eER0+f6IYmLVlwhH/VoVZFezmyFE+1JpFuoapXffi5et0svbXiUc8jUQuF5GzHVAp4ZGPx5mEdFupo4N+aE3kzmBzfdgy+qohtoti6ytYK3L7y16ThTXDLr68Q9ttRrz/kYjuogjWahXs3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eDwCSKKl; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eDwCSKKl"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85d9a87660fso205313539f.1
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744403916; x=1745008716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0009F5O9wljpHFhP0qBedRkQq+IjHXl/vgFyYcghGBI=;
        b=eDwCSKKl/5z8nIEBA/pV1BfH8SeYUk3ObUlKL4xujOgbaJRP9qho0RlaXicddqh+GQ
         5vxEDS4ErnL5gXD957jHRgN8BP+Y4GqAWb2iAFYenhL4IO4nDSbHJqSMVvcBAzZFjROE
         fArPH4wS8xz/TZcU80V02Nrb7myqz+b2roQ1Na3HFIFwjC7NIzVc6S888rfccQWA7uI0
         VNuHmmRemuUysfFQjq9TE7ebzWE+Ye9NO5pcWX7QbZD4WFNz2U1mBinx6Ti1UBqzZkzu
         sMQmKpTdzpkp1sjjv90/0iso8M4pDKn6I/+AjGJ+4yp4dJYKpqkfviz9gZK0TEjcOrRl
         L+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403916; x=1745008716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0009F5O9wljpHFhP0qBedRkQq+IjHXl/vgFyYcghGBI=;
        b=k72nmUwdvANjQWYnMuTFLXg6j5jT1Mamx6JntmmjrSsptHwk4gwXViA1YdpfaWKjxw
         jFrY9s20zM4vTkRYJI1/KE8Sf0WUfwDM3qfAHkIO89FggVDavC5h0OVxgafweAlO3eEX
         /bMz07bB1xYqVdWVh8fsiO5mHQOOKuekXYqJtBvhvx5e1kJe29fPJNuzbcvcG8p7Mwhf
         ptCelnzSAlp4Eq5xzRpnhOUUZFlUE4NVG3IyklWsoG+stevriDmRjmwCMQcrINVfOARK
         M/ZqaWgj+7HZ22NgiRH1Tw2EqEJR+o21EU/PiGsxUsiSfpwj4rkaIoDgXG0E9JLvSq5Q
         xWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3eYmdI1AxOkdyLbRQCiRqAMOJaXR2g+X1xvbrHr1QnN252IPNAPHJx2bwrQ/iFgMkcbZDlvyRFhvuqxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiUQZbLpalmeUodc4HIsYYIwN92H+/axPRuP5uBSmpf5XoYcY
	aObRdoZ0x/5l++saKVmSDxK01GizHKw8AuFGu9ePRfQuAOYm3xA3037Po/5LmHA=
X-Gm-Gg: ASbGnctFn0ZgAyFsHRQNH0Xnf9x6Otn014Kjw4Z9TXLegQlIZyXuaa2xBp9LCCmPTGN
	3C4ApQw/pRpwGTXh3+4e9wzE+qfhEqWH3toSaWwut5LXgeB3TpNRTyp0Xmys0nN7CwoQla08agb
	FuvUNZBrCo8JAP++VYmFTD3AbeqtFvr8IgjnPXUsOG1K/VyV+/oZZv01BjnkIwb248YxvUHtLtv
	fSI59S619bZ0HOfVY6hSY6THqQ33iStaros83OVQfl1yyIEiSfbezmDFbSodbdOS3oXT9r71610
	91CVe9yHNJmFD6Y24ZNa9C+aMSmSD59kWW5if69yvP3eZOq1oUmBMLYj6SjvUE2W/tSE2kFhM9A
	8ylsvUYvS0kp4fA==
X-Google-Smtp-Source: AGHT+IGqHP+A8bUdxXLeOSya2xG9dcuQXpXzTMzOhzOj4n3d6/OcbE382cLJQUug9NIF/T7vU4ELFw==
X-Received: by 2002:a05:6602:4816:b0:85b:35ef:b1fb with SMTP id ca18e2360f4ac-8617cb63bb2mr542148039f.2.1744403916511;
        Fri, 11 Apr 2025 13:38:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2ea1esm1420787173.123.2025.04.11.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:38:36 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andy.shevchenko@gmail.com,
	dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] serial: 8250_of: manage bus clock in suspend/resume
Date: Fri, 11 Apr 2025 15:38:27 -0500
Message-ID: <20250411203828.1491595-4-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250411203828.1491595-1-elder@riscstar.com>
References: <20250411203828.1491595-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the bus clock pointer in the of_serial_info structure, and use
that to disable the bus clock on suspend and re-enable it on resume.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/tty/serial/8250/8250_of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index a90a5462aa72a..d178b6c54ea18 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -24,6 +24,7 @@
 
 struct of_serial_info {
 	struct clk *clk;
+	struct clk *bus_clk;
 	struct reset_control *rst;
 	int type;
 	int line;
@@ -138,6 +139,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			goto err_pmruntime;
 		}
 
+		info->bus_clk = bus_clk;
 		port->uartclk = clk_get_rate(info->clk);
 	}
 	/* If current-speed was set, then try not to change it. */
@@ -299,6 +301,7 @@ static int of_serial_suspend(struct device *dev)
 	if (!uart_console(port) || console_suspend_enabled) {
 		pm_runtime_put_sync(dev);
 		clk_disable_unprepare(info->clk);
+		clk_disable_unprepare(info->bus_clk);
 	}
 	return 0;
 }
@@ -311,6 +314,7 @@ static int of_serial_resume(struct device *dev)
 
 	if (!uart_console(port) || console_suspend_enabled) {
 		pm_runtime_get_sync(dev);
+		clk_prepare_enable(info->bus_clk);
 		clk_prepare_enable(info->clk);
 	}
 
-- 
2.45.2

