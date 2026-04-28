Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DD450904;
	Tue, 28 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398878; cv=none; b=cQRaKkyuCR0m5PPSjuIdjP36tKCh4GbfEBf7N3V58X+JArc+EdfW3tmfgnvbpxZCDyae4hlNnO+997KD36YwdROzvBbyf2opVlEW3V1OXb4mWff0r69X0XHYiI1Cmw5iel522ixcApru37LBNC6FLBHgski0Bbw69iyh5odWDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398878; c=relaxed/simple;
	bh=mSX+YMcMNc234FLBPQBYcbeIV/YtsjAT0oWvxdygpzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7wFWwoxGlwCLPZi+ks/R+ikQIMfzdU9eUPLxtUrNX429N9v6pfcGbFwq4hGMmdWAyM3weKqhIQF9II/B+eiu72Z76UsaQWbNTf4m8Sbt0fQp91AzN+UHAOEvciU3KE0PBVz5x7MOwegFA7YsBhZQ3dXKZJv288ER2N089t62xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Cwdx1TPK; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Cwdx1TPK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=ppfz3B+6vbs6lg6kmFok2Y5LS0XWmMCrAVuhcJ0eV5Y=; b=Cwdx1TPKDgVC58jFArlPCCsE0V
	JpiBvyritwhElbi8d+cMLd1t+c8WNvLsnRiijle2NQbpx4cWGnqyuSMz0edrK8Ts+sPeR4nvBiSQW
	GTO0oIerrTmXH0I+r0cZ/dSaC8vEyHQFinqNSUIGHvZAFn05v9gJCCxyflIvjdC4o9DA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdh-000000004cz-0bPG;
	Tue, 28 Apr 2026 13:54:29 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:49 -0400
Subject: [PATCH v2 03/15] serial: core: use uart_iotype_*() to simplify
 uart_match_port()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-3-01c1857cf761@dimonoff.com>
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
 drivers/tty/serial/serial_core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c177054f9515e1cb5a1e557c0dac096cb1cbd8cf..06a774f93652d65bc8e0f1ed912aa3e5c95e2bfa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3222,22 +3222,14 @@ bool uart_match_port(const struct uart_port *port1,
 {
 	if (port1->iotype != port2->iotype)
 		return false;
-
-	switch (port1->iotype) {
-	case UPIO_PORT:
+	else if (port1->iotype == UPIO_PORT)
 		return port1->iobase == port2->iobase;
-	case UPIO_HUB6:
+	else if (port1->iotype == UPIO_HUB6)
 		return hub6_match_port(port1, port2);
-	case UPIO_MEM:
-	case UPIO_MEM16:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_AU:
-	case UPIO_TSI:
+	else if (uart_iotype_mmio(port1->iotype))
 		return port1->mapbase == port2->mapbase;
-	default:
+	else
 		return false;
-	}
 }
 EXPORT_SYMBOL(uart_match_port);
 

-- 
2.47.3

