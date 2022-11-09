Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D05C4332F
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 07:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKIHEp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKIHEm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 02:04:42 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC781DF00
        for <linux-serial@vger.kernel.org>; Tue,  8 Nov 2022 23:04:40 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 691AD100E5F21;
        Wed,  9 Nov 2022 08:04:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4F27128CBD; Wed,  9 Nov 2022 08:04:33 +0100 (CET)
Message-Id: <7d5b04da13d89b8708b9543a0b125f2b6062a77b.1667977259.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 9 Nov 2022 08:04:34 +0100
Subject: [PATCH tty-next] serial: 8250: 8250_omap: Fix calculation of RS485
 delays
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dan Carpenter <error27@gmail.com>, linux-serial@vger.kernel.org
Cc:     Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Zeng Chao <chao.zeng@siemens.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 801954d1210a ("serial: 8250: 8250_omap: Support native RS485")
calculates RS485 delays from the baudrate.  The baudrate is generated
with either a 16x or 13x divisor.  The divisor is set in the Mode
Definition Register 1 (MDR1).

The commit erroneously assumes that the register stores the divisor as
a bitmask and uses a logical AND to differentiate between 16x and 13x
divisors.  However the divisor is really stored as a 3-bit mode
(see lines 363ff in include/uapi/linux/serial_reg.h).

The logical AND operation is performed with UART_OMAP_MDR1_16X_MODE,
which is defined as 0x0 and hence yields false.  So the commit always
assumes a 13x divisor.  Fix by using an equal comparison.  This works
because we never set any of the other 5 bits in the register.  (They
pertain to IrDA mode, which is not supported by the driver).

Fixes: 801954d1210a ("serial: 8250: 8250_omap: Support native RS485")
Link: https://lore.kernel.org/linux-serial/202211070440.8hWunFUN-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 1dd8c5b..734f092 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -824,7 +824,7 @@ static int omap8250_rs485_config(struct uart_port *port,
 	 * of the AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
 	 */
 	if (priv->quot) {
-		if (priv->mdr1 & UART_OMAP_MDR1_16X_MODE)
+		if (priv->mdr1 == UART_OMAP_MDR1_16X_MODE)
 			baud = port->uartclk / (16 * priv->quot);
 		else
 			baud = port->uartclk / (13 * priv->quot);
-- 
2.36.1

