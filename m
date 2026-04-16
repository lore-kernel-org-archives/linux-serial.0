Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923F399351
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331790; cv=none; b=KdXk/9bVP3TJwU6arZcqPZ+N7A/6/XLEDeSYXu15DrjAL6QyNfxFMypOyeVBF/Cq8Vy/azHBwmpqp1t8glz3x7RbqRV1s7uwncxvQMUx7xax9tIOKiiu/+i3XDRMKRHpZETgD6FQsMEV8UKluv2xnnCfq71AqaNm4hvbdGII80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331790; c=relaxed/simple;
	bh=IN1c6EBVtDwVZ/i+Hsq84OXuF2BWcajy1Gk01ydTT3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EiSJ1uVgXrDkPf9UY2ttOiayBN8s09GLm8uboyKd5IHRWFTTpDKh+fwTuOsOw+eTX0esPobXW5mJJOuBO++lhqviv2T/7c9X05X3dVRzvh2g8guEq2M7Pu9il/F3lKSGd5N/iBuB2hnIBLVii92CSR2UWZFNrd2S4MEp4RmtJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxBZboNk; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxBZboNk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776331783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LvbGqp3piMlc8p/ePjRSqAyHONR2DqDhp9yAF1uUqrI=;
	b=gxBZboNkzdT8myaVFQi2LRtp58HEnJHb/uMLyRlU2UHeOVeZ7RySGIkZUZXKk1vOFcWKAI
	1mYzMjWHiNvI+hDZ57fXLxaO3aqVe8UzHRlPm/E3WgkcrzlTN9WKemkxfzQLxOH7/ppagI
	hbcYOgbj8PuWCKpPVY82dyQvcMynvTs=
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
Subject: [PATCH] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
Date: Thu, 16 Apr 2026 17:29:17 +0800
Message-Id: <20260416092917.27301-1-fushuai.wang@linux.dev>
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

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/tty/serial/8250/8250_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d2e2c5dfef99..3465a4d93b50 100644
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

