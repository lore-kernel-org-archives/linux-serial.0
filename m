Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9BC433E6
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A6864E76
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCCCIV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:08:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577481AbhCBGW4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:22:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 471C2AAC5;
        Tue,  2 Mar 2021 06:22:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/44] MAINTAINERS: orphan mxser
Date:   Tue,  2 Mar 2021 07:21:31 +0100
Message-Id: <20210302062214.29627-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I cannot maintain this driver for years due to missing HW. Let's orphan
the entry in MAINTAINERS. And likely drop the driver later as these
devices are likely gone from this world. Mxser provides different
(out-of-tree) drivers for their current devices.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 973a937386fa..24abc010d177 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12089,8 +12089,7 @@ F:	drivers/media/pci/meye/
 F:	include/uapi/linux/meye.h
 
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
-M:	Jiri Slaby <jirislaby@kernel.org>
-S:	Maintained
+S:	Orphan
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
-- 
2.30.1

