Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124144DB6D;
	Tue, 28 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398879; cv=none; b=AquujrWSwxX6bdAOAWX8kEgx8vo8OvRB69aKc53DsOo5X6u3OzSCAsU0qkN1LyqmRa1inKmDPLGg6s6f92t/zDtCkdqYTD8cDCqEI1ErJfUACX9zOdUSYcFIbTUZyArUwef6RfAZKKw+hkUrHngtJWgMGw1OmAwFkhtlpudEf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398879; c=relaxed/simple;
	bh=CeIiTqoZcxa2tOkKe32jvVCAACcagbzwysrTsxrN/ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egZw+AyqY+hocm6VffkKmuL89rm7svGyacSfzaVxEe47glf+PFrtNdyvrw19+TIr16L0omeFif760HwCZpWERmzi/fj0UYJtzXOUDTOT2Ed3S2FCYAehzuK9Qstukid7WSlI5zLv9u82xoyb1uXnFnyieXJMDWRFf+ofnAeja7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=OYiT6cSU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="OYiT6cSU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=E9JpJuDQgSm0emq6f6ms1gLWl5NexXzvKruVtR1yZkM=; b=OYiT6cSUnTm9sTuC6XWzrcua2l
	ktFVPIRRvH05cRFkBTyC79s8C5soTIRyC2HLy1z9fr1kXGxiWX8cs4sRjjrZ+WKvBDAFN+4h9QmO6
	awM7pfhJzuD8fVDIsEw1NJYhLyaigbJaiEIylps1whVyPmRzrd1ITvD5xAIya12Ixcdg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdg-000000004cz-2RMF;
	Tue, 28 Apr 2026 13:54:28 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:48 -0400
Subject: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
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

To help simplify code that check on the io type mode of the port.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Will also be used by future commit that add UPIO_BUS.
---
 drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++++++++++++
 include/linux/serial_core.h      |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7354f8af4853d34e5e819c2887f287970c653b69..c177054f9515e1cb5a1e557c0dac096cb1cbd8cf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1967,6 +1967,34 @@ static const char *uart_type(struct uart_port *port)
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

