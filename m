Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DADC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359447AbhKZIXi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33066 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359361AbhKZIV2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2C2BB1FE06;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hW4l7Gu6zB8opfdTwt/0692qTJre6msn2Uj5oNNr9HY=;
        b=zLkrmASw6kp9gxELvL7mWSkXsNoJ2TdtClkEqsrUEC17yh+1ZPxGhSd/MeDSvYNhZkSy96
        rtio3vTE1C1OmOOD9wyLRWf65hW+Bj1IIFXUOPTQHdCEFu2Pj3p/611UnXXpnhEwXR7Ddn
        dtHBxrR8gjpae48vb6swNP9lWLa8NlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hW4l7Gu6zB8opfdTwt/0692qTJre6msn2Uj5oNNr9HY=;
        b=gsH5GZM0BIPUaHUGdkSX4DIyoFo/SnjRC0YD6kWSpIHcTiy+kPkiNqR3Qz8EqDAA558fuv
        IPnyuUmRDD/HRJAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D4FBA3B85;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/23] tty: move tty_ldisc docs to new Documentation/tty/
Date:   Fri, 26 Nov 2021 09:16:07 +0100
Message-Id: <20211126081611.11001-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Create a new directory in Documentation/ called tty. We will create more
documents in it in the next patches, so let's have this one in the very
same place.

Change title accordingly and all the headers. This is the way what other
documents look like in this directory in the next patches. So make this
unified.

And add a TOC.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/index.rst     |  1 -
 .../serial/tty.rst => tty/tty_ldisc.rst}      | 23 ++++++++-----------
 2 files changed, 10 insertions(+), 14 deletions(-)
 rename Documentation/{driver-api/serial/tty.rst => tty/tty_ldisc.rst} (91%)

diff --git a/Documentation/driver-api/serial/index.rst b/Documentation/driver-api/serial/index.rst
index 8f7d7af3b90b..7eb21a695fc3 100644
--- a/Documentation/driver-api/serial/index.rst
+++ b/Documentation/driver-api/serial/index.rst
@@ -9,7 +9,6 @@ Support for Serial devices
 
 
     driver
-    tty
 
 Serial drivers
 ==============
diff --git a/Documentation/driver-api/serial/tty.rst b/Documentation/tty/tty_ldisc.rst
similarity index 91%
rename from Documentation/driver-api/serial/tty.rst
rename to Documentation/tty/tty_ldisc.rst
index 65f971e3aada..8e48ab72f965 100644
--- a/Documentation/driver-api/serial/tty.rst
+++ b/Documentation/tty/tty_ldisc.rst
@@ -1,13 +1,10 @@
-=================
-The Lockronomicon
-=================
+.. SPDX-License-Identifier: GPL-2.0
 
-Your guide to the ancient and twisted locking policies of the tty layer and
-the warped logic behind them. Beware all ye who read on.
+===================
+TTY Line Discipline
+===================
 
-
-Line Discipline
----------------
+.. contents:: :local:
 
 Line disciplines are registered with tty_register_ldisc() passing the
 discipline number and the ldisc structure. At the point of registration the
@@ -33,25 +30,25 @@ counts the number of threads of execution within an ldisc method (plus those
 about to enter and exit although this detail matters not).
 
 Line Discipline Methods
------------------------
+=======================
 
 .. kernel-doc:: include/linux/tty_ldisc.h
    :identifiers: tty_ldisc_ops
 
 Driver Access
-^^^^^^^^^^^^^
+=============
 
 Line discipline methods can call the methods of the underlying hardware driver.
 These are documented as a part of struct tty_operations.
 
-Flags
-^^^^^
+TTY Flags
+=========
 
 Line discipline methods have access to :c:member:`tty_struct.flags` field. See
 :doc:`tty_struct`.
 
 Locking
-^^^^^^^
+=======
 
 Callers to the line discipline functions from the tty layer are required to
 take line discipline locks. The same is true of calls from the driver side
-- 
2.34.0

