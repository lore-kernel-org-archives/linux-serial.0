Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0151CC43217
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359301AbhKZIXw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359387AbhKZIV2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6518E1FE07;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTtokjpAippHq+goLKPHeC6KR/s9ykM7J1nfpJjQoo8=;
        b=O5EFknxh0RGcasko9Y9V29riKyHf0YMZlUjrVphDVdM4XggRqgA06KyjQJg/EoJsWFPbFQ
        0Cs0PEnbKc1XZOV7yS0CLlFrRtgVM1IN8VMTve2Wn3/eS93e2onrOkzsN6+N/sbA7GBpfo
        KJzpgywod0MuSlA83e3ceUucbzeOTnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTtokjpAippHq+goLKPHeC6KR/s9ykM7J1nfpJjQoo8=;
        b=zxW9g3PkkMg339NAAz8A1ZXJHAzVloRxcn/LY3XQKuWwi8x+eDSVxAHpiyWRJxwArcMowm
        egOithNlpsFQzyAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3CCB7A3B81;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 20/23] tty: make tty_ldisc docs up-to-date
Date:   Fri, 26 Nov 2021 09:16:08 +0100
Message-Id: <20211126081611.11001-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some of the docs in this document were a bit obsolete. Clean it up a bit
and make it correspond to the current state.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/tty/tty_ldisc.rst | 39 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/Documentation/tty/tty_ldisc.rst b/Documentation/tty/tty_ldisc.rst
index 8e48ab72f965..69dee9ca6540 100644
--- a/Documentation/tty/tty_ldisc.rst
+++ b/Documentation/tty/tty_ldisc.rst
@@ -6,31 +6,30 @@ TTY Line Discipline
 
 .. contents:: :local:
 
-Line disciplines are registered with tty_register_ldisc() passing the
-discipline number and the ldisc structure. At the point of registration the
-discipline must be ready to use and it is possible it will get used before
-the call returns success. If the call returns an error then it won't get
-called. Do not re-use ldisc numbers as they are part of the userspace ABI
-and writing over an existing ldisc will cause demons to eat your computer.
-After the return the ldisc data has been copied so you may free your own
-copy of the structure. You must not re-register over the top of the line
+Registration
+============
+
+Line disciplines are registered with tty_register_ldisc() passing the ldisc
+structure. At the point of registration the discipline must be ready to use and
+it is possible it will get used before the call returns success. If the call
+returns an error then it won’t get called. Do not re-use ldisc numbers as they
+are part of the userspace ABI and writing over an existing ldisc will cause
+demons to eat your computer. You must not re-register over the top of the line
 discipline even with the same data or your computer again will be eaten by
-demons.
-
-In order to remove a line discipline call tty_unregister_ldisc().
-In ancient times this always worked. In modern times the function will
-return -EBUSY if the ldisc is currently in use. Since the ldisc referencing
-code manages the module counts this should not usually be a concern.
+demons. In order to remove a line discipline call tty_unregister_ldisc().
 
 Heed this warning: the reference count field of the registered copies of the
 tty_ldisc structure in the ldisc table counts the number of lines using this
-discipline. The reference count of the tty_ldisc structure within a tty
-counts the number of active users of the ldisc at this instant. In effect it
-counts the number of threads of execution within an ldisc method (plus those
-about to enter and exit although this detail matters not).
+discipline. The reference count of the tty_ldisc structure within a tty counts
+the number of active users of the ldisc at this instant. In effect it counts
+the number of threads of execution within an ldisc method (plus those about to
+enter and exit although this detail matters not).
+
+.. kernel-doc:: drivers/tty/tty_ldisc.c
+   :identifiers: tty_register_ldisc tty_unregister_ldisc
 
-Line Discipline Methods
-=======================
+Line Discipline Operations Reference
+====================================
 
 .. kernel-doc:: include/linux/tty_ldisc.h
    :identifiers: tty_ldisc_ops
-- 
2.34.0

