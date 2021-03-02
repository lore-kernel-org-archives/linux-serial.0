Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E52C4160E
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCB564E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhCCCP6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:15:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835877AbhCBGYU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93A0FB02F;
        Tue,  2 Mar 2021 06:22:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 29/44] tty: xtensa/iss, drop serial_version & serial_name
Date:   Tue,  2 Mar 2021 07:21:59 +0100
Message-Id: <20210302062214.29627-29-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to print the information during module load. Neither to
print some artificial version. So drop these strings and a print.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/platforms/iss/console.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index af81a62faba6..1179011044a7 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -37,9 +37,6 @@ static struct timer_list serial_timer;
 
 static DEFINE_SPINLOCK(timer_lock);
 
-static char *serial_version = "0.1";
-static char *serial_name = "ISS serial driver";
-
 /*
  * This routine is called whenever a serial port is opened.  It
  * enables interrupts for a serial port, linking in its async structure into
@@ -149,7 +146,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 
 static int rs_proc_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "serinfo:1.0 driver:%s\n", serial_version);
+	seq_printf(m, "serinfo:1.0 driver:0.1\n");
 	return 0;
 }
 
@@ -172,8 +169,6 @@ int __init rs_init(void)
 
 	serial_driver = alloc_tty_driver(SERIAL_MAX_NUM_LINES);
 
-	pr_info("%s %s\n", serial_name, serial_version);
-
 	/* Initialize the tty_driver structure */
 
 	serial_driver->driver_name = "iss_serial";
-- 
2.30.1

