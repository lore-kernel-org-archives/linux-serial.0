Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA8EC34050
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8238A208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSIlW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgBSIlW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9FDF5AEC5;
        Wed, 19 Feb 2020 08:41:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/24] n_hdlc: cleanup messages during registration
Date:   Wed, 19 Feb 2020 09:40:59 +0100
Message-Id: <20200219084118.26491-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1) n_hdlc prints two lines during registration. Squeeze it into one.
2) prefix the error message with "N_HDLC: ", so that it's clear which
   ldisc failed to register.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index b651b5ba64ee..87f22e57e4f6 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -899,13 +899,13 @@ static int __init n_hdlc_init(void)
 	else if (maxframe > 65535)
 		maxframe = 65535;
 
-	pr_info("HDLC line discipline maxframe=%d\n", maxframe);
-
 	status = tty_register_ldisc(N_HDLC, &n_hdlc_ldisc);
 	if (!status)
-		pr_info("N_HDLC line discipline registered.\n");
+		pr_info("N_HDLC line discipline registered with maxframe=%d\n",
+				maxframe);
 	else
-		pr_err("error registering line discipline: %d\n", status);
+		pr_err("N_HDLC: error registering line discipline: %d\n",
+				status);
 
 	return status;
 	
-- 
2.25.0

