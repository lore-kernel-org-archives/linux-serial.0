Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5760C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 08:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbiDSIVL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiDSIVL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 04:21:11 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 01:18:24 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CC22B28
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 01:18:24 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2022041908172038cf06a992ee55007d
        for <linux-serial@vger.kernel.org>;
        Tue, 19 Apr 2022 10:17:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WEBaAnLNU2+Mj++ZJXNOKrBfTV4ItKWCiZtMh+pt86A=;
 b=VAmhMTHeikbWPhYF/T2fJmdlwfV7lIcfC/9mIxB+fTGd9PjMD7enVVfAa4X4jMIFYSrb9+
 H5Bu93fLMJO6TDiXGFeZMSdSh9t3dHpq9y9184Q+h8XAPTKIznMcH3wXLzOUENYm1Vdd34hu
 lbWqXUbxO1W9ESizQPilNZiDOZMZo=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 16/20] tty: n_gsm: clean up dead code in gsm_queue()
Date:   Tue, 19 Apr 2022 01:17:13 -0700
Message-Id: <20220419081713.5813-1-daniel.starke@siemens.com>
In-Reply-To: <YlkRO6fAPCuWyT1Y@kroah.com>
References: <YlkRO6fAPCuWyT1Y@kroah.com>
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

