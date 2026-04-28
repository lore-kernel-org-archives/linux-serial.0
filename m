Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E36284B4F;
	Tue, 28 Apr 2026 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366748; cv=none; b=Zzf+A2IuSsZ86HT/hF/f6Y9Hb0YCZKDoJAT8r+rbbDqMYq2+j8SHWe0tk8qaWUyYK+rYKxeXcpmDQQ3fh4culACg25VpG3TjKwg6+M/UhTC8BKC+LIdCyK01P+JNOFg3kIrifhiv9eRTIDmcC9z90lGwwztZsx8o+MIqqaiSb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366748; c=relaxed/simple;
	bh=GvSbeIo1GLoXSrs7LYH3Ez+xdd3fSvzsDo37/3p7giI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uDu3oRVXg4imBKQo+QakV7jTn4qxdimIsOhM8zocJ/mJb0zMffTjTANdrFcZXkOFWhSPFiuRNL9ss3pNdAJXuRGX2RNv2jgWaXKH1JJbMudlQELuoOOiEsiVgADpSRJrOdwq6Lx2L/+9QgReQnhSgLe4K8a310+jLtjNbX7Jijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fN002VHC; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fN002VHC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777366745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GfJjv6EQVp+OJ+NEPUE04dlrcq8ebEoqH+XVP3fF9Tw=;
	b=fN002VHCpRtVzV1KB/UqxpiXhpS02oYJuZXPlsQ6awbO4QKsoCNGIk9AR7IyKXthlw3gFO
	zOmEwKUkDeMG2IX5AyKJBgIFVbRDhll8547Lfad5keU2JJOP67sex2UiyHxpzklN4Ux2lN
	csSTejNMjCivMJPkGRMYwJnPaDNOhXo=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	osama.abdelkader@gmail.com,
	andy.shevchenko@gmail.com,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH v2] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
Date: Tue, 28 Apr 2026 16:58:36 +0800
Message-Id: <20260428085836.29576-1-fushuai.wang@linux.dev>
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

Fixes:
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
V1->V2: Add Fixes tag
previous discussion: https://lore.kernel.org/all/20260416092917.27301-1-fushuai.wang@linux.dev/T/#u

 drivers/tty/serial/8250/8250_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb..01b14392d9f7 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -694,6 +694,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
 	int ret;
+	bool was_removed = false;
 
 	if (up->port.uartclk == 0)
 		return -EINVAL;
@@ -716,8 +717,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (uart->port.type == PORT_8250_CIR)
 		return -ENODEV;
 
-	if (uart->port.dev)
+	if (uart->port.dev) {
 		uart_remove_one_port(&serial8250_reg, &uart->port);
+		was_removed = true;
+	}
 
 	uart->port.ctrl_id	= up->port.ctrl_id;
 	uart->port.port_id	= up->port.port_id;
@@ -819,6 +822,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 					&uart->capabilities);
 
 		serial8250_apply_quirks(uart);
+
+		if (was_removed && uart_console(&uart->port))
+			uart->port.cons->flags &= ~CON_PRINTBUFFER;
+
 		ret = uart_add_one_port(&serial8250_reg,
 					&uart->port);
 		if (ret)
-- 
2.36.1

