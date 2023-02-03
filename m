Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D0C05027
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 14:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjBCOut (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 09:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBCOus (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 09:50:48 -0500
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE928F519
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 06:50:44 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230203145042146a720e4c057e4841
        for <linux-serial@vger.kernel.org>;
        Fri, 03 Feb 2023 15:50:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2NyostHau00yFANqCpLq5nifgI6rwhrmtoY/jfHx2Is=;
 b=CJBGn6O5tt+YtviI7Rqvp915HSd/PvX58OE1ttGShpokhNS4cP2PVb4h+VmzX8aoU49BxQ
 xj/mpKUdVwkhDxpAZesf4Ci8fcGZYn9wBk0KMrFjyGqTysO8pDQRVR/BKTrDs9BeOoLWAg7t
 41VN7coSQdsxCGiw01BIdq6ZaNsfg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 1/4] tty: n_gsm: mark unusable ioctl structure fields accordingly
Date:   Fri,  3 Feb 2023 15:50:20 +0100
Message-Id: <20230203145023.6012-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

gsm_config and gsm_netconfig includes unused fields that have been included
to allow future extension without changing the structure size.
Unfortunately, no checks have been included for these field. The actual
value set by old user space code remains undefined.
This means that future extensions can not use these fields without breaking
old user space code which may set unexpected values.

Mark these fields accordingly to avoid breaking code changes.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 include/uapi/linux/gsmmux.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

v2 -> v3:
Split previous patch 1/3 into two commits as recommended in the review.
No other changes.

Link: https://lore.kernel.org/all/Y9vYxgGd6kC+ZIgR@kroah.com/

diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index cb8693b39cb7..785d6b253f6d 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -19,8 +19,7 @@ struct gsm_config
 	unsigned int mtu;
 	unsigned int k;
 	unsigned int i;
-	unsigned int unused[8];		/* Padding for expansion without
-					   breaking stuff */
+	unsigned int unused[8];	/* Can not be used */
 };
 
 #define GSMIOC_GETCONF		_IOR('G', 0, struct gsm_config)
@@ -29,9 +28,9 @@ struct gsm_config
 struct gsm_netconfig {
 	unsigned int adaption;  /* Adaption to use in network mode */
 	unsigned short protocol;/* Protocol to use - only ETH_P_IP supported */
-	unsigned short unused2;
+	unsigned short unused2;	/* Can not be used */
 	char if_name[IFNAMSIZ];	/* interface name format string */
-	__u8 unused[28];        /* For future use */
+	__u8 unused[28];        /* Can not be used */
 };
 
 #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
-- 
2.34.1

