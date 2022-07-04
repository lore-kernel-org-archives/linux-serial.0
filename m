Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47EC43334
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jul 2022 08:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiGDIvh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGDIvg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jul 2022 04:51:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE17671
        for <linux-serial@vger.kernel.org>; Mon,  4 Jul 2022 01:51:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o8Hni-0002a3-P3; Mon, 04 Jul 2022 10:51:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o8Hnb-004KqZ-HB; Mon, 04 Jul 2022 10:51:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o8Hne-002uF1-4r; Mon, 04 Jul 2022 10:51:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alan Cox <alan@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: 8250_fsl: Don't report FE, PE and OE twice
Date:   Mon,  4 Jul 2022 10:51:19 +0200
Message-Id: <20220704085119.55900-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2593; h=from:subject; bh=A6rX/PY7QJmDHNUC6NjQIuXk+Pq8qeQm9CW0XzQ5aGM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiwqoDlhMUixwaCBvfJOrge0zh6Ob2a+OrxNH07akD HlUI7YWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYsKqAwAKCRDB/BR4rcrsCdOJB/ wK89jryjblgdSpr7MTRRDXJsE/OTcQqgIMPop8J4hn3Q+sqJGflMmYpGu47xAwp1c6jNhDT4EufRLF wlBavug5sCDBFz3C/mu+JzL7hVeT5jwopOXja4PjclAKN8NkhXlnZzMHnNkWC4lGB0P44dyykjcOmD 1elDIw8A6vbz2nQ3vm/UGh+fcikVSRiuzvPaulxG8Sddi/n1QQlCLdUBwGSCI597VrEp8TVCoYBF1Y JbOfhGopVZA8ZA9gU2AlYJTr+24a5uhvlqc9hGlcZf/QzWTUXTqW+d7pry+XFEh9onZt5dKhrsgKAF tOg0k3MmKHVW1LPvz0aqEe6lKqkYYD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some Freescale 8250 implementations have the problem that a single long
break results in one irq per character frame time. The code in
fsl8250_handle_irq() that is supposed to handle that uses the BI bit in
lsr_saved_flags to detect such a situation and then skip the second
received character. However it also stores other error bits and so after
a single frame error the character received in the next irq handling is
passed to the upper layer with a frame error, too.

So after a spike on the data line (which is correctly recognized as a
frame error) the following valid character is thrown away, because the
driver reports a frame error for that one, too.

To weaken this problem restrict saving LSR to only the BI bit.

Note however that the handling is still broken:

 - lsr_saved_flags is updated using orig_lsr which is the LSR content
   for the first received char, but there might be more in the FIFO, so
   a character is thrown away that is received later and not necessarily
   the one following the break.
 - The doubled break might be the 2nd and 3rd char in the FIFO, so the
   workaround doesn't catch these, because serial8250_rx_chars() doesn't
   handle the workaround.
 - lsr_saved_flags might have set UART_LSR_BI at the entry of
   fsl8250_handle_irq() which doesn't originate from
   fsl8250_handle_irq()'s "up->lsr_saved_flags |= orig_lsr &
   UART_LSR_BI;" but from e.g. from serial8250_tx_empty().
 - For a long or a short break this isn't about two characters, but more
   or only a single one.

Fixes: 9deaa53ac7fa ("serial: add irq handler for Freescale 16550 errata.")
Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes since (implicit) v1:

 - Add Ilpo's Ack
 - Add a paragraph to commit log to better describe the user visible
   problem.

 drivers/tty/serial/8250/8250_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 9c01c531349d..71ce43685797 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -77,7 +77,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
 		serial8250_tx_chars(up);
 
-	up->lsr_saved_flags = orig_lsr;
+	up->lsr_saved_flags |= orig_lsr & UART_LSR_BI;
 
 	uart_unlock_and_check_sysrq_irqrestore(&up->port, flags);
 

base-commit: 089866061428ec9bf67221247c936792078c41a4
-- 
2.36.1

