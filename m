Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999A2C4332F
	for <linux-serial@archiver.kernel.org>; Tue,  3 May 2022 06:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiECGfD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 May 2022 02:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiECGe7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 May 2022 02:34:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0449381A9;
        Mon,  2 May 2022 23:31:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6BA8C1F749;
        Tue,  3 May 2022 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6zhqS+OE857bgyVkpTOjrIk8kxIdlUspbbn6zOUB9c=;
        b=lBt7Xr8O5pCsy0iSq/ngYd38mYHr7xe3NgenR6O7d1kg/tWQ2/hinAlqusRsXz9kSAsEEF
        RTljGQCe38po09Rx4mCcEjS0rQDfqXmu+Ls/V446ekYLbpuHole9vkemRto917JZ9XeT8n
        c3QoJh7Q9MCi+DATLOHW/EzqWz6RaLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6zhqS+OE857bgyVkpTOjrIk8kxIdlUspbbn6zOUB9c=;
        b=DQM1/RFOlE35XhjiIcZihVfiL7BopipiN0lcD1fKGgZf93xpPcgKubyueeVLy5+NgBKY4w
        Zj1hdQbBWnA2bjBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3621B2C143;
        Tue,  3 May 2022 06:31:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/11] serial: pic32: remove unused items from the header
Date:   Tue,  3 May 2022 08:31:12 +0200
Message-Id: <20220503063122.20957-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503063122.20957-1-jslaby@suse.cz>
References: <20220503063122.20957-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

struct pic32_console_opt and its support are unused in pic32. So remove
all that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.h b/drivers/tty/serial/pic32_uart.h
index b15639cc336b..a7dba1d57236 100644
--- a/drivers/tty/serial/pic32_uart.h
+++ b/drivers/tty/serial/pic32_uart.h
@@ -20,13 +20,6 @@
 #define PIC32_UART_RX		0x30
 #define PIC32_UART_BRG		0x40
 
-struct pic32_console_opt {
-	int baud;
-	int parity;
-	int bits;
-	int flow;
-};
-
 /* struct pic32_sport - pic32 serial port descriptor
  * @port: uart port descriptor
  * @idx: port index
@@ -44,7 +37,6 @@ struct pic32_console_opt {
  **/
 struct pic32_sport {
 	struct uart_port port;
-	struct pic32_console_opt opt;
 	int idx;
 
 	int irq_fault;
@@ -68,7 +60,6 @@ struct pic32_sport {
 };
 #define to_pic32_sport(c) container_of(c, struct pic32_sport, port)
 #define pic32_get_port(sport) (&sport->port)
-#define pic32_get_opt(sport) (&sport->opt)
 #define tx_irq_enabled(sport) (sport->enable_tx_irq)
 
 static inline void pic32_uart_writel(struct pic32_sport *sport,
-- 
2.36.0

