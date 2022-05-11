Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3FBC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 11 May 2022 09:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiEKJdO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 May 2022 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiEKJdL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 May 2022 05:33:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65313C1F0
        for <linux-serial@vger.kernel.org>; Wed, 11 May 2022 02:33:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1noiiI-0003M2-Ug; Wed, 11 May 2022 11:32:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noiiH-001ewg-Go; Wed, 11 May 2022 11:32:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noiiF-008zvS-F0; Wed, 11 May 2022 11:32:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alan Cox <alan@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
Date:   Wed, 11 May 2022 11:32:47 +0200
Message-Id: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503; h=from:subject; bh=Y8CD9FwUDIlR7wUXJh/MKJBdsV/Whq8SlKuj+sBZNkQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBie4K7OJVNQbfNQY53byvKELgrrCYhVNB8eweShrDD xVbpm8iJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYnuCuwAKCRDB/BR4rcrsCWOEB/ 4pFsjBZ57z3i+qxVG7dfuPgd6JWg4TRnxJGGP1cZ9tayzK7e408/opCFDWSE4FyASPS33crKEk/dDp qAOwtihPjzAKINqJOpBbrLUFmNS202IxnUPXiN6EKenK1SCHViu5EFLeZMEg69MHKrvkcQImLEQRw8 VGTB4gbFv86ncksTiC8KMtLTg7GBul2h7TishKLBNBm8DLeZW0o1Y5SVbxVTW+7dcTTXipAuJX7j3K jUS2Jym0s9c5V7A0BO4cESVl7fEQt3dokJ5fEO7oeasKqKIoLRLTqK8JTz8ZOaOFRYFFMkvF5vetHN S2RbI1HAfajq0UdvxyZ+d9FM3bS3Aa
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
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

note this patch is more or less untested because I have an MPC8313 that
doesn't show the behaviour described in the erratum. However the patch
fixes handling of frame errors, partity errors and overflow errors if
for that SoC the fsl8250_handle_irq is still used (which is a different
bug).

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
 

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

