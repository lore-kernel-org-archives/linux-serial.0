Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABAB3D9DC7
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367064; cv=none; b=oqiYtpVAcxHIi91OcMgqUMJPp4qYwp2QWsabl4H4VAktLYYm2pCvtqtzGcZ99HI2HFNw4dLJH2s2oIFkD7ZOyV1CSCA3H6di7DwVSktR2fBAf/Z6O1EMGQUR3ln6vt3V4//T5OiSyyYtWg5yoH6D9U8iXyAMyzbdDnSzoaJrb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367064; c=relaxed/simple;
	bh=hvQOeOVC7EPibjtsdLgdgEyo4MCf/P3fweCx85yf0mA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WXP0DfTbAKnnig+OCCxcxt0W6g/SkA21Msbz8cdTauwvSt+OwMa2cBfrVKlYyF9WFvm1SY4zO6iB7nTmysv7EG1D3a7abnAJRXRLfiiQ+RiGx8xOxDBoHD9eRfQ0e3/vPGNfrS2O5A4vrqgf/S5apzKTzNUVDy0yKOxYOz7EXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jFlRsBBh; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jFlRsBBh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777367050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/qOHDxjboZ5ndtg/n9XZ4IBSqZRJ44vTxZ3wqyQcTlg=;
	b=jFlRsBBh/Pam73wBw10KnhNZckCUlW91F6sqotsGUVHdBCS6qSH3wiLi9hEjXeyIYau9/w
	HnkzLapHnben93/5k3marios9/v8H7uBsXA2QqbMvb2eb3Lk93TKIlTBmd9PEy5KIiGqxS
	t2tReDadGARxmhsP10vVJyqZQdC97ds=
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
Date: Tue, 28 Apr 2026 17:03:49 +0800
Message-Id: <20260428090349.30047-1-fushuai.wang@linux.dev>
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
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
V1->V2: Add Fixes tag
previous discussion: https://lore.kernel.org/all/20260416092917.27301-1-fushuai.wang@linux.dev/T/#u

Please ignore previous email if you received it before. There is something wrong with my email client.

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

