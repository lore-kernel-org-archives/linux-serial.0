From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] serial: 8250_dw: Add valid clk pointer check
Date: Tue,  7 May 2013 08:27:16 -0300
Message-ID: <1367926036-26399-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51332 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab3EGL13 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 07:27:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, jslaby@suse.cz, gregkh@linuxfoundation.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Commit ffc3ae6dd "serial: 8250_dw: Enable runtime PM" introduced runtime
PM management, which enables/disables the clk without checking if the clk
is valid. However, this driver allows to be probed without a defined clk,
using clock-frequency, as a fallback.

Therefore, on platforms that are device tree probed using clock-frequency
instead of clk, we get an ugly NULL pointer dereference.

This patch fixes it by simply adding a check before accessing the clk api.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/tty/serial/8250/8250_dw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index beaa283..0b0eef9 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -338,7 +338,8 @@ static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable_unprepare(data->clk);
 
 	return 0;
 }
@@ -347,7 +348,8 @@ static int dw8250_runtime_resume(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	clk_prepare_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_prepare_enable(data->clk);
 
 	return 0;
 }
-- 
1.8.1.5

