Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95965C636D7
	for <linux-serial@archiver.kernel.org>; Thu, 23 Feb 2023 04:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjBWEY7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Feb 2023 23:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjBWEYa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Feb 2023 23:24:30 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC64497E4
        for <linux-serial@vger.kernel.org>; Wed, 22 Feb 2023 20:23:07 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 24DEB85AD6;
        Thu, 23 Feb 2023 05:23:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1677126185;
        bh=dN/XVzBDhXcjXM25KgY+bixsmEMi13ZvR4n3mQFnt00=;
        h=From:To:Cc:Subject:Date:From;
        b=CbkUXw0RWgzSrBGnlhu9GjoZ/EXvbhO62DxN/v0izHkWqNx2BDwqViOYKDc664u4y
         yO3uWeYfGf6n2+daOOTixXeTqw9y4+CrH7UrpSgpWNp9oEfMvqggbO4SA6ZqLnUT8J
         joveJAYpdXHR26CyGI6LxHLXw796qQjqFfICbsLhjSJYyCRyJN+6IP4iyH3cNzEIWd
         YlU1Zb49ErVgUXwtCzl1lkms9YzurFnHA3iZVm6DzFkeRQaI52gl7iPCkXPzOaFl2Q
         ZjIrpJ884i4lsO6UhoVtnw9K95woEkI0X7c1JTyHid2W67r3+I7dvmHgp3HagQEEED
         8WGlKQyO5UbSQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] serial: stm32: Remove unused struct stm32_port txdone element
Date:   Thu, 23 Feb 2023 05:22:51 +0100
Message-Id: <20230223042252.95480-1-marex@denx.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The txdone element is only ever assigned, once, and never used. Drop it.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Erwan Le Ray <erwan.leray@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jean Philippe Romain <jean-philippe.romain@foss.st.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/tty/serial/stm32-usart.c | 1 -
 drivers/tty/serial/stm32-usart.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 767ff9fdb2e58..bf51e2152dd5a 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -743,7 +743,6 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 		stm32_usart_tx_interrupt_disable(port);
 		if (!stm32_port->hw_flow_control &&
 		    port->rs485.flags & SER_RS485_ENABLED) {
-			stm32_port->txdone = true;
 			stm32_usart_tc_interrupt_enable(port);
 		}
 	}
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 0ec41a732c888..903285b5aea75 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -203,7 +203,6 @@ struct stm32_port {
 	bool hw_flow_control;
 	bool swap;		 /* swap RX & TX pins */
 	bool fifoen;
-	bool txdone;
 	int rxftcfg;		/* RX FIFO threshold CFG      */
 	int txftcfg;		/* TX FIFO threshold CFG      */
 	bool wakeup_src;
-- 
2.39.1

