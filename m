Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81B32AABC;
	Tue, 28 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398877; cv=none; b=CM5ImWCia7wQPATSHYstnWqSGh89qmH8AeLNus1Z9Zf0gXwzAyqxHmG2C7u0CNgWsy0o+UhjLT51rbVRG0U0fSSMfR191lJS15oRKcE2ZpHLERe2KE0ZUrWy3fmwG0NTPyzTS+qu32mwCLFDSy77qxsz/5x0cCF0VAvULXrkYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398877; c=relaxed/simple;
	bh=Iut/Jt4Q4CrQ/X0ofuQRrVed6i8XkZo3LdnY6PMmjNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tD4VmNABxejnTx6WHyh7Z4ixHnB6uRC93gY99yOd1H5rc4kiANVGJ0CflKK7p0UG/HyhfHuVtxaJ28D/XzF32fzVz5bmESENieBeEJnYJUsnVl3AZT7aLqID8m0DBP143+/t0b0t0hKNzeNkUMYUdFkrqj5fESZBfXwu3qXqm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=mBqFYX+M; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mBqFYX+M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=LDAG2CLo+vvi235SDH0ibljwB66+qJO9KRi9UYV+e80=; b=mBqFYX+MiSHtOV0mwvT6TaoRU7
	4a+U/1BoP8tQTdH+WDFp/vBukw4DDfopzC/b4hth0JQ+z2km5Q1QmT60NJWhpMEiT+/mo8UKKBMPr
	7t3zRiZxY/ovrzLsMV/d6obOn7APCZMzTxY1ZWwN/yAdUAEjTzu/z7Pq0oEiI1Gq4VEQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdh-000000004cz-3z2C;
	Tue, 28 Apr 2026 13:54:29 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:51 -0400
Subject: [PATCH v2 05/15] serial: core: replace snprintf with more robust
 scnprintf
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-tty-upio-v2-5-01c1857cf761@dimonoff.com>
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

Use scnprintf() so we could perhaps one day get rid of snprintf() entirely.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c5ef2dd00a9c9ad57c4010c05daea34fd2053676..3c909b8a82135a6245e98a9ae6bb050fc32590cc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2487,11 +2487,11 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 
 	switch (port->iotype) {
 	case UPIO_PORT:
-		snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
+		scnprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
 		break;
 	case UPIO_HUB6:
-		snprintf(address, sizeof(address),
-			 "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
+		scnprintf(address, sizeof(address),
+			  "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
 		break;
 	case UPIO_MEM:
 	case UPIO_MEM16:
@@ -2499,8 +2499,8 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 	case UPIO_MEM32BE:
 	case UPIO_AU:
 	case UPIO_TSI:
-		snprintf(address, sizeof(address),
-			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
+		scnprintf(address, sizeof(address),
+			  "MMIO 0x%llx", (unsigned long long)port->mapbase);
 		break;
 	default:
 		strscpy(address, "*unknown*", sizeof(address));

-- 
2.47.3

