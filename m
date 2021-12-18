Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD03C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 18 Dec 2021 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhLRJ6q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 18 Dec 2021 04:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhLRJ6q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 18 Dec 2021 04:58:46 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB6CC06173F
        for <linux-serial@vger.kernel.org>; Sat, 18 Dec 2021 01:58:45 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9C207100D940E;
        Sat, 18 Dec 2021 10:58:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6BFF52E66F1; Sat, 18 Dec 2021 10:58:40 +0100 (CET)
Message-Id: <9395767847833f2f3193c49cde38501eeb3b5669.1639821059.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 18 Dec 2021 10:58:56 +0100
Subject: [PATCH] serial: Fix incorrect rs485 polarity on uart open
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "Su Bao Cheng" <baocheng.su@siemens.com>, baocheng_su@163.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Rafael Gago Castano <rgc@hms.se>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit a6845e1e1b78 ("serial: core: Consider rs485 settings to drive
RTS") sought to deassert RTS when opening an rs485-enabled uart port.
That way, the transceiver does not occupy the bus until it transmits
data.

Unfortunately, the commit mixed up the logic and *asserted* RTS instead
of *deasserting* it:

The commit amended uart_port_dtr_rts(), which raises DTR and RTS when
opening an rs232 port.  "Raising" actually means lowering the signal
that's coming out of the uart, because an rs232 transceiver not only
changes a signal's voltage level, it also *inverts* the signal.  See
the simplified schematic in the MAX232 datasheet for an example:
https://www.ti.com/lit/ds/symlink/max232.pdf

So, to raise RTS on an rs232 port, TIOCM_RTS is *set* in port->mctrl
and that results in the signal being driven low.

In contrast to rs232, the signal level for rs485 Transmit Enable is the
identity, not the inversion:  If the transceiver expects a "high" RTS
signal for Transmit Enable, the signal coming out of the uart must also
be high, so TIOCM_RTS must be *cleared* in port->mctrl.

The commit did the exact opposite, but it's easy to see why given the
confusing semantics of rs232 and rs485.  Fix it.

Fixes: a6845e1e1b78 ("serial: core: Consider rs485 settings to drive RTS")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.14+
Cc: Rafael Gago Castano <rgc@hms.se>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Su Bao Cheng <baocheng.su@siemens.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 29f4781..259f28e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -162,7 +162,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
 	int RTS_after_send = !!(uport->rs485.flags & SER_RS485_RTS_AFTER_SEND);
 
 	if (raise) {
-		if (rs485_on && !RTS_after_send) {
+		if (rs485_on && RTS_after_send) {
 			uart_set_mctrl(uport, TIOCM_DTR);
 			uart_clear_mctrl(uport, TIOCM_RTS);
 		} else {
@@ -171,7 +171,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
 	} else {
 		unsigned int clear = TIOCM_DTR;
 
-		clear |= (!rs485_on || !RTS_after_send) ? TIOCM_RTS : 0;
+		clear |= (!rs485_on || RTS_after_send) ? TIOCM_RTS : 0;
 		uart_clear_mctrl(uport, clear);
 	}
 }
-- 
2.33.0

