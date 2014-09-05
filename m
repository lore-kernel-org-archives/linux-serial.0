From: Gregory Hermant <gregory.hermant@calao-systems.com>
Subject: [PATCH] max310x: max3109_detect should use indirect addressing in SPI mode for REVID register
Date: Fri,  5 Sep 2014 18:07:36 +0200
Message-ID: <1409933256-32071-1-git-send-email-gregory.hermant@calao-systems.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:26052 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaIEQNm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Sep 2014 12:13:42 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: shc_work@mail.ru, Gregory Hermant <gregory.hermant@calao-systems.com>

This patch allows to read the REV_ID register in SPI mode and consequently
to properly detect the max3109. Indeed in SPI mode, this register is only
accessible by using indirect addressing.

Signed-off-by: Gregory Hermant <gregory.hermant@calao-systems.com>
---
 drivers/tty/serial/max310x.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5183643..2d911f6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -369,10 +369,13 @@ static int max3109_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_read(s->regmap, MAX310X_REVID_REG, &val);
+	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
+			   MAX310X_EXTREG_ENBL);
 	if (ret)
 		return ret;
-
+	
+	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
+	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
 	if (((val & MAX310x_REV_MASK) != MAX3109_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
-- 
1.7.9.5

