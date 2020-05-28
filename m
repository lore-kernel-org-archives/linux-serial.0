Return-Path: <SRS0=aTVb=7K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22FC433E2
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFCB207D3
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 15:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="o6VEYz6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404822AbgE1PzV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 May 2020 11:55:21 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:51923 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404654AbgE1PzP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 May 2020 11:55:15 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 11:55:14 EDT
IronPort-SDR: ju0s3cShC548PVB0OFvt3B1Fc0gbVAl0k1p7+rfUk+DmeMA7RbHCHHzs7GnluNPf+DWNeWSTlH
 sKGVLoBDbvNaXuO4C4+rgqj3GGaweNazLeqp63Bpa4kLVzdl8je3Y8YIdTirQ8MNoU3xUQ1pKu
 AbgsDZyaGyeBgw5sRBAWVkmjdHASJK6fUuWysldp4G5F16BntA36+eNdq1Lpe/QtSyXYiNAk67
 r6K1/2RM8fUZLQbszihlFowdzT90Ms/NaSP/OfSu+ob4FDfSpxS25dkmICZVpcbvCNPeUGUpNj
 QwU=
X-IronPort-AV: E=Sophos;i="5.73,445,1583190000"; 
   d="scan'208";a="12467472"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 May 2020 17:48:01 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 28 May 2020 17:48:01 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 28 May 2020 17:48:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1590680881; x=1622216881;
  h=from:to:cc:subject:date:message-id;
  bh=Sw9zOSroZ9SJ13/VWfo6J3/CTkEe0YQ1ov3hXyiqHjU=;
  b=o6VEYz6g2+uUCIm6pOwgrfz/+MQTuWCV+uE3fh0ueXURKM7vqkTT8p5l
   39F1FyW06A7/wLOkN+fTggsyCXKENzJs4bqLpHhM19nzszD3NnIc6O/Nm
   PcBl2zma1DqO1Bassg/NG89dUJNARNtjmJ7G89IPyFD7R6JYDegFdSUe3
   FGQvgYDuxq1DOdVcQ58VEw38iRe6+KQxL2wpMOhdJ3P5ePGILrMkMgT/O
   EFexqVCSgiI0G/JzSsrl+NOolvGWetWesUBh4fl9nd3bTr1DyBGDHL1nP
   ZU4qNp4qs+X3TBLlBehL9i+X92JLq6Z5fwwdff8cKJNM8UirEwf6FNVD9
   g==;
IronPort-SDR: RrXTpHqHWtOzMSM6Sus6P6W4/PMG5G2AVnztXyMkjiMfLXzXgNWpNtue6Z0+Vi5LV5JTU0iYdi
 Xqv9zqfnfzB4jlhxvs/RNlqXSCV0/5aKNy6ykd54R4XYxNs29AyIPd8qOiZgzpa6cqpXXjq7Xw
 ctD8232wIvotrcu8wJClvJXpNUwDFiL5UfuNi8xvjhgbUSDNrMzfqVcXjZ9koDdqJ0QbSFJ7Q8
 0VLiAYH/ulF+IxWGPssFJds4XldgSdM7Z0HPYT/RjUiMwcLceIdO3SG4MVe8PwLoN7PMsclkLN
 N3s=
X-IronPort-AV: E=Sophos;i="5.73,445,1583190000"; 
   d="scan'208";a="12467471"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 May 2020 17:48:00 +0200
Received: from schifferm-ubuntu4.tq-net.de (unknown [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 90B93280065;
        Thu, 28 May 2020 17:48:08 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH tty-next] tty: serial: imx: clear Ageing Timer Interrupt in handler
Date:   Thu, 28 May 2020 17:47:47 +0200
Message-Id: <20200528154747.14201-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The AGTIM flag must be cleared explicitly, otherwise the IRQ handler
will be called in an endless loop.

Fortunately, this issue currently doesn't affect mainline kernels in
practice, as the the RX FIFO trigger level is set to 1 in UFCR. When
setting the trigger level to a higher number, the issue is trivially
reproducible by any RX without DMA that doesn't fill the FIFO up to the
configured level.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 6b078e395931..1265e8d86d8a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -909,6 +909,8 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 		usr2 &= ~USR2_ORE;
 
 	if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
+		imx_uart_writel(sport, USR1_AGTIM, USR1);
+
 		__imx_uart_rxint(irq, dev_id);
 		ret = IRQ_HANDLED;
 	}
-- 
2.17.1

