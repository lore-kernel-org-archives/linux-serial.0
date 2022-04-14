Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8902C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbiDNJq2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiDNJqW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:22 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:58 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47D70928
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:43:57 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202204140942471ddd26f6ef134ac4f6
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IcLHRU+efcjoQfVaV9TBgdWlIloiFFdBBfsACD8b0P4=;
 b=UuQbEAt8IsTTA+njB7yMJtq9W/HJ0+4/+DpqraT7mIznucdzM+LnD4plWVepM37FUHU/KE
 TSbH0gSr92Iqbi25w8Tz2i62uEEMmSVAaVerYbCqWWZNkdncVigSri89U3qSx2SCx5LSRbBm
 gR09K1bd7+tCSHY4mF6HKLAeQYysM=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 12/20] tty: n_gsm: fix wrong command frame length field encoding
Date:   Thu, 14 Apr 2022 02:42:17 -0700
Message-Id: <20220414094225.4527-12-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.4.6.1 states that each command frame shall
be made up from type, length and value. Looking for example in chapter
5.4.6.3.5 at the description for the encoding of a flow control on command
it becomes obvious, that the type and length field is always present
whereas the value may be zero bytes long. The current implementation omits
the length field if the value is not present. This is wrong.
Correct this by always sending the length in gsm_control_transmit().
So far only the modem status command (MSC) has included a value and encoded
its length directly. Therefore, also change gsmtty_modem_update().

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 628bda5f0622..903278145078 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1327,11 +1327,12 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 {
-	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 1, gsm->ftype);
+	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 2, gsm->ftype);
 	if (msg == NULL)
 		return;
-	msg->data[0] = (ctrl->cmd << 1) | 2 | EA;	/* command */
-	memcpy(msg->data + 1, ctrl->data, ctrl->len);
+	msg->data[0] = (ctrl->cmd << 1) | CR | EA;	/* command */
+	msg->data[1] = (ctrl->len << 1) | EA;
+	memcpy(msg->data + 2, ctrl->data, ctrl->len);
 	gsm_data_queue(gsm->dlci[0], msg);
 }
 
@@ -2957,19 +2958,17 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
 
 static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
-	u8 modembits[5];
+	u8 modembits[3];
 	struct gsm_control *ctrl;
 	int len = 2;
 
-	if (brk)
+	modembits[0] = (dlci->addr << 2) | 2 | EA;  /* DLCI, Valid, EA */
+	modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
+	if (brk) {
+		modembits[2] = (brk << 4) | 2 | EA; /* Length, Break, EA */
 		len++;
-
-	modembits[0] = len << 1 | EA;		/* Data bytes */
-	modembits[1] = dlci->addr << 2 | 3;	/* DLCI, EA, 1 */
-	modembits[2] = gsm_encode_modem(dlci) << 1 | EA;
-	if (brk)
-		modembits[3] = brk << 4 | 2 | EA;	/* Valid, EA */
-	ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len + 1);
+	}
+	ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len);
 	if (ctrl == NULL)
 		return -ENOMEM;
 	return gsm_control_wait(dlci->gsm, ctrl);
-- 
2.25.1

