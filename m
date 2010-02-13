From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 11/12] Serial: sc26xx - initialise hardware if not done by
	bootloader
Date: Sat, 13 Feb 2010 17:10:33 +0100
Message-ID: <20100213161033.22311.73686.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0BMQKg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:36 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:35 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

If hardware is not initialised by bootloader after a hard reset
the MR1,MR2 registers may be 0xFF.
This causes the transmitter to never initialise and an infinite
loop to occur later.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 09e73a3..2e17bbc 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -832,6 +832,27 @@ static const struct chip_def * __devinit detect_chip_type(
 	return chip;
 }
 
+static void __devinit hw_init(struct uart_port *port)
+{
+	u8 mr;
+
+	/* Sometimes on cold boot MR1,MR2 are 0xFF (reset problem?)
+	 * Initialise if channel mode in MR2 is not normal otherwise
+	 * assume bootloader has done the init.
+	 */
+	write_cmd_port(port, CR_RES_MR); /* MR1 */
+	READ_SC_PORT(port, MRx); /* skip MR1 */
+	mr = READ_SC_PORT(port, MRx);
+	if (mr & 0xC0) {
+		write_cmd_port(port, CR_RES_MR);
+
+		/* Values below are arbitary (will be changed by set_termios)
+		 * but must be different so that chip detection works */
+		WRITE_SC_PORT(port, MRx, 0x10);
+		WRITE_SC_PORT(port, MRx, 0x00);
+	}
+}
+
 static int __devinit sc26xx_probe(struct platform_device *dev)
 {
 	struct resource *res, *irq_res;
@@ -869,6 +890,7 @@ static int __devinit sc26xx_probe(struct platform_device *dev)
 	up->port[0].dev = &dev->dev;
 
 	sc26xx_init_masks(up, 0, pdata->signal_map[0]);
+	hw_init(&up->port[0]);
 
 	sc26xx_port = &up->port[0];
 
@@ -876,6 +898,7 @@ static int __devinit sc26xx_probe(struct platform_device *dev)
 	up->port[1].line = 1;
 
 	sc26xx_init_masks(up, 1, pdata->signal_map[1]);
+	hw_init(&up->port[1]);
 
 	if (pdata->chip_name)
 		up->chip = chip_by_name(pdata->chip_name);

