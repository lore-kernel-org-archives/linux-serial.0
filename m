From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 2/2] serial: sh-sci: Make probe fail for ports that exceed the maximum count
Date: Wed, 13 Jun 2012 00:28:24 +0200
Message-ID: <1339540104-25003-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1339540104-25003-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48099 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab2FLW2U (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Jun 2012 18:28:20 -0400
In-Reply-To: <1339540104-25003-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org

The driver supports a maximum number of ports configurable at compile
time. Make sure the probe() method fails when registering a port that
exceeds the maximum instead of returning success without registering the
port.

This fixes a crash at system suspend time, when the driver tried to
suspend a non-registered port using the UART core.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a779663..55dada3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2352,7 +2352,7 @@ static int __devinit sci_probe_single(struct platform_device *dev,
 			   index+1, SCI_NPORTS);
 		dev_notice(&dev->dev, "Consider bumping "
 			   "CONFIG_SERIAL_SH_SCI_NR_UARTS!\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	ret = sci_init_single(dev, sciport, index, p);
-- 
1.7.3.4

