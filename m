Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E70C77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 20 Apr 2023 08:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjDTIyz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Apr 2023 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjDTIxr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Apr 2023 04:53:47 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F97290
        for <linux-serial@vger.kernel.org>; Thu, 20 Apr 2023 01:52:02 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202304200852017ead3f89a6c06438c9
        for <linux-serial@vger.kernel.org>;
        Thu, 20 Apr 2023 10:52:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XYVykcI9EtHEvwVp8QrpLutUdz6E6nO+3d071pliXpo=;
 b=BPrlmz2iLtFt4KgsBHX92M5GrD9Pt3OJMqVBvib3Io93kFjCTv048H+b+o9JGp6y5uauV0
 URbfPyELH+q3i8dtyQjSD8Vuace/REOIp4M2oTRWK0nKj7wklscF7p09uFQjB4D9hvHW8gmy
 fwuae2S8aP9bcOpkhr09thIbi/Scw=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 6/9] tty: n_gsm: increase malformed counter for malformed control frames
Date:   Thu, 20 Apr 2023 10:50:14 +0200
Message-Id: <20230420085017.7314-6-daniel.starke@siemens.com>
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

The malformed counter in gsm_mux is already increased in case of errors
detected in gsm_queue() and gsm1_receive(). gsm_dlci_command() also
detects a case for a malformed frame but does not increase the malformed
counter yet.

Fix this by also increasing the gsm_mux malformed counter in case of a
malformed frame in gsm_dlci_command().
Note that the malformed counter is not yet exposed and only set internally.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v1 -> v2:
Added remark to the commit message that the malformed counter is not yet
exposed to the user. This was remarked in the review.

Link: https://lore.kernel.org/all/AS4PR10MB589597931E257D7CACB984BCE0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1e97a41e6be9..cc7be05c37ce 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2454,8 +2454,10 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 	data += dlen;
 
 	/* Malformed command? */
-	if (clen > len)
+	if (clen > len) {
+		dlci->gsm->malformed++;
 		return;
+	}
 
 	if (command & 1)
 		gsm_control_message(dlci->gsm, command, data, clen);
-- 
2.34.1

