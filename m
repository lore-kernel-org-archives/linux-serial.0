Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE7C001E0
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 07:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHCHKp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjHCHKo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 03:10:44 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DB23FF;
        Thu,  3 Aug 2023 00:10:43 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3808380FE;
        Thu,  3 Aug 2023 07:10:41 +0000 (UTC)
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
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 1/1] serial: core: Fix serial_base_match() after fixing controller port name
Date:   Thu,  3 Aug 2023 10:10:32 +0300
Message-ID: <20230803071034.25571-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

While fixing DEVNAME to be more usable, I broke serial_base_match() as the
ctrl and port prefix for device names seemed unnecessary.

The prefixes are still needed by serial_base_match() to probe the serial
base controller port, and serial tx is now broken.

Let's fix the issue by checking against dev->type and drv->name instead
of the prefixes that are no longer in the DEVNAME.

Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.sang@intel.com
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1:
- Leave out magic numbers and use str_has_prefix() as suggested by Andy
  and Greg

- Improve patch description and add a link for Closes tag as suggested
  by Jiri

- Check the name against device_type name since we have it and leave
  out the changes to try to define names in the header because of the
  issues noted by Jiri

- Leave out Tested-by from Mark and Anders as the patch changed

---
 drivers/tty/serial/serial_base_bus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -29,9 +29,15 @@ static const struct device_type serial_port_type = {
 
 static int serial_base_match(struct device *dev, struct device_driver *drv)
 {
-	int len = strlen(drv->name);
+	if (dev->type == &serial_ctrl_type &&
+	    str_has_prefix(drv->name, serial_ctrl_type.name))
+		return 1;
 
-	return !strncmp(dev_name(dev), drv->name, len);
+	if (dev->type == &serial_port_type &&
+	    str_has_prefix(drv->name, serial_port_type.name))
+		return 1;
+
+	return 0;
 }
 
 static struct bus_type serial_base_bus_type = {
-- 
2.41.0
