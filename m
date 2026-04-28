Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE545BD67;
	Tue, 28 Apr 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398879; cv=none; b=fJvfpmMLuFDmWK4Fiu1B49azd38pOYiQjPnwFDCB5MTBNcUn8xPoZiJOJIKS4Vd+EAYK9bMvVxErsZOD/3yjubKdvDcRebDgMUDesVD5DKnXN6sHeK6wX83+NzeCXOi/OLMKHga538BrZa2d6uqJs2SRtTkG8tA3UpulWiGY2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398879; c=relaxed/simple;
	bh=+V/mY1nW7HBDCQmc/EEhBi9nr7yaB2jSs9MoClG95eU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPcpM3sNm0FjwGCiVQlOu4/Mdtb+3nVeWS56sgrEZaMCvG1RGBJ0cwAQgybMn+fEsCnjjiTfDEC/FSrl7C1FV629Ul1H7E0oNODHhf3qYVcavk86fFIfzO9rziN0tz1vCQNkkCqIqX2XqWtwhCK5zJyK8OU3Q6yh+EHB+Seu1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=qKJiaAfO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="qKJiaAfO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=t4/xAFit2cI4F9RacEqfbIiOtR5Mf/htDi+ZgiNIm7Q=; b=qKJiaAfOXUY4aRNzsxS/cQhg0q
	UzI8nJRBuB5PXO5uSCbiZGWms0sjLWYJae6HpZUdqDyVv/J+vWOnihp2J9KU7CT+Vhzdm//bjc/fL
	0Fh/ygbGw74e9b63EgsKsKk+kZuBtn/oUUZ/5A226t6Xs3Zf/huactInLCeO3yYuZr08=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdj-000000004cz-1DzO;
	Tue, 28 Apr 2026 13:54:31 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:54 -0400
Subject: [PATCH v2 08/15] serial: earlycon: use uart_iotype_*() to simplify
 code
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-8-01c1857cf761@dimonoff.com>
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
to simplify and improve code readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Using uart_iotype_mmio() now includes the case for UPIO_TSI and UPIO_AU,
which fell before this patch in the else clause.
UPIO_TSI is no longer used by any driver, so not an issue.
UPIO_AU, if this is even possible for earlycon, falls into the "MMIO" category
in uart_line_info() and uart_report_port()...
---
 drivers/tty/serial/earlycon.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index ab9af37f6cda35ea2e3ea966fdac8ba5c4475cb2..e799feaa14bf1ac7c1a5677cd84490e7c486449b 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -75,19 +75,19 @@ static void __init earlycon_print_info(struct earlycon_device *device)
 {
 	struct console *earlycon = device->con;
 	struct uart_port *port = &device->port;
+	char address[64] = "";
 
-	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
-	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
-		pr_info("%s%d at MMIO%s %pa (options '%s')\n",
-			earlycon->name, earlycon->index,
-			(port->iotype == UPIO_MEM) ? "" :
-			(port->iotype == UPIO_MEM16) ? "16" :
-			(port->iotype == UPIO_MEM32) ? "32" : "32be",
-			&port->mapbase, device->options);
-	else
-		pr_info("%s%d at I/O port 0x%lx (options '%s')\n",
-			earlycon->name, earlycon->index,
-			port->iobase, device->options);
+	if (uart_iotype_mmio(port->iotype))
+		scnprintf(address, sizeof(address), " at MMIO%s %pa",
+			  (port->iotype == UPIO_MEM) ? "" :
+			  (port->iotype == UPIO_MEM16) ? "16" :
+			  (port->iotype == UPIO_MEM32) ? "32" : "32be",
+			  &port->mapbase);
+	else if (uart_iotype_legacy_io(port->iotype))
+		scnprintf(address, sizeof(address), " at I/O port 0x%lx", port->iobase);
+
+	pr_info("%s%d%s (options '%s')\n", earlycon->name, earlycon->index,
+		address, device->options);
 }
 
 static int __init parse_options(struct earlycon_device *device, char *options)

-- 
2.47.3

