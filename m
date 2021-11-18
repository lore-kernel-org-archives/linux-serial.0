Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA8C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3477661A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbhKRHWR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:22:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51928 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbhKRHWN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:22:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8486B1FD38;
        Thu, 18 Nov 2021 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637219952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3FfgKs0Zk+8E9GvkJzXlwFfMbYlsq8ypLV5UxQjBRU=;
        b=LYciTFQRnHWDlZdDfzQ6hIdiH/vuKke6M/MpLKqvFY0iG7aynOeym1CwToeR/fhNs8cFF6
        ka0t7o4L9/u6dwTNd7Lm5frGIOR14rbSnoknNkeeBGpu96a/1NGJa41BOSGENW5fjhsIca
        uxlnRBXGIrAYTbAsbh2k5b8xu7R8CUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637219952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3FfgKs0Zk+8E9GvkJzXlwFfMbYlsq8ypLV5UxQjBRU=;
        b=fmOmG9V10f/Yd9pnXfSq2jWLV7Y8bOvzmATDfNMpJsj63F9xiJlnOFMZhW6QfEWy7hhMed
        4IN4Y8L9NsWLOuCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5C359A3B83;
        Thu, 18 Nov 2021 07:19:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/4] tty: serial, join uport checks in uart_port_shutdown()
Date:   Thu, 18 Nov 2021 08:19:11 +0100
Message-Id: <20211118071911.12059-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118071911.12059-1-jslaby@suse.cz>
References: <20211118071911.12059-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are two consequent checks of uport != NULL in
uart_port_shutdown(). Join these two under a single block.

De-multiline the comments when shuffling with them anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/serial_core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1e738f265eea..a8750927f03c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1685,17 +1685,13 @@ static void uart_port_shutdown(struct tty_port *port)
 	 */
 	wake_up_interruptible(&port->delta_msr_wait);
 
-	/*
-	 * Free the IRQ and disable the port.
-	 */
-	if (uport)
+	if (uport) {
+		/* Free the IRQ and disable the port. */
 		uport->ops->shutdown(uport);
 
-	/*
-	 * Ensure that the IRQ handler isn't running on another CPU.
-	 */
-	if (uport)
+		/* Ensure that the IRQ handler isn't running on another CPU. */
 		synchronize_irq(uport->irq);
+	}
 }
 
 static int uart_carrier_raised(struct tty_port *port)
-- 
2.33.1

