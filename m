Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388492BDC32;
	Thu, 21 May 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387423; cv=none; b=Hoj7jkWd6C7PJ5gox4cVMXFu2xUdQGb0jEmZ/aMEZTkRL71tFttxDVD1j/AkuC8bCeGTc7Tao8i2MOcMtkM8BD4Enk5OonhT+520j1cAiV5FZFh0bLk5ZhU45mMihusjcl9mTLbuKfhGA7moPJLHs+3+Ia9xMu4H36Cgd3Hci1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387423; c=relaxed/simple;
	bh=BicLH3tRDoF3lP1EsTOBfbU4fR8vqDcLMqFrMwxShIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbgY6Hdc9YsCY8b8hsYGdfSgXUUvGKm5dociF2FheEglJJJ8cnzjWouGSOg0qUjHpqakIVJTOxK8jQzntaRL79B3+ffLZ0IzI2kk81AkHekRbONvVmoWaJwYYt7MUlDJB2l4gJVbNnOHc/+PVf+ob4aCN7WpaEjL62AA+hQ1/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GvHi+fsi; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GvHi+fsi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=UAamvI1WETGVqN/7G2tuRMQVVb8w1fmlJAQkHLmZN9Y=; b=GvHi+fsiNwri3BkB5QfM3KG+6/
	Y3zQNrCvTY6rCjMmcuJ1bx5i2ImCZlPrt6oNIhtCUWHE2tjoIGMnWoyXd6sZZolNyLXAK0wuGTBnM
	BUNkTjC4Jq2NKrRDW5CWdSOTibmV/GRJ9j43aetXWsYvK1tWrVMjdrhWlZhnMwc06Yyg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x4-000000001yA-3cs1;
	Thu, 21 May 2026 14:16:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:48 -0400
Subject: [PATCH v3 02/10] serial: core: add uart_iotype_mmio/io helper
 functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-2-bf74567994a0@dimonoff.com>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
In-Reply-To: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
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
index 05bebf666a5d5ce66a05181c69db48e7355fec42..7a29f17814641f085b37e9b9cc5227e2a249aaa9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1963,6 +1963,34 @@ static const char *uart_type(struct uart_port *port)
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
+bool uart_iotype_io(enum uart_iotype iotype)
+{
+	switch (iotype) {
+	case UPIO_PORT:
+	case UPIO_HUB6:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(uart_iotype_io);
+
 #ifdef CONFIG_PROC_FS
 
 static void uart_line_info(struct seq_file *m, struct uart_state *state)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4f7bbdd90017602ba72b8a67e077922feeec95da..a06da6b24c1ad48afffa1e355377992aec0debff 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1318,4 +1318,8 @@ static inline int uart_handle_break(struct uart_port *port)
 					 !((cflag) & CLOCAL))
 
 int uart_get_rs485_mode(struct uart_port *port);
+
+bool uart_iotype_mmio(enum uart_iotype iotype);
+bool uart_iotype_io(enum uart_iotype iotype);
+
 #endif /* LINUX_SERIAL_CORE_H */

-- 
2.47.3

