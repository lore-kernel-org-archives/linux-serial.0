Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A111FCCA480
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 06:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiGAGTJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Jul 2022 02:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiGAGSo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 02:18:44 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC2369CD
        for <linux-serial@vger.kernel.org>; Thu, 30 Jun 2022 23:18:40 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202207010618382f505c66fd2f86938d
        for <linux-serial@vger.kernel.org>;
        Fri, 01 Jul 2022 08:18:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NZItoV2JfrOEDSXsB/rFEb+ZXLjiX0JTl5KZWK01kx8=;
 b=AjOZCN1obWj1cbB5EjyhXANHyAepWgti+u2MEKcwDlFLCW7X3HOnkqgwdc2qLeoVFWCHMT
 g1QsG51ap3zJO22uIC2WXuig7J0QOdu5lb8cfRB51l1VKr+B1ItV/yiuXjj8MZwbDYnCORio
 25ubbSvA4yrkL2MQQvtZV5xJSbEY8=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 7/9] tty: n_gsm: fix packet re-transmission without open control channel
Date:   Fri,  1 Jul 2022 08:16:50 +0200
Message-Id: <20220701061652.39604-7-daniel.starke@siemens.com>
In-Reply-To: <20220701061652.39604-1-daniel.starke@siemens.com>
References: <20220701061652.39604-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

In the current implementation control packets are re-transmitted even if
the control channel closed down during T2. This is wrong.
Check whether the control channel is open before re-transmitting any
packets. Note that control channel open/close is handled by T1 and not T2
and remains unaffected by this.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Stable backport remark has been removed compared to v3. No other changes applied.

Link: https://lore.kernel.org/all/20220530144512.2731-7-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b82efb63f4e6..9e4ada510c9f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1624,7 +1624,7 @@ static void gsm_control_retransmit(struct timer_list *t)
 	spin_lock_irqsave(&gsm->control_lock, flags);
 	ctrl = gsm->pending_cmd;
 	if (ctrl) {
-		if (gsm->cretries == 0) {
+		if (gsm->cretries == 0 || !gsm->dlci[0] || gsm->dlci[0]->dead) {
 			gsm->pending_cmd = NULL;
 			ctrl->error = -ETIMEDOUT;
 			ctrl->done = 1;
-- 
2.34.1

