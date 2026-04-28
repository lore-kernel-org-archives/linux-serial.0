Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3145104C;
	Tue, 28 Apr 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398878; cv=none; b=jId/m7e2IJQsCkeU+nH8tcB9D/imA2I0Vs+BhfG5+y0FEjDxLI7x/oTfD0ZjQGaEMzaJIP1FnyE6r8Jzb82TtJDlisntYItCSAiDIXmoKUjUV3j24k9dvRSnqSOG2sAjRzO3O+IGTpNlSuvspsgqO/I3TXcIS/AygSPk+zva54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398878; c=relaxed/simple;
	bh=bi0Piu0ervyfZdqbZSg8KN9t7BUiwhRV40djFdqlRtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNkA4tN7SfnMWJ16sjyjzzM1a7ykHBhvRVyM4sY2CWW/Zz4d4d+sOW/2GnY6gD9lALZgeyWPwbtZ/C+ZOspZK0gfAFCuneZ15R1Pk+Uujane59+l/zPsBZzmsfZ+edk6pCV98rPcLTD5PkE7TrFgD5pLrF+cGFIrtdHuq8Pd0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=hgd4W2+b; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="hgd4W2+b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=g3mtZQJHziRkotRRHZ7P8tdIbi9wvg4N62GgZGSBbCs=; b=hgd4W2+bpYNvE32oRA/AFLaitW
	bQuADkoqBh8v7j8QfWYi7wANT7VeBA9h47s/0rvqMLdaFa4O9OdNHcjI+JdwZdcAXWv9cmyGy1AxB
	iatqEfHHqjG+vkaJVSXQ44wCCu2WliRAFWqktxe7xsqyBN/Ytw8OOTZ/133eEJmSm+p8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdi-000000004cz-1LB9;
	Tue, 28 Apr 2026 13:54:30 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:52 -0400
Subject: [PATCH v2 06/15] serial: core: fix indentation/alignment
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-6-01c1857cf761@dimonoff.com>
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

Fixes the following checkpatch warnings:
    CHECK: Alignment should match open parenthesis

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Without this, the next patch will have a checkpatch warning.
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3c909b8a82135a6245e98a9ae6bb050fc32590cc..e9986f9221f946c9075a8eea7ac28d2ad818f095 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2508,10 +2508,10 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
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

