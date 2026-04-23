Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183C3290C8;
	Thu, 23 Apr 2026 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975318; cv=none; b=JQiU3lSVs0FXjomUYJQLbf9zbprNqLFDjxTGYxNyu5HjoWWVzkjATk5+XbfMh/TPqjpgUFruZaBVAN4dK7RGKms28SVM2awkzI6bYEt4/7KcpCboBBbZ3UoN6xhSWmpBmpfva+AlZtb3QaJSaH53Xn7BTkUZONkMrwpIQ+vaC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975318; c=relaxed/simple;
	bh=V9uB+lAm3bpYHewGHiNGVsh8TBUikeNMKj4L/U2vLiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRKR8IQX4hFrO5Hgg3rg+hz/48IRN1+hX0t17IucekcvYl1MxQcMSO2faH0Ljvpwsui34tW6N/GSmd2m7Astg+rEIeFb7K4lj0HK7tmN3GI5PePXxLqX+9i0i2/U6luL4CIkrdPkVWpLVpCZQ8daefmiV9nK+6T1AOxxi0tSNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=dq6KyReJ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="dq6KyReJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=AWdqm/qQhOGbJHPukefNOG+2wE25q4mEpmJr32atPhA=; b=dq6KyReJ3/4aOhUcPYKWEQU06O
	dhhRU3aurDKmAWNMsBpwX97qa1I1IICV7ezgR/QpjelqPZGQfq7yocy4kQRsOpWKriYglMpNUzs/l
	IZIXkl168VXZmomH3Ce/ebdvPXStVb2pCyy7Kx/2UgDsPcZiNjnm8tDybR51N8/qDJs0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S3-000000002qN-3mNN;
	Thu, 23 Apr 2026 16:15:07 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:01 -0400
Subject: [PATCH 1/9] serial: core: add uart_iotype_mmio/legacy_io helper
 functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-1-baf82d3b86d1@dimonoff.com>
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

To help simplify code that check on the io type mode of the port.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Will also be used by future commit that add UPIO_BUS.
---
 drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++++++++++++
 include/linux/serial_core.h      |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 89cebdd278410a5a97f3f5ee1b9c171715145067..b1cf45a8fc854cd97e349ff077d83b42e3ef8b16 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1966,6 +1966,34 @@ static const char *uart_type(struct uart_port *port)
 	return str;
 }
 
+bool uart_iotype_mmio(enum uart_iotype iotype)
+{
+	switch (iotype) {
+	case UPIO_MEM:
+	case UPIO_MEM32:
+	case UPIO_AU:
+	case UPIO_TSI:
+	case UPIO_MEM32BE:
+	case UPIO_MEM16:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(uart_iotype_mmio);
+
+bool uart_iotype_legacy_io(enum uart_iotype iotype)
+{
+	switch (iotype) {
+	case UPIO_PORT:
+	case UPIO_HUB6:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(uart_iotype_legacy_io);
+
 #ifdef CONFIG_PROC_FS
 
 static void uart_line_info(struct seq_file *m, struct uart_state *state)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 666430b4789977ae19641442b369eb1c773233f4..fc3f5ebe389658c197ffc105ce4ac11cacef59bb 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1306,4 +1306,8 @@ static inline int uart_handle_break(struct uart_port *port)
 					 !((cflag) & CLOCAL))
 
 int uart_get_rs485_mode(struct uart_port *port);
+
+bool uart_iotype_mmio(enum uart_iotype iotype);
+bool uart_iotype_legacy_io(enum uart_iotype iotype);
+
 #endif /* LINUX_SERIAL_CORE_H */

-- 
2.47.3

