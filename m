Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3061CC636D3
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 10:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjBBKqJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjBBKpl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 05:45:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A7885EE
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 02:45:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNX5c-0001Lc-GD; Thu, 02 Feb 2023 11:45:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNX5Z-0029NX-QW; Thu, 02 Feb 2023 11:45:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNX5a-000FpT-6T; Thu, 02 Feb 2023 11:45:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] serial: 8250: Fix mismerge regarding serial_lsr_in()
Date:   Thu,  2 Feb 2023 11:45:01 +0100
Message-Id: <20230202104501.264686-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iSyn5X4yxh9Otl1UFVifop0C2sgc4Sf17foNYKOY5qg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj25Qpz+c6bAhRP6OHXsJ1fbH+3+undBaUUsQb/lYv Du5iMtiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY9uUKQAKCRDB/BR4rcrsCc4VB/ 4hdH4ZClDXusu/jgpYFkBignIkavOFQgGVoLtSVaOCg7LvTnQUOQPMRH3sEREbW+k2h/vJ6bIK2eRR boBZp9yXRH6H2cf6NIB8roz5qsuwPVP4P2gv4l64NZ01WSUc9GTTD7XgJHifIhveoAC0QpEjwgsbCy 8hRvWMdqvujp+ZT5wugS2LvsugtJljPWsUvSiH5JZraaNA6BLt/aBIKwcMxij53qLJy5gjKkodNJjI 0QGwMAneHCjlExpSgHDAF35dHer9ntyV4p3dmBlmIhSzxwWElcnOjbbovQgvL3cN44YBdRu4XUsszG MRMovtUVTh+QFhwgAWAoZtEgRoZQy+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The relevant history introducing serial_lsr_in() looks as follows:

	$ git log --graph --oneline --boundary 9fafe733514b..df36f3e3fbb7 -- drivers/tty/serial/8250/8250_port.c
	*   df36f3e3fbb7 Merge tag 'v5.19-rc3' into tty-next
	|\
	| * be03b0651ffd serial: 8250: Store to lsr_save_flags after lsr read
	* | ...
	* | bdb70c424df1 serial: 8250: Create serial_lsr_in()
	* | ce338e4477cf serial: 8250: Store to lsr_save_flags after lsr read
	* | ...
	|/
	o 9fafe733514b tty: remove CMSPAR ifdefs

So the patch "serial: 8250: Store to lsr_save_flags after lsr read" was
introduced twice and in one branch it was followed up by commit
bdb70c424df1 ("serial: 8250: Create serial_lsr_in()") which moved
explicit lsr_saved_flags handling into a new function serial_lsr_in().
When the two branches were merged in commit df36f3e3fbb7, we got both,
serial_lsr_in() and the explicit lsr_saved_flags handling.

So drop the explicit lsr_saved_flags handling.

Fixes: df36f3e3fbb7 ("Merge tag 'v5.19-rc3' into tty-next")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 33be7aad11ef..e61753c295d5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1512,8 +1512,6 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		u16 lsr = serial_lsr_in(p);
 		u64 stop_delay = 0;
 
-		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-
 		if (!(lsr & UART_LSR_THRE))
 			return;
 		/*
-- 
2.39.0

