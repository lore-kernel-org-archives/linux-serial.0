Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ABCC43462
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17006128B
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 13:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhEJNcp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 May 2021 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343713AbhEJMOO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 May 2021 08:14:14 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2FC0612F3
        for <linux-serial@vger.kernel.org>; Mon, 10 May 2021 05:08:03 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f937:4595:45ff:bcbf])
        by michel.telenet-ops.be with bizsmtp
        id 30802500T4jQ7kl06080AJ; Mon, 10 May 2021 14:08:01 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4hc-004Qbr-8k; Mon, 10 May 2021 14:08:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4hb-00HPFQ-Qf; Mon, 10 May 2021 14:07:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linh Phung <linh.phung.jy@renesas.com>
Cc:     linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Fix off-by-one error in FIFO threshold register setting
Date:   Mon, 10 May 2021 14:07:55 +0200
Message-Id: <5eff320aef92ffb33d00e57979fd3603bbb4a70f.1620648218.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Receive FIFO Data Count Trigger field (RTRG[6:0]) in the Receive
FIFO Data Count Trigger Register (HSRTRGR) of HSCIF can only hold values
ranging from 0-127.  As the FIFO size is equal to 128 on HSCIF, the user
can write an out-of-range value, touching reserved bits.

Fix this by limiting the trigger value to the FIFO size minus one.
Reverse the order of the checks, to avoid rx_trig becoming zero if the
FIFO size is one.

Note that this change has no impact on other SCIF variants, as their
maximum supported trigger value is lower than the FIFO size anyway, and
the code below takes care of enforcing these limits.

Reported-by: Linh Phung <linh.phung.jy@renesas.com>
Fixes: a380ed461f66d1b8 ("serial: sh-sci: implement FIFO threshold register setting")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

The BSP contains a different patch[1], which masks the value to write by
0x7f.  This is IMHO incorrect, as it would set the trigger value to zero
when 128 is requested.

[1] "serial: sh-sci: Using mask when writing to HSRTRGR"
    https://github.com/renesas-rcar/linux-bsp/commit/9915223f41c7d680aaaed12971601dc038ce76a3
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ef37fdf37612f82f..4baf1316ea729931 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1023,10 +1023,10 @@ static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 {
 	unsigned int bits;
 
+	if (rx_trig >= port->fifosize)
+		rx_trig = port->fifosize - 1;
 	if (rx_trig < 1)
 		rx_trig = 1;
-	if (rx_trig >= port->fifosize)
-		rx_trig = port->fifosize;
 
 	/* HSCIF can be set to an arbitrary level. */
 	if (sci_getreg(port, HSRTRGR)->size) {
-- 
2.25.1

