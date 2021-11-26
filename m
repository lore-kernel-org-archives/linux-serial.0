Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55875C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359653AbhKZIXa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF7821FE04;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TR7TjR+Sho5EP+V5vTFbmioVuPtYOX9szyslFJfnG4=;
        b=3cwYItjCDCpfiiRkHeZEjLKpAxyuPvPPpMoMhY6CYFp8SIStsjOE2LT+bzfOtoXQru/x7k
        PDO8O5k3Q5oXNe622vY6oRPjJhf4su003BhqHNMHn3V+/qA1RiDYjV/V5gEjlT2mR0wq5W
        INrA3BaFtivYr42qXlz7vDeWh7Pou3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TR7TjR+Sho5EP+V5vTFbmioVuPtYOX9szyslFJfnG4=;
        b=oL2e64m56mXNvv8vTGKLv6GRIHuADJsRami1eXaplnbNH3zCizqzRd5GSpYkYJX8KDgWLi
        ZLraMkB57AqstYCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A6C71A3B81;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/23] tty: add kernel-doc for more tty_driver functions
Date:   Fri, 26 Nov 2021 09:16:05 +0100
Message-Id: <20211126081611.11001-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The only documented function for tty_driver structure
allocation/registration was __tty_alloc_driver(). Fix highlighting in
that comment.

And add kernel-doc headers to all tty_driver_kref_put(),
tty_register_driver(), and tty_unregister_driver() -- i.e. the main
ones. More to follow later.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index b23269eb0cba..26b325e44c53 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3394,13 +3394,22 @@ static void destruct_tty_driver(struct kref *kref)
 	kfree(driver);
 }
 
+/**
+ * tty_driver_kref_put -- drop a reference to a tty driver
+ * @driver: driver of which to drop the reference
+ *
+ * The final put will destroy and free up the driver.
+ */
 void tty_driver_kref_put(struct tty_driver *driver)
 {
 	kref_put(&driver->kref, destruct_tty_driver);
 }
 EXPORT_SYMBOL(tty_driver_kref_put);
 
-/*
+/**
+ * tty_register_driver -- register a tty driver
+ * @driver: driver to register
+ *
  * Called by a tty driver to register itself.
  */
 int tty_register_driver(struct tty_driver *driver)
@@ -3462,7 +3471,10 @@ int tty_register_driver(struct tty_driver *driver)
 }
 EXPORT_SYMBOL(tty_register_driver);
 
-/*
+/**
+ * tty_unregister_driver -- unregister a tty driver
+ * @driver: driver to unregister
+ *
  * Called by a tty driver to unregister itself.
  */
 void tty_unregister_driver(struct tty_driver *driver)
-- 
2.34.0

