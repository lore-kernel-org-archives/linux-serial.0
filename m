From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] tty: serial: msm_serial: Don't require DT aliases
Date: Fri, 14 Nov 2014 10:39:21 -0800
Message-ID: <1415990361-8897-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:55527 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161587AbaKNSj0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2014 13:39:26 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, frowand.list@gmail.com, linux-serial@vger.kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Tyler Baker <tyler.baker@linaro.org>, Kevin Hilman <khilman@kernel.org>

If there isn't a DT alias then of_alias_get_id() will return
-ENODEV. This will cause the msm_serial driver to fail probe,
when we want to keep the previous behavior where we generated a
dynamic line number at probe time. Restore this behavior by
generating a dynamic id if the line number is still negative
after checking for an alias or in the non-DT case looking at the
.id field of the platform device.

Reported-by: Kevin Hilman <khilman@kernel.org>
Tested-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 09364dd8cf3a..d1bc6b6cbc70 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1046,14 +1046,14 @@ static int msm_serial_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	int irq, line;
 
-	if (pdev->id == -1)
-		pdev->id = atomic_inc_return(&msm_uart_next_id) - 1;
-
 	if (pdev->dev.of_node)
 		line = of_alias_get_id(pdev->dev.of_node, "serial");
 	else
 		line = pdev->id;
 
+	if (line < 0)
+		line = atomic_inc_return(&msm_uart_next_id) - 1;
+
 	if (unlikely(line < 0 || line >= UART_NR))
 		return -ENXIO;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

