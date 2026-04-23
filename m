Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BF3290C4;
	Thu, 23 Apr 2026 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975317; cv=none; b=maAd437ugYnICOzmULoXnabce9joLeTvOGePm7rHqOqiC1zkdrEh+1Eaexisb+zol5hQe6U91s65QPxeSLGSxVKJwIADUgI2e9KB9SEWEmQh47EWKVveFoOhOb2iPHdqt+1+wQT4Ug1XwqC4xSgEqfuXfASR85k/+7KJrVRiE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975317; c=relaxed/simple;
	bh=Y74DWDxup2fUetjkoIZTSIDdiJvZQtTb11FRF1PciRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+MDo36PEbUAVy8Cjmy3eMKpC0XP1LyrhwPnHOTp4syb9E/xNCOvgRE3rV1xkjJ5WxDi7QeHGakBnhI4LAjCTi+4AP4pJk5mBaFg5Zpdp5+hCHzoy4tdYje7W3pgAUtDfv2O+XI1LwfjVHkqzxvaYA33dsUpATRr30BUf6Gzbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=inwWUj4z; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="inwWUj4z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=2wDVloyHkIiziVAMPkgP37/N8JFwAPIIdhpuh27nbB0=; b=inwWUj4z9zHKdcBQJjUSYvNcwY
	QiyXenE4trFgSyJghE0qvnspWRG35xRZIljnctrqcBk3AdmB/AkPm7nGSpt6WLXP36SELsJKpvWVk
	dUSc4tpvUjHgMLGRn3WgEX9RqGKionoxWKVY+yoIuMIEdhHW05J54/2uEVDQ3RPICSjo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S5-000000002qN-0xyP;
	Thu, 23 Apr 2026 16:15:09 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:04 -0400
Subject: [PATCH 4/9] serial: core: fix indentation/alignment
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-4-baf82d3b86d1@dimonoff.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
In-Reply-To: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fixes the following checkpatch warnings:
    CHECK: Alignment should match open parenthesis

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Without this, the next patch will have a checkpatch warning.
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index fc273f8f9e75de89dca1ac1aca3589567bcf8a18..cb5da344305e397b42f47bdbc2c053fc487ed784 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2507,10 +2507,10 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 	}
 
 	pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
-	       port->dev ? dev_name(port->dev) : "",
-	       port->dev ? ": " : "",
-	       port->name,
-	       address, port->irq, port->uartclk / 16, uart_type(port));
+		port->dev ? dev_name(port->dev) : "",
+		port->dev ? ": " : "",
+		port->name,
+		address, port->irq, port->uartclk / 16, uart_type(port));
 
 	/* The magic multiplier feature is a bit obscure, so report it too.  */
 	if (port->flags & UPF_MAGIC_MULTIPLIER)

-- 
2.47.3

