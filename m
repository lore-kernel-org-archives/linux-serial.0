Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F247AC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 04:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbiEaEhh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 00:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbiEaEhe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 00:37:34 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC866939F0;
        Mon, 30 May 2022 21:37:32 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id 7AA40374023D; Tue, 31 May 2022 04:37:01 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH v2 3/6] serial: core: fully suppress raising DTR & RTS on open if
 nordy is set
In-Reply-To: <20220531043356.8CAB637401A9@freecalypso.org>
References: <20220531043356.8CAB637401A9@freecalypso.org>
Message-Id: <20220531043701.7AA40374023D@freecalypso.org>
Date:   Tue, 31 May 2022 04:37:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When nordy sysfs attribute is written as 1, TTY_PORT_NORDY is set,
and the call to raise DTR & RTS in tty_port_raise_dtr_rts() is
suppressed.  However, there is one other place where these signals
are also raised on open: uart_port_startup() in
drivers/tty/serial/serial_core.c - this other point of raising
DTR & RTS also needs to be suppressed if TTY_PORT_NORDY is set.

Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a17ac4efaceb..2a558813afa1 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -236,7 +236,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		 * Setup the RTS and DTR signals once the
 		 * port is open and ready to respond.
 		 */
-		if (init_hw && C_BAUD(tty))
+		if (init_hw && !tty_port_nordy(&state->port) && C_BAUD(tty))
 			uart_port_dtr_rts(uport, 1);
 	}
 
-- 
2.9.0

