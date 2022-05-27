Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD672C43217
	for <linux-serial@archiver.kernel.org>; Fri, 27 May 2022 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354779AbiE0Wgq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 May 2022 18:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354806AbiE0Wgo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 18:36:44 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87326AE8;
        Fri, 27 May 2022 15:36:42 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id A21433740218; Fri, 27 May 2022 22:27:18 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH 3/6] serial: core: fully suppress raising DTR & RTS on open if
 manual_rtsdtr
Message-Id: <20220527222718.A21433740218@freecalypso.org>
Date:   Fri, 27 May 2022 22:27:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When manual_rtsdtr sysfs attribute is written as 1,
TTY_PORT_MANUAL_RTSDTR is set, and the call to raise DTR & RTS in
tty_port_raise_dtr_rts() is suppressed.  However, there is one other
place where these signals are also raised on open: uart_port_startup()
in drivers/tty/serial/serial_core.c - this other point of raising
DTR & RTS also needs to be suppressed if TTY_PORT_MANUAL_RTSDTR is set.

Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b47004a3fb77..e5e00732e8fa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -236,7 +236,8 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		 * Setup the RTS and DTR signals once the
 		 * port is open and ready to respond.
 		 */
-		if (init_hw && C_BAUD(tty))
+		if (init_hw && !tty_port_manual_rtsdtr(&state->port) &&
+		    C_BAUD(tty))
 			uart_port_dtr_rts(uport, 1);
 	}
 
-- 
2.9.0

