Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEE8C0015E
	for <linux-serial@archiver.kernel.org>; Sun,  6 Aug 2023 06:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHFGVH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Aug 2023 02:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFGVG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Aug 2023 02:21:06 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3028A1FCF;
        Sat,  5 Aug 2023 23:21:02 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 50ECA80A0;
        Sun,  6 Aug 2023 06:20:59 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: [PATCH] serial: core: Revert port_id use
Date:   Sun,  6 Aug 2023 09:20:50 +0300
Message-ID: <20230806062052.47737-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Guenter reports boot issues with duplicate sysfs entries for multiport
drivers. Let's go back to using port->line for now to fix the regression.

With this change, the serial core port device names are not correct for the
hardware specific 8250 single port drivers, but that's a cosmetic issue for
now.

Fixes: d962de6ae51f ("serial: core: Fix serial core port id to not use port->line")
Reported-by: Guenter Roeck <groeck7@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -151,7 +151,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->ctrl_id, port->port_id);
+				      port->ctrl_id, port->line);
 	if (err)
 		goto err_put_device;
 
-- 
2.41.0
