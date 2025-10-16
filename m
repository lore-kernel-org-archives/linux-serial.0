Received: from mx-relay28-hz2.antispameurope.com (mx-relay28-hz2.antispameurope.com [94.100.136.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18663009F5
	for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614747; cv=pass; b=pIXiGfOBIBLc0Fyuauyms7PgZIJPtDc7+bM6uONiY4UC37+Azm/cso/eAECXs9bEkYcSGVG6tYp4S37vdCNPs50LTwW7Cyi9KntQK5lIkNfC+S78dntIRW4fA3tNbeaHqVDgFr5v50LhPjWP3/eJsKfCO9i6nc6KzoEmfiBrgm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614747; c=relaxed/simple;
	bh=GlmFA1e3xgMj4OhgcxyrgU5ao2+BLBIMEKfNxeDhUDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMZIiN9HmNQEtzpjglVhXOyunihatszqrOz195LK94qjarTr8IIPild8Q4dTuUS8Q/IAbkwfpiUwSdIPcbBdju5wNbNg/nzZp1dLhOkhCK2a019ZyC9Yjt+RRIZJe9AIiN/RTo8oE6WaZyJ+VTf2O/wL90TvILjjGRs+rKUrsho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KCQw4DfV; arc=pass smtp.client-ip=94.100.136.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KCQw4DfV"
ARC-Authentication-Results: i=1; mx-gate28-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=CFRIIs060aUTE/XtgbE3U9aNP00cbQnhfyqtNtGSsHY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760614688;
 b=Ra4NX6mEdL6Kaug0mnercr1vK+MXtcf6qWdFpMOtX8bwD5xEICrrLKpvDM/MMJkXZEZzS9aV
 Ir9JMqPxxeHamF4lJTvr1oVpZDh4pcErobvIfVAqmrVCCydTU5TlOXRRC1tBiiH7Q39GbcNVKfv
 /CxIWwzegnKQVz8UulA+BpffR94MIj0kn1qjaLJYHQn/9uWU5aaU02muV/9i6ZFNnwXxvjrx/z7
 p/esB5BQAk8B7vPBgIfFrRWjW81mulWYJVJvn5jqOwyi94PUDZVyOpHDm2YUy6x8U1dDJh8chIf
 0Bozn7Hdq5m9yA6tebpUXAcMhiEtFXkyjKLC/9pL+rnQA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760614688;
 b=klgVNlu016bGXSjMjvn3siqDONwZPPs3Oi1XFnZ6UFmBjsXLkqZpnsiZCnV7jLqoO7aGL5NI
 I8Y5FtxwowYaZwvrAURZMyVh7lzK6gzA72CZ4cjtUu4KNrnzbqXix58z/yKqF99g0g2Dyrn/bgn
 ntrPGuIOX50k/RJb6MmBuO2rPUZhJVbL/eCmI6JZDpkYZxlLtfwsGzhZIrZ+oU/HjaaJqdWMFtQ
 mM/Roy7JFGcPIynGbL06TwSNfeW4EH1b5eSp52Dz2VbCvnXgbDJH+rU/MEa8+5Bz6db0tindGPH
 YSes0cJdMsfv8CqumsKhIKl42YJdGG5QfyCPMjPteg5hw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay28-hz2.antispameurope.com;
 Thu, 16 Oct 2025 13:38:08 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 3F3EC220BA0;
	Thu, 16 Oct 2025 13:37:50 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
Date: Thu, 16 Oct 2025 13:37:30 +0200
Message-ID: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-serial@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay28-hz2.antispameurope.com with 4cnQtQ6zX8z1QNSK
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:a7531a3aefe8095ad0ffc3e1e5a543aa
X-cloud-security:scantime:2.247
DKIM-Signature: a=rsa-sha256;
 bh=CFRIIs060aUTE/XtgbE3U9aNP00cbQnhfyqtNtGSsHY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760614687; v=1;
 b=KCQw4DfVHoklSaLyx2Eebrfmlr604L6JMes3wgXxR0EZOvpTV4nu/sVVNUn70vbee3QIDfNx
 9cokUkuqiZaqccuVf5OVQfPTtsBwyDY4HMHWA1e+9mz/Q51FmpvErfRfa7xivFAYJByMaw8fRhu
 YVnU6BO1icUZE132aRghmeytH3RSNfhEi+IrWAQ9LY8Sa/GjDnyFfEdACVmN8uxQBMXCONPirxF
 Oy7/SLEVr8WhIqEeVkCc68VCZ6VNgneqlBOcHY2t83u5kaRGTxEA6nzBg4qq/FGrvVrurHBWzAA
 VbCT1vQeCJ3mteSueyK2YG57wE34jejZ8DjccloEn+AFg==

The CTS GPIO is only evaluated when the CRTSCTS termios flag is enabled;
it should be possible to enable the flag when only GPIO and no hardware-
controlled RTS/CTS are available. UCR2_IRTS is kept enabled in this case,
so the hardware CTS is ignored.

Fixes: 58362d5be352 ("serial: imx: implement handshaking using gpios with the mctrl_gpio helper")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/tty/serial/imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 500dfc009d03e..4a54a689a0603 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1117,8 +1117,8 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 			ucr2 |= UCR2_CTS;
 			/*
 			 * UCR2_IRTS is unset if and only if the port is
-			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
-			 * to get the state to restore to.
+			 * configured for hardware-controlled CRTSCTS, so we use
+			 * inverted UCR2_IRTS to get the state to restore to.
 			 */
 			if (!(ucr2 & UCR2_IRTS))
 				ucr2 |= UCR2_CTSC;
@@ -1780,7 +1780,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 |= UCR2_WS;
 
-	if (!sport->have_rtscts)
+	if (!sport->have_rtscts && !sport->have_rtsgpio)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (port->rs485.flags & SER_RS485_ENABLED) {
@@ -1794,7 +1794,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
 
-	} else if (termios->c_cflag & CRTSCTS) {
+	} else if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts) {
 		/*
 		 * Only let receiver control RTS output if we were not requested
 		 * to have RTS inactive (which then should take precedence).
@@ -1803,7 +1803,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			ucr2 |= UCR2_CTSC;
 	}
 
-	if (termios->c_cflag & CRTSCTS)
+	if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts)
 		ucr2 &= ~UCR2_IRTS;
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

