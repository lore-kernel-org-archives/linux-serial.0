Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E619C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 20 Apr 2022 10:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377538AbiDTKR7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377524AbiDTKRx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Apr 2022 06:17:53 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 03:15:07 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725A2BE2
        for <linux-serial@vger.kernel.org>; Wed, 20 Apr 2022 03:15:05 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220420101401d7fcaa985445b90a4c
        for <linux-serial@vger.kernel.org>;
        Wed, 20 Apr 2022 12:14:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=w+mbL/67Hch5JUwEcTboXqb1l8rminXIVsrzq7Luffo=;
 b=Krsx5rnRuD4AR43fkbyB1prXGvQAjNyAVzM+oGDcml/1YXLY0bMF3Hh7NyRCuRSdxObq/G
 BNbJBngBQxCXbCQbfFotYkXk83isu4h3UqosezrfPuJpTBXOE+BmGI+O2fz2nifVqlHlSU1n
 1SkHcDw+IzRea+yZhwX1D1+jO7tHI=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 2/3] tty: n_gsm: clean up dead code in gsm_queue()
Date:   Wed, 20 Apr 2022 03:13:45 -0700
Message-Id: <20220420101346.3315-2-daniel.starke@siemens.com>
In-Reply-To: <20220420101346.3315-1-daniel.starke@siemens.com>
References: <20220420101346.3315-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Remove commented out code as it is never used and if anyone accidentally
turned it on, it would be broken.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 ----
 1 file changed, 4 deletions(-)

The commit title and message was adjusted as recommended in the remarks for
the original patch. This is only a cleanup now and not a fix. The remark
for backporting was also removed. The code change remains as it was
originally.
This is version 3 of the patch because the second version was missing the
change remarks.

Link: https://lore.kernel.org/all/YlkRO6fAPCuWyT1Y@kroah.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 07d03447cdfd..1b4077006744 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1894,10 +1894,6 @@ static void gsm_queue(struct gsm_mux *gsm)
 	case UI|PF:
 	case UIH:
 	case UIH|PF:
-#if 0
-		if (cr)
-			goto invalid;
-#endif
 		if (dlci == NULL || dlci->state != DLCI_OPEN) {
 			gsm_command(gsm, address, DM|PF);
 			return;
-- 
2.25.1

