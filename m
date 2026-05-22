Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D53C76A1
	for <linux-serial@vger.kernel.org>; Fri, 22 May 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444706; cv=none; b=ONlQ0o5TDDtwBDsijxcNqlOtKG5eVjs58gMattIiWNTIhOW3x2NyzStLPaSQf9HXZO1DgSoMaNCIJPGJ7bBu+fkK9y7tS4QKq8ZD2/9keWU/hywT7BGbiZE4FFrMueGKNBKUB3MlgMISe0bG3KEYAMdSspYURTyMzz79+KHywaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444706; c=relaxed/simple;
	bh=hAUOTYYF2qflRHSX1eXQBgemUvoaD5gB7ZQ5XP637tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNkhXmr0I1jXnOVboXJe9ICL40ppYLkjXTQJ+aHsNPq4zA8Jl5bMC7w84NNGpTb7qYvvB6HdQcOIsBPpy21lzuww+Ox1d9/+u1bfMWpsMgR4Q6LPY5MiJm4Bb/Ls42Ns4Ps2R0r6aMlns8km6QxLuL45GqGgSy6zhJQGM6gbsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wDGZi3Em; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wDGZi3Em"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779444692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lpkuygLNHaOjLCNnLzzQ1qT5MhYOdC42n0Q9Eo6AsCI=;
	b=wDGZi3EmmsX3sOVnMZIzETiZgmIV0FalADMsc5UM6Mq5/QiVzb7aPObp7aXlxUArNvYG+N
	pQ4xgtDCgLaD2AH1x7C1l63eEDf68Pi1es7O9uniOBwbyuejdz4jEHNPsSEuy6qVtpJdBC
	CdqGU8nyVZdGQg3xdLYunB3K4i6Twd0=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	osama.abdelkader@gmail.com,
	andy.shevchenko@gmail.com,
	jackzxcui1989@163.com,
	kees@kernel.org,
	sean@mess.org,
	alan@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH v3] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
Date: Fri, 22 May 2026 18:10:42 +0800
Message-Id: <20260522101042.21976-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

When two PnP devices map to the same physical port, the serial8250 driver
removes and re-registers the console structure for the same port.

During re-registration, the console structure still has CON_PRINTBUFFER set
from the initial registration, which causes console_init_seq() to set
console->seq to syslog_seq. This results in re-printing the entire
system log buffer, which may lead to RCU stall on slow serial consoles.

Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
log printing.

Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
V2->V3: Clear CON_PRINTBUFFER when remove the port
V1->V2: Add Fixes tag

 drivers/tty/serial/8250/8250_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb..5419f1d22d47 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -716,8 +716,12 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (uart->port.type == PORT_8250_CIR)
 		return -ENODEV;
 
-	if (uart->port.dev)
+	if (uart->port.dev) {
+		if (uart_console(&uart->port))
+			uart->port.cons->flags &= ~CON_PRINTBUFFER;
+
 		uart_remove_one_port(&serial8250_reg, &uart->port);
+	}
 
 	uart->port.ctrl_id	= up->port.ctrl_id;
 	uart->port.port_id	= up->port.port_id;
-- 
2.36.1

