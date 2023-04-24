Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52383C7EE20
	for <linux-serial@archiver.kernel.org>; Mon, 24 Apr 2023 07:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDXHyn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Apr 2023 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDXHyk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Apr 2023 03:54:40 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B14B10F3
        for <linux-serial@vger.kernel.org>; Mon, 24 Apr 2023 00:54:39 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230424075437a686bd5447297af012
        for <linux-serial@vger.kernel.org>;
        Mon, 24 Apr 2023 09:54:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=feocQKWZExwrMEVQOT46ezGWZ9/FaOQ9KuX24u8pJEU=;
 b=Ra3ZcsRewnbVNg6TqfmiSYS25wZ5890uajDaKA+3ceX2p56K7oTQxO6WL8gkTnF+PP7wJy
 PilADWXJyAObQVrZab2YKPzkx9OaoePOoEm426wR7RrcQqQWPuWkbtk1R9NFHYYyHHvMJwY5
 EI3Ze0nIE7AdYiEZM8pOBUpMuc7rU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 7/8] tty: n_gsm: cleanup gsm_control_command and gsm_control_reply
Date:   Mon, 24 Apr 2023 09:52:50 +0200
Message-Id: <20230424075251.5216-7-daniel.starke@siemens.com>
In-Reply-To: <20230424075251.5216-1-daniel.starke@siemens.com>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
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

v2 -> v3:
No changes.

Link: https://lore.kernel.org/all/20230420085017.7314-8-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 941489230f9f..6bfcaf8fe54c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1451,15 +1451,16 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
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
@@ -1478,14 +1479,15 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
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

