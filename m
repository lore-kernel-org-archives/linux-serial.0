Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0E318B9C;
	Fri, 17 Apr 2026 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454569; cv=none; b=EBD3yll9CtIUFKusBXbfcPOmvUrUe01BryfPBGj/IVLqbVcWgNgbvoSbG57Lrt11YiPA/7x+YF7BIetG6FYu8H/TI2IFtO9l1Ic0OLJADslSINVuMY9lzX+OxOtLlPZybFjKSIWaCvtVtZV0OJjb+yEsIlf36VlHaUVnfzj93ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454569; c=relaxed/simple;
	bh=Nkc+WtzqP+qwBSkUQ9i7RjFNWcSScuLdgFfzSGX1A7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkGq+w3S1+50dSuhI4AJUu1E57NoQCfKBxHtfNZuQ/GZwzGWoPnTOcQJ3yxfaEMsSBvsJF/FrloJpj1FOYAU9Yvoqva7MCUtmYOeeUkF9KWElRSq3nJnxYc+AuIAPIUQMPDoCbeHD3qSCsx2UhCzjmnDjTcKTAnP/wpk378B7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=s3wY95K8; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="s3wY95K8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=cj7zujtWRlaJ0brJtF2kD3jjGdPCtEYrUx99z7MjByc=; b=s3wY95K8+4XsHtpwzoVNA9flFw
	x22RpjWoN5xkOfynmrM3fF9y7d7SyINaJXiLW96EYhE0Nhnf/BAeKFELUqJ1r/6RpmUvOf1ZxO9FE
	CfOst45HwF9mMLE8dSdX29kFO98oqNOp0YoumK/nBB5HKcln0XfcK0ItFf2alO8zMrFU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDoyz-000000006sv-0xgF;
	Fri, 17 Apr 2026 15:36:05 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	biju.das.jz@bp.renesas.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: sh-sci: optimize max_freq determination
Date: Fri, 17 Apr 2026 15:35:39 -0400
Message-ID: <20260417193603.3906568-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Follow example of rsci driver to avoid code duplication and useless
max_freq search when port->uartclk is set to zero.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Cc: biju.das.jz@bp.renesas.com

Biju: if you want, feel free to pickup this patch when you resubmit your
serie for "sh-sci/rsci: Fix divide by zero and clean up baud rate logic".
---
 drivers/tty/serial/sh-sci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6c819b6b24258..dcee8b69adab2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * setup the baud rate generator hardware for us already.
 	 */
 	if (!port->uartclk) {
-		baud = uart_get_baud_rate(port, termios, old, 0, 115200);
-		goto done;
+		max_freq = 115200;
+	} else {
+		for (i = 0; i < SCI_NUM_CLKS; i++)
+			max_freq = max(max_freq, s->clk_rates[i]);
+
+		max_freq /= min_sr(s);
 	}
 
-	for (i = 0; i < SCI_NUM_CLKS; i++)
-		max_freq = max(max_freq, s->clk_rates[i]);
-
-	baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
+	baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
 	if (!baud)
 		goto done;
 

base-commit: a1a81aef99e853dec84241d701fbf587d713eb5b
-- 
2.47.3

