Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84A5C7EE20
	for <linux-serial@archiver.kernel.org>; Thu, 20 Apr 2023 08:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjDTIy5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Apr 2023 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjDTIxt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Apr 2023 04:53:49 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFB6A69
        for <linux-serial@vger.kernel.org>; Thu, 20 Apr 2023 01:52:04 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202304200852025a934fdd58a7a110db
        for <linux-serial@vger.kernel.org>;
        Thu, 20 Apr 2023 10:52:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FQjnwT4CT+XNGnJ3WBAhjs5ayKF62EGFFFeFaI41i8I=;
 b=bnvnMnlIfut6yLSrozGMcqdaqDs/eAsmxbnwQ7Apewajc35SQNMuMn4hsGNfjX/cnX9BDj
 7tut/vgImnLi21LmFJeMgGqlanpYQJ7/ksJn3oFpriwu93Rdgi0nKVQ7OY5CDSAHSgQbNS+g
 PnCdpiiTTu1wligw9fSVAkjjcxQu4=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 8/9] tty: n_gsm: cleanup gsm_control_command and gsm_control_reply
Date:   Thu, 20 Apr 2023 10:50:16 +0200
Message-Id: <20230420085017.7314-8-daniel.starke@siemens.com>
In-Reply-To: <20230420085017.7314-1-daniel.starke@siemens.com>
References: <20230420085017.7314-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

There are multiple places in gsm_control_command and gsm_control_reply that
derive the specific DLCI handle directly out of the DLCI table in gsm.

Add a local variable which holds this handle and use it instead to improve
code readability.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

v1 -> v2:
Moved from patch 9 to 8 as suggested in the review.

Link: https://lore.kernel.org/all/AS4PR10MB58953283D47928E265313660E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ce06cbbe79af..bd6bddb185b9 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1450,15 +1450,16 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 			       int dlen)
 {
 	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
 
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return -ENOMEM;
 
 	msg->data[0] = (cmd << 1) | CR | EA;	/* Set C/R */
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
-	gsm_data_queue(gsm->dlci[0], msg);
+	gsm_data_queue(dlci, msg);
 
 	return 0;
 }
@@ -1477,14 +1478,15 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 					int dlen)
 {
 	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
 
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return;
 	msg->data[0] = (cmd & 0xFE) << 1 | EA;	/* Clear C/R */
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
-	gsm_data_queue(gsm->dlci[0], msg);
+	gsm_data_queue(dlci, msg);
 }
 
 /**
-- 
2.34.1

