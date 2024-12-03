Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF61DF997;
	Tue,  3 Dec 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219675; cv=none; b=rsu4VTSAkwrB7LPD2jiUtFwEvGWViSmb8JW5DQs0saundmGXJN8hcUq22kOwp5JovCEqyoQMooxdasLMsxgIZw5Edhye5gy+SRfqddXvtt7k7guNlgNWlEp1BcQNPxFEZ4j/lu8sxLz1kP3tCU675oSMBU1ZyAwQOooCRLCNnaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219675; c=relaxed/simple;
	bh=TwPJesTdogR03ZpiZLNMvWwUYaMAP2evG8yhNNGxTeA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pXhCcmVi4qNMW7DkvrcXVz/xIFypzf63OaSHhaxDp89YSIJ6Wm6+uDp8yaXf6SQrwXwbojI49J9NdxPK87jIQ9RGUEhM45lCpMW1QRE41xxJiQ2KTRUpnPgG13ILeCXIcYQzNp+c9ASiaUsG+XGepSTw/V2c5gaWmpM94X0X+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5674ed555d4e-c1d65;
	Tue, 03 Dec 2024 17:54:29 +0800 (CST)
X-RM-TRANSID:2ee5674ed555d4e-c1d65
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8674ed555b7b-274ad;
	Tue, 03 Dec 2024 17:54:29 +0800 (CST)
X-RM-TRANSID:2ee8674ed555b7b-274ad
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: mpc52xx: Fix typo in mpc52xx_uart.c
Date: Tue,  3 Dec 2024 01:54:28 -0800
Message-Id: <20241203095428.8559-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The word 'accoding' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index f55aa353a..2204cc3e3 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1621,7 +1621,7 @@ mpc52xx_console_setup(struct console *co, char *options)
 		 (void *)port->mapbase, port->membase,
 		 port->irq, port->uartclk);
 
-	/* Setup the port parameters accoding to options */
+	/* Setup the port parameters according to options */
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
-- 
2.17.1



