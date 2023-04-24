Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDEC7618E
	for <linux-serial@archiver.kernel.org>; Mon, 24 Apr 2023 07:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjDXHyl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Apr 2023 03:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjDXHyk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Apr 2023 03:54:40 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741310E2
        for <linux-serial@vger.kernel.org>; Mon, 24 Apr 2023 00:54:38 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202304240754364358eed21736ad7f11
        for <linux-serial@vger.kernel.org>;
        Mon, 24 Apr 2023 09:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qjQIn+HvmVUrb5AZ5u0C0kEC4MtX+YXbuwEE51kPmJA=;
 b=g4ekPUt7DHKdgaD2w3+YSP4VEx3pM64I89/4bb855ICW1UYYY7HE40PG0e1uIkdr40SIG8
 grVnfQnDP4Nj0sLMilqJfqvjSQUmkpSvWtMcwIVJdbd6c8LqYvO9r3EdxKmw8QmWkYASTBMq
 xnw9dr6jWG6M4/XFjoq1ANZbiaP4c=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 5/8] tty: n_gsm: increase malformed counter for malformed control frames
Date:   Mon, 24 Apr 2023 09:52:48 +0200
Message-Id: <20230424075251.5216-5-daniel.starke@siemens.com>
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

v2 -> v3:
No changes.

Link: https://lore.kernel.org/all/20230420085017.7314-6-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 6b6fafb1098a..10fc02133efa 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2455,8 +2455,10 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
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

