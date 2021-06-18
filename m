Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D32C49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB4F61209
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhFRGTS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47306 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhFRGR6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 78BAF1FE08;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vkQegQCDa6RbYkbdZNTRf/A5yYN3NJAvIBIZzX/CoY=;
        b=1QAWiFZqLeDkBeVGlMYr5Z7RWJJ9JiKw7BYs0yJwIokUOoe6LfPSDUu0PykSVPeerF4UT4
        MPtSz8zSjRm6QQGOA+Vf9v/WXgCgYbdImgAf7b2Y3QCkhAO3b2hiw12BSeu0a3L/nVuYk7
        wvzFMWEFPCEgLavPBY6l9O5p/Jni9lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vkQegQCDa6RbYkbdZNTRf/A5yYN3NJAvIBIZzX/CoY=;
        b=/YvzfCHrf7xKdhuRUXUCyDNYRCZXoWm1ESjbsT++4vv2xvUKrAcEp1Yd7T87a4dg3lAGan
        LppuDkeaBky920Bg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F926A3BA3;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 67/70] mxser: Documentation, remove traces of callout device
Date:   Fri, 18 Jun 2021 08:15:13 +0200
Message-Id: <20210618061516.662-68-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Callout devices are ancient history, so remove its traces from mxser's
documentation.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 .../driver-api/serial/moxa-smartio.rst        | 46 +++++--------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/Documentation/driver-api/serial/moxa-smartio.rst b/Documentation/driver-api/serial/moxa-smartio.rst
index aedda2546242..3a0a8b502898 100644
--- a/Documentation/driver-api/serial/moxa-smartio.rst
+++ b/Documentation/driver-api/serial/moxa-smartio.rst
@@ -147,13 +147,7 @@ or::
    run the driver. If you prefer module driver, please refer to 3.4.
    If static driver is required, please refer to 3.5.
 
-Dialin and callout port
------------------------
-
-   This driver remains traditional serial device properties. There are
-   two special file name for each serial port. One is dial-in port
-   which is named "ttyMxx". For callout port, the naming convention
-   is "cumxx".
+   The device node is named "ttyMxx".
 
 Device naming when more than 2 boards installed
 -----------------------------------------------
@@ -161,18 +155,13 @@ Device naming when more than 2 boards installed
    Naming convention for each Smartio/Industio multiport board is
    pre-defined as below.
 
-   ============ ===============       ==============
-   Board Num.	 Dial-in Port	      Callout port
-   1st board	ttyM0  - ttyM7	      cum0  - cum7
-   2nd board	ttyM8  - ttyM15       cum8  - cum15
-   3rd board	ttyM16 - ttyM23       cum16 - cum23
-   4th board	ttyM24 - ttym31       cum24 - cum31
-   ============ ===============       ==============
-
-.. note::
-
-   Under Kernel 2.6 and upper, the cum Device is Obsolete. So use ttyM*
-   device instead.
+   ============ ===============
+   Board Num.	Device node
+   1st board	ttyM0  - ttyM7
+   2nd board	ttyM8  - ttyM15
+   3rd board	ttyM16 - ttyM23
+   4th board	ttyM24 - ttyM31
+   ============ ===============
 
 3.4 Module driver configuration
 ===============================
@@ -204,13 +193,10 @@ Device naming when more than 2 boards installed
 	 # cd /moxa/mxser/driver
 	 # ./msmknod
 
-   This shell script will require the major number for dial-in
-   device and callout device to create tty device. You also need
-   to specify the total installed MOXA board number. Default major
-   numbers for dial-in device and callout device are 30, 35. If
-   you need to change to other number, please refer section "3.7"
-   for more detailed procedure.
-   Msmknod will delete any special files occupying the same device
+   This shell script will require the major number for the device. You also
+   need to specify the total installed MOXA board number. If you need to
+   change to other number, please refer section "3.7" for more detailed
+   procedure. Msmknod will delete any special files occupying the same device
    naming.
 
 3.4.2 Build the MOXA driver and utilities
@@ -516,11 +502,3 @@ msterm - Terminal Emulation
    Load Moxa driver fail, the major number may conflict with other devices.
    Please refer to previous section 3.7 to change a free major number for
    Moxa driver.
-
-   Error msg:
-              Couldn't install MOXA Smartio/Industio family callout driver!
-
-   Solution:
-   Load Moxa callout driver fail, the callout device major number may
-   conflict with other devices. Please refer to previous section 3.7 to
-   change a free callout device major number for Moxa driver.
-- 
2.32.0

