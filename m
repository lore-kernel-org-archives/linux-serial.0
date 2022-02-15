Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC1C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Feb 2022 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbiBOQDB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:03:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiBOQDA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Feb 2022 11:03:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0AB88
        for <linux-serial@vger.kernel.org>; Tue, 15 Feb 2022 08:02:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nK0Hr-0005jV-C5; Tue, 15 Feb 2022 17:02:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nK0Hq-00GmSS-Cg; Tue, 15 Feb 2022 17:02:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nK0Ho-003Mnq-Og; Tue, 15 Feb 2022 17:02:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Tomas Melin <tomas.melin@vaisala.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] serial: 8250: Fix race condition in RTS-after-send handling
Date:   Tue, 15 Feb 2022 17:02:36 +0100
Message-Id: <20220215160236.344236-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; h=from:subject; bh=XNCV3u2ym5nwa1WquipipTXI1xoACPeaK8AoWg7jmdw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiC86Y6oPeVmI3Z3cS2BMIuTkuzRP/WWwq7Vvm+eaO nwbmuHmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYgvOmAAKCRDB/BR4rcrsCU9FB/ sEJH8NqPLlFVEJ5oRS5zoXzlS34nihyAer5Q/ZGdmjuzzxnaQ0hN+JFO4epIE+suo09DH0jH70Jhn3 DANFGg5BjTy3IAGcUqsTDcLBwNfpszGEFYtBvJ3DpBpKofLkOwOd8KGs4T24c0+f7Hoh9RK3Tmj94v byRi0X3xVKz4OoaBTVEqoRrRnKtqHagVqB/4Ek6dQkyrN6Wn6ePjs6iFa+5fbb+Ut4vr6F7l/0beTC sq5vJ7JgCDID3mdMx/N208Gl72dwaa7SPtbj89QOrTnhysOCqU6TcsskyUWaywEZgQuXb24iadvDPJ GSYMVz3UvBN+SiEpfpMdOqiii7buru
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Set em485->active_timer = NULL isn't always enough to take out the stop
timer. While there is a check that it acts in the right state (i.e.
waiting for RTS-after-send to pass after sending some chars) but the
following might happen:

 - CPU1: some chars send, shifter becomes empty, stop tx timer armed
 - CPU0: more chars send before RTS-after-send expired
 - CPU0: shifter empty irq, port lock taken
 - CPU1: tx timer triggers, waits for port lock
 - CPU0: em485->active_timer = &em485->stop_tx_timer, hrtimer_start(),
   releases lock()
 - CPU1: get lock, see em485->active_timer == &em485->stop_tx_timer,
   tear down RTS too early

This fix bases on research done by Steffen Trumtrar.

Fixes: b86f86e8e7c5 ("serial: 8250: fix potential deadlock in rs485-mode")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3b12bfc1ed67..e77620a17d5d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1615,6 +1615,18 @@ static inline void start_tx_rs485(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct uart_8250_em485 *em485 = up->em485;
 
+	/*
+	 * While serial8250_em485_handle_stop_tx() is a noop if
+	 * em485->active_timer != &em485->stop_tx_timer, it might happen that
+	 * the timer is still armed and triggers only after the current bunch of
+	 * chars is send and em485->active_timer == &em485->stop_tx_timer again.
+	 * So cancel the timer. There is still a theoretical race condition if
+	 * the timer is already running and only comes around to check for
+	 * em485->active_timer when &em485->stop_tx_timer is armed again.
+	 */
+	if (em485->active_timer == &em485->stop_tx_timer)
+		hrtimer_try_to_cancel(&em485->stop_tx_timer);
+
 	em485->active_timer = NULL;
 
 	if (em485->tx_stopped) {

base-commit: e3c85076d7a6f986445b9008be7e7f83d1b0780a
-- 
2.34.1

