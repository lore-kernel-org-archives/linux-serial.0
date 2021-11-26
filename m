Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF590C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbhKZIXx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33072 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359388AbhKZIV2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 919901FE08;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zizbo0v8V0/9goKyaDFNJbLnlQPJeSquNL/rl6aiDcA=;
        b=CE9z8pizxX7+jtQCM++acDf6AU86BlOO/w5HFrOkAd/ldI8+1QSrtrFLdiTiDtmxUEG8mK
        LlmN3cVpHH0kxCqF7VnqHT5XBBLUHKuaz0aUqCH9uGCxY+Rme39BVqMNtR2hFvvnK3+SFE
        Gugo12pZB/cdsRuGEluC8qolspvZk+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zizbo0v8V0/9goKyaDFNJbLnlQPJeSquNL/rl6aiDcA=;
        b=m/4yC/7S1pzthyIOQZ1awX0kSRteH78G9jAm9yPzHojQ2wWbF8B118Jab72E2jWgUY7l5x
        Wmfq2YpDKcS0GlBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A4BAA3B87;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 21/23] tty: more kernel-doc for tty_ldisc
Date:   Fri, 26 Nov 2021 09:16:09 +0100
Message-Id: <20211126081611.11001-22-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Extend and highlight tty_ldisc documentation for kernel-doc even more.

We don't need to describe tty_ldisc_ref* functions again. Instead, just
include their kernel-doc from code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/tty/tty_ldisc.rst | 42 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/Documentation/tty/tty_ldisc.rst b/Documentation/tty/tty_ldisc.rst
index 69dee9ca6540..65885d97595c 100644
--- a/Documentation/tty/tty_ldisc.rst
+++ b/Documentation/tty/tty_ldisc.rst
@@ -28,6 +28,12 @@ enter and exit although this detail matters not).
 .. kernel-doc:: drivers/tty/tty_ldisc.c
    :identifiers: tty_register_ldisc tty_unregister_ldisc
 
+Other Functions
+===============
+
+.. kernel-doc:: drivers/tty/tty_ldisc.c
+   :identifiers: tty_set_ldisc tty_ldisc_flush
+
 Line Discipline Operations Reference
 ====================================
 
@@ -53,31 +59,21 @@ Callers to the line discipline functions from the tty layer are required to
 take line discipline locks. The same is true of calls from the driver side
 but not yet enforced.
 
-Three calls are now provided::
-
-	ldisc = tty_ldisc_ref(tty);
-
-takes a handle to the line discipline in the tty and returns it. If no ldisc
-is currently attached or the ldisc is being closed and re-opened at this
-point then NULL is returned. While this handle is held the ldisc will not
-change or go away::
-
-	tty_ldisc_deref(ldisc)
-
-Returns the ldisc reference and allows the ldisc to be closed. Returning the
-reference takes away your right to call the ldisc functions until you take
-a new reference::
-
-	ldisc = tty_ldisc_ref_wait(tty);
-
-Performs the same function as tty_ldisc_ref except that it will wait for an
-ldisc change to complete and then return a reference to the new ldisc.
+.. kernel-doc:: drivers/tty/tty_ldisc.c
+   :identifiers: tty_ldisc_ref_wait tty_ldisc_ref tty_ldisc_deref
 
 While these functions are slightly slower than the old code they should have
 minimal impact as most receive logic uses the flip buffers and they only
 need to take a reference when they push bits up through the driver.
 
-A caution: The ldisc->open(), ldisc->close() and driver->set_ldisc
-functions are called with the ldisc unavailable. Thus tty_ldisc_ref will
-fail in this situation if used within these functions. Ldisc and driver
-code calling its own functions must be careful in this case.
+A caution: The :c:member:`tty_ldisc_ops.open()`,
+:c:member:`tty_ldisc_ops.close()` and :c:member:`tty_driver.set_ldisc()`
+functions are called with the ldisc unavailable. Thus tty_ldisc_ref() will fail
+in this situation if used within these functions.  Ldisc and driver code
+calling its own functions must be careful in this case.
+
+Internal Functions
+==================
+
+.. kernel-doc:: drivers/tty/tty_ldisc.c
+   :internal:
-- 
2.34.0

