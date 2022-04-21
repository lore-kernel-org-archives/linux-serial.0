Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31472C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 10:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388275AbiDUKUH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 06:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384007AbiDUKUD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 06:20:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247922509;
        Thu, 21 Apr 2022 03:17:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DB341215FF;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZqNTsTGUjNsjOXWwSBxVwhockoLbVfQoEn634ED5Z4=;
        b=0FxNZL5HhLq9tCrMGkbDDpDmY5GzJfFz0qrUZ4akBWbLbPo2pNQGXzSoEN1ZhGl3SLHckM
        o+ZEHzkPmqoNeoS6SNq/yC+AfoxCwEUYe9VukE4Aw9deYqDJAyMy9DfsXuP9HdWX27Cqru
        mS2u5VkzJavky7cG1qZMS+WGaldKu6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZqNTsTGUjNsjOXWwSBxVwhockoLbVfQoEn634ED5Z4=;
        b=WfF9pVinNH+uQGqZJH0uMmZgCduz+cxDRNNYpnmHVHzoAfBvgcBaF1DocVcYe0Jsh8b124
        m5aPxEBUCrsautCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B21E92C142;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/7] serial: pic32: make SERIAL_PIC32_CONSOLE depend on SERIAL_PIC32=y
Date:   Thu, 21 Apr 2022 12:17:07 +0200
Message-Id: <20220421101708.5640-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421101708.5640-1-jslaby@suse.cz>
References: <20220421101708.5640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pic32_uart contains this:
  #ifdef CONFIG_SERIAL_PIC32_CONSOLE
  ...
  console_initcall(pic32_console_init);
  ...
  core_initcall(pic32_late_console_init);
  ...
  #endif
  ...
  arch_initcall(pic32_uart_init);

When the driver is built as module, all three above become
module_init(). So if SERIAL_PIC32_CONSOLE is set while SERIAL_PIC32=m,
it results in the following build error:
  In file included from include/linux/device/driver.h:21,
                   from include/linux/device.h:32,
                   from include/linux/platform_device.h:13,
                   from drivers/tty/serial/pic32_uart.c:12:
  include/linux/module.h:131:49: error: redefinition of '__inittest'

So make sure SERIAL_PIC32_CONSOLE can be set only when SERIAL_PIC32=y --
similar as for other drivers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index dbac90e2e209..20cb103972fa 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -817,7 +817,7 @@ config SERIAL_PIC32
 
 config SERIAL_PIC32_CONSOLE
 	bool "PIC32 serial console support"
-	depends on SERIAL_PIC32
+	depends on SERIAL_PIC32=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you have a PIC32, this driver supports the putting a console on one
-- 
2.36.0

