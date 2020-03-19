Return-Path: <SRS0=NQQO=5E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD2EC4332E
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832E120753
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 10:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uwRgoTgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCSKcR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:32:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32888 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgCSKcQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Mar 2020 06:32:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JAWDfJ036939;
        Thu, 19 Mar 2020 05:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584613933;
        bh=DFHgPDVeDYbr4SySedqf8GsAsYiExrc0b8I1wlri5aI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uwRgoTgVxWqX7m8lO59pfH7R7sYXbJHmSVvVdGTHZrumbzzO2UqPX2h3DS52OQDOv
         QYPfAsasLCfZkNwDGjTbxRPqufkcmIBA/lQHJDzB1Iqoe3q7C8K2Rx0Y7xhTQyPNsX
         7iAEWLtSnoWMXieimut/KTOwwxkaphUjFXxJoSTI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JAWDlj126883;
        Thu, 19 Mar 2020 05:32:13 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 05:32:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 05:32:13 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JAW6Aj068234;
        Thu, 19 Mar 2020 05:32:11 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Oliver Barta <o.barta89@gmail.com>
Subject: [PATCH 2/2] serial: 8250: 8250_omap: Fix throttle to call stop_rx()
Date:   Thu, 19 Mar 2020 16:02:30 +0530
Message-ID: <20200319103230.16867-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319103230.16867-1-vigneshr@ti.com>
References: <20200319103230.16867-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Call stop_rx() to halt reception when throttle is requested. Update
unthrottle callback to restart reception.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 449f1519e70f..82fca112409c 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -699,14 +699,12 @@ static void omap_8250_shutdown(struct uart_port *port)
 static void omap_8250_throttle(struct uart_port *port)
 {
 	struct omap8250_priv *priv = port->private_data;
-	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
 	pm_runtime_get_sync(port->dev);
 
 	spin_lock_irqsave(&port->lock, flags);
-	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	serial_out(up, UART_IER, up->ier);
+	port->ops->stop_rx(port);
 	priv->throttled = true;
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -727,6 +725,7 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	if (up->dma)
 		up->dma->rx_dma(up);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	port->read_status_mask |= UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.25.2

