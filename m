Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E9450902;
	Tue, 28 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398877; cv=none; b=VFEOOEH2RQkazUx5AZZ47CIDey8Wvep2Oj5Ui3rmxtS8K/wOj5QdyKF6oJUXxKKPxiUUYWmSXFFEIPRa2FQWruRRzKS7IHhs+a3SwLtKyx5kqkPbf2eXMK7mV4TXWqekrs3dF66UW1i2VqjAiz4ie1A6pjpG0NncZ7i0CnRLGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398877; c=relaxed/simple;
	bh=UxVMPpn7m+RcR50JAqBVm584prUuCO73GAPpglJe6zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmh5bo4hB0GrvlTT/1BJGpgR0cK4u0KZGeaZMABU5udrI7wntMRtR734bWB8ityRwK7ljCmllbR2XiKox7+7mzmL/7JcwOJNA6e8B+8cg9uaQew/YKOtCRGaJXidsrswtB+FM9YektsHrjfKl4O/0ek0ppJvf3Nw51MeqPprEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=EVzAIe/m; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="EVzAIe/m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=1izpAZ5eNLLl2K3v+q3EgZzclIA8uUqw9Q9Ay/LtyqU=; b=EVzAIe/moGUm4tTVFawWUXR/8U
	gDHSVdci/M5eHXHH5yIb2Pfyv3FiaQT9W6h2o2naK4IbHs8X2grmsdRq8Hj/PndYj+S4PH2vvHcUe
	Z6u0eZsEn6veJmD2vCPSb+mMx1dP6vKDuW1fBAwQMUn272wAi0htua9dnBujfuxny4Sw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdh-000000004cz-2HrH;
	Tue, 28 Apr 2026 13:54:29 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:50 -0400
Subject: [PATCH v2 04/15] serial: core: use uart_iotype_*() to simplify
 uart_line_info()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-4-01c1857cf761@dimonoff.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
In-Reply-To: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
to simplify and improve code readability. This will prevent displaying
irrelevant information for future IO types (ex: UPIO_BUS), while also
addressing the (eventually) invalid check for "iotype >= UPIO_MEM".

This also allows us to remove the confusing cast to (unsigned long long)
for iobase which is defined as an unsigned long, and use %pa to display the
mapbase pointer, as it is done in earlycon_print_info().

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
On 32-bit cpu:
  no changes.
On 64-bit cpu:
  # cat /proc/tty/driver/sci
  before
    serinfo:1.0 driver revision:
    0: uart:scif mmio:0x1004B800 irq:35 tx:11192 rx:37 RTS|CTS|DTR|DSR|CD
  after:
    serinfo:1.0 driver revision:
    0: uart:scif mmio:0x000000001004b800 irq:35 tx:11339 rx:35 RTS|CTS|DTR|DSR|CD
---
 drivers/tty/serial/serial_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 06a774f93652d65bc8e0f1ed912aa3e5c95e2bfa..c5ef2dd00a9c9ad57c4010c05daea34fd2053676 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2004,7 +2004,6 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 	struct uart_port *uport;
 	char stat_buf[32];
 	unsigned int status;
-	int mmio;
 
 	guard(mutex)(&port->mutex);
 
@@ -2012,13 +2011,14 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 	if (!uport)
 		return;
 
-	mmio = uport->iotype >= UPIO_MEM;
-	seq_printf(m, "%u: uart:%s %s%08llX irq:%u",
-			uport->line, uart_type(uport),
-			mmio ? "mmio:0x" : "port:",
-			mmio ? (unsigned long long)uport->mapbase
-			     : (unsigned long long)uport->iobase,
-			uport->irq);
+	seq_printf(m, "%u: uart:%s", uport->line, uart_type(uport));
+
+	if (uart_iotype_mmio(uport->iotype))
+		seq_printf(m, " mmio:%pa", &uport->mapbase);
+	else if (uart_iotype_legacy_io(uport->iotype))
+		seq_printf(m, " port:%08lX", uport->iobase);
+
+	seq_printf(m, " irq:%u", uport->irq);
 
 	if (uport->type == PORT_UNKNOWN) {
 		seq_putc(m, '\n');

-- 
2.47.3

