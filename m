Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E4C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387067AbiDUJBE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387058AbiDUJBC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C72B21242;
        Thu, 21 Apr 2022 01:58:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF22C210DC;
        Thu, 21 Apr 2022 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N641P0kZgH3xzco/f776cJFCpsaJCbMVK4k6vEfn5F8=;
        b=NVlgjse87Rw8XYQBCoEAA+sYONIrDlhsvi/MSR/TKmI33n1YUG/81Ns13hb5PIVZ3egGLH
        rbfaj0Bf3uW2Btp26ywFE8XJ9o6bgxJ2VxCr4PGW6MeBMt2sSFjl8xkfHQSdLwZwuDKZcx
        iBZbKpwsgVWAkP+tHY2L+DukBdCmlFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N641P0kZgH3xzco/f776cJFCpsaJCbMVK4k6vEfn5F8=;
        b=gQfk1+Np2N+mF/QFk/WYFavc/fCk6qaF0OnDPiL/lkafN4qhImEyF2jrEFp8ywlXl3Ziwx
        1a5r4X34/pYTrfAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86F202C141;
        Thu, 21 Apr 2022 08:58:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/10] serial: icom: use list_for_each_entry()
Date:   Thu, 21 Apr 2022 10:58:06 +0200
Message-Id: <20220421085808.24152-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421085808.24152-1-jslaby@suse.cz>
References: <20220421085808.24152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use list_for_each_entry() helper instead of explicit combo of
list_for_each() and list_entry().

Note that pos is used as a reference point in list_add_tail() in
icom_alloc_adapter(). This functionality remains as with an empty list,
cur_adapter_entry->icom_adapter_entry is still the list head.

This simplifies the code a bit.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 85ecc7dfac72..8701856e2a2e 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1675,7 +1675,6 @@ static int icom_alloc_adapter(struct icom_adapter
 	int adapter_count = 0;
 	struct icom_adapter *icom_adapter;
 	struct icom_adapter *cur_adapter_entry;
-	struct list_head *tmp;
 
 	icom_adapter = kzalloc(sizeof(struct icom_adapter), GFP_KERNEL);
 
@@ -1683,10 +1682,8 @@ static int icom_alloc_adapter(struct icom_adapter
 		return -ENOMEM;
 	}
 
-	list_for_each(tmp, &icom_adapter_head) {
-		cur_adapter_entry =
-		    list_entry(tmp, struct icom_adapter,
-			       icom_adapter_entry);
+	list_for_each_entry(cur_adapter_entry, &icom_adapter_head,
+			icom_adapter_entry) {
 		if (cur_adapter_entry->index != adapter_count) {
 			break;
 		}
@@ -1694,7 +1691,8 @@ static int icom_alloc_adapter(struct icom_adapter
 	}
 
 	icom_adapter->index = adapter_count;
-	list_add_tail(&icom_adapter->icom_adapter_entry, tmp);
+	list_add_tail(&icom_adapter->icom_adapter_entry,
+			&cur_adapter_entry->icom_adapter_entry);
 
 	*icom_adapter_ref = icom_adapter;
 	return 0;
@@ -1857,11 +1855,9 @@ static int icom_probe(struct pci_dev *dev,
 static void icom_remove(struct pci_dev *dev)
 {
 	struct icom_adapter *icom_adapter;
-	struct list_head *tmp;
 
-	list_for_each(tmp, &icom_adapter_head) {
-		icom_adapter = list_entry(tmp, struct icom_adapter,
-					  icom_adapter_entry);
+	list_for_each_entry(icom_adapter, &icom_adapter_head,
+			icom_adapter_entry) {
 		if (icom_adapter->pci_dev == dev) {
 			kref_put(&icom_adapter->kref, icom_kref_release);
 			return;
-- 
2.36.0

