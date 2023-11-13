Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C912C4167B
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 08:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjKMIIT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 03:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIIS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 03:08:18 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D19D410F5;
        Mon, 13 Nov 2023 00:08:09 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 33F3E816E;
        Mon, 13 Nov 2023 08:08:07 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] serial: core: Revert checks for tx runtime PM state
Date:   Mon, 13 Nov 2023 10:07:53 +0200
Message-ID: <20231113080758.30346-2-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113080758.30346-1-tony@atomide.com>
References: <20231113080758.30346-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 81a61051e0ce5fd7e09225c0d5985da08c7954a7.

With tty and serdev controller moved to be children of the serial core
port device, runtime PM usage count of the serdev controller now
propagates to the serial hardware controller parent device as expected.

Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
 	 * enabled, serial_port_runtime_resume() calls start_tx() again
 	 * after enabling the device.
 	 */
-	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
+	if (pm_runtime_active(&port_dev->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
-- 
2.42.1
