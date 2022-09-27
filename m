Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C30DC6FA83
	for <linux-serial@archiver.kernel.org>; Tue, 27 Sep 2022 11:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiI0LxE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiI0Lwh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Sep 2022 07:52:37 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01054B0B39
        for <linux-serial@vger.kernel.org>; Tue, 27 Sep 2022 04:52:34 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id F13C82800B6ED;
        Tue, 27 Sep 2022 13:52:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D9AFE1C1AB; Tue, 27 Sep 2022 13:52:30 +0200 (CEST)
Message-Id: <6554b0241a2c7fd50f32576fdbafed96709e11e8.1664278942.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 27 Sep 2022 13:52:34 +0200
Subject: [PATCH] serial: 8250: 8250_omap: Avoid RS485 RTS glitch on
 ->set_termios()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "Su Bao Cheng" <baocheng.su@siemens.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RS485-enabled UART ports on TI Sitara SoCs with active-low polarity
exhibit a Transmit Enable glitch on ->set_termios():

omap8250_restore_regs(), which is called from omap_8250_set_termios(),
sets the TCRTLR bit in the MCR register and clears all other bits,
including RTS.  If RTS uses active-low polarity, it is now asserted
for no reason.

The TCRTLR bit is subsequently cleared by writing up->mcr to the MCR
register.  That variable is always zero, so the RTS bit is still cleared
(incorrectly so if RTS is active-high).

(up->mcr is not, as one might think, a cache of the MCR register's
current value.  Rather, it only caches a single bit of that register,
the AFE bit.  And it only does so if the UART supports the AFE bit,
which OMAP does not.  For details see serial8250_do_set_termios() and
serial8250_do_set_mctrl().)

Finally at the end of omap8250_restore_regs(), the MCR register is
restored (and RTS deasserted) by a call to up->port.ops->set_mctrl()
(which equals serial8250_set_mctrl()) and serial8250_em485_stop_tx().

So there's an RTS glitch between setting TCRTLR and calling
serial8250_em485_stop_tx().  Avoid by using a read-modify-write
when setting TCRTLR.

While at it, drop a redundant initialization of up->mcr.  As explained
above, the variable isn't used by the driver and it is already
initialized to zero because it is part of the static struct
serial8250_ports[] declared in 8250_core.c.  (Static structs are
initialized to zero per section 6.7.8 nr. 10 of the C99 standard.)

Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Su Bao Cheng <baocheng.su@siemens.com>
---
Matthias tested this patch on the AM64 board TQMa6442L + MBaX4XxL:
He says he's seeing RTS glitches on tty open/close without the patch
(RTS is high for a few usec, 2x on open, 1x on close).
Those glitches are gone with the patch.

 drivers/tty/serial/8250/8250_omap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 41b8c6b..68f5a16 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -292,6 +292,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 {
 	struct omap8250_priv *priv = up->port.private_data;
 	struct uart_8250_dma	*dma = up->dma;
+	u8 mcr = serial8250_in_MCR(up);
 
 	if (dma && dma->tx_running) {
 		/*
@@ -308,7 +309,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 	serial_out(up, UART_EFR, UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-	serial8250_out_MCR(up, UART_MCR_TCRTLR);
+	serial8250_out_MCR(up, mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_FCR, up->fcr);
 
 	omap8250_update_scr(up, priv);
@@ -324,7 +325,8 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 	serial_out(up, UART_LCR, 0);
 
 	/* drop TCR + TLR access, we setup XON/XOFF later */
-	serial8250_out_MCR(up, up->mcr);
+	serial8250_out_MCR(up, mcr);
+
 	serial_out(up, UART_IER, up->ier);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
@@ -669,7 +671,6 @@ static int omap_8250_startup(struct uart_port *port)
 
 	pm_runtime_get_sync(port->dev);
 
-	up->mcr = 0;
 	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 
 	serial_out(up, UART_LCR, UART_LCR_WLEN8);
-- 
2.36.1

