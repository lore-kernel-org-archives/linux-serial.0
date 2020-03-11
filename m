Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C0C4CECE
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C262074E
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YWgfMjoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbgCKW5k (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:57:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387459AbgCKW5j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 18:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PCiYl8jR666DshQQRNv+R2qkNigB9QgWKdzsKsH5x+w=; b=YWgfMjoAcUsExi6qvUnmBOQEwg
        uJOucPZNu/S4MR23l6v2emKD92wgFBEbFvLcMJWqi5VD027Ug46qmCYv8uKHZVYwXvmtW5RDRJuFb
        GYnBqc3wb7mg891c9+ApNnyGCxpZ6331wbadPRLW4XxuBcYvrh/R9fGsaus6bhZ2VNDHvhbkm2Gr/
        cRpONWtzhQwavHZkbYrk/6UYOhbAbFdLbpK0ItgpPx1RMWl9+/Lwnl/ER8FTlpFQUnsSNg54NVOGx
        iIubAu6YCgw0I6s0k2rOILAB1O1qv9oQy7kdfRo466JKMjd+21CV1GGrap6ERFwnXpATjB8rlh1Un
        BFeE7bWA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCAIE-0001PR-RY; Wed, 11 Mar 2020 22:57:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 2/3 v2] tty: source all tty Kconfig files in one place
Date:   Wed, 11 Mar 2020 15:57:35 -0700
Message-Id: <20200311225736.32147-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311225736.32147-1-rdunlap@infradead.org>
References: <20200311225736.32147-1-rdunlap@infradead.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

'source' (include) all of the tty/*/Kconfig files from
drivers/tty/Kconfig instead of from drivers/char/Kconfig.
This consolidates them both in source code and in menu
presentation to the user.

Move hvc/Kconfig and serial/Kconfig 'source' lines into the
if TTY/endif block and remove the if TTY/endif blocks from
those 2 files.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
v2: move hvc/Kconfig & serial/Kconfig lines and drop their if/endif blocks

 drivers/char/Kconfig       |    5 -----
 drivers/tty/Kconfig        |    6 ++++++
 drivers/tty/hvc/Kconfig    |    3 ---
 drivers/tty/serial/Kconfig |    4 ----
 4 files changed, 6 insertions(+), 12 deletions(-)

--- linux-next-20200311.orig/drivers/char/Kconfig
+++ linux-next-20200311/drivers/char/Kconfig
@@ -7,9 +7,6 @@ menu "Character devices"
 
 source "drivers/tty/Kconfig"
 
-source "drivers/tty/serial/Kconfig"
-source "drivers/tty/serdev/Kconfig"
-
 config TTY_PRINTK
 	tristate "TTY driver to output user messages via printk"
 	depends on EXPERT && TTY
@@ -94,8 +91,6 @@ config PPDEV
 
 	  If unsure, say N.
 
-source "drivers/tty/hvc/Kconfig"
-
 config VIRTIO_CONSOLE
 	tristate "Virtio console"
 	depends on VIRTIO && TTY
--- linux-next-20200311.orig/drivers/tty/Kconfig
+++ linux-next-20200311/drivers/tty/Kconfig
@@ -477,4 +477,10 @@ config LDISC_AUTOLOAD
 	  dev.tty.ldisc_autoload sysctl, this configuration option will
 	  only set the default value of this functionality.
 
+source "drivers/tty/hvc/Kconfig"
+
+source "drivers/tty/serial/Kconfig"
+
 endif # TTY
+
+source "drivers/tty/serdev/Kconfig"
--- linux-next-20200311.orig/drivers/tty/hvc/Kconfig
+++ linux-next-20200311/drivers/tty/hvc/Kconfig
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-if TTY
 
 config HVC_DRIVER
 	bool
@@ -113,5 +112,3 @@ config HVCS
 	  will depend on arch specific APIs exported from hvcserver.ko
 	  which will also be compiled when this driver is built as a
 	  module.
-
-endif # TTY
--- linux-next-20200311.orig/drivers/tty/serial/Kconfig
+++ linux-next-20200311/drivers/tty/serial/Kconfig
@@ -3,8 +3,6 @@
 # Serial device configuration
 #
 
-if TTY
-
 menu "Serial drivers"
 	depends on HAS_IOMEM
 
@@ -1566,5 +1564,3 @@ endmenu
 
 config SERIAL_MCTRL_GPIO
 	tristate
-
-endif # TTY
