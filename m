Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E8C43219
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359496AbhKZIXy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359391AbhKZIV3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE0141FE09;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsZzqcLLwJdqB/gy+j39yAdKJECbeikG3IISQvNAnQY=;
        b=GLvyyt1dQG5mA/IC+GoJHQjUQLkmQDs6vBJSmI1uwwKezHQjGJP7vx2Uqc15JxxofVIOK+
        ezk1/W/6pedgZ7b/2ime+yN3wzQn/Jhpqk/CdVj9/+2N3gusXsoxjFWAUlA8que822rZYN
        1N7OAymuKMmDd038ZbFk9bbn22OK7/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsZzqcLLwJdqB/gy+j39yAdKJECbeikG3IISQvNAnQY=;
        b=5sEFsrThPIGHpjp18U8J+FztstUyH2vZQwxNIwghpuYpgFJBWLepXJkgT14bk+/R+DPt4I
        II+zhLiv5h044fCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97E0FA3B88;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/23] tty: add kernel-doc for tty_standard_install
Date:   Fri, 26 Nov 2021 09:16:10 +0100
Message-Id: <20211126081611.11001-23-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is the only missing exported function which is not documented. Fix
it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 26b325e44c53..a4cfd254fda2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1275,6 +1275,14 @@ void tty_init_termios(struct tty_struct *tty)
 }
 EXPORT_SYMBOL_GPL(tty_init_termios);
 
+/**
+ * tty_standard_install - usual tty->ops->install
+ * @driver: the driver for the tty
+ * @tty: the tty
+ *
+ * If the @driver overrides @tty->ops->install, it still can call this function
+ * to perform the standard install operations.
+ */
 int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	tty_init_termios(tty);
-- 
2.34.0

