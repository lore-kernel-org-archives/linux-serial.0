Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEFAC77B6E
	for <linux-serial@archiver.kernel.org>; Wed,  5 Apr 2023 05:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjDEFs5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Apr 2023 01:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjDEFsp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Apr 2023 01:48:45 -0400
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E7C4203
        for <linux-serial@vger.kernel.org>; Tue,  4 Apr 2023 22:48:44 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202304050548408aab6c99b987a8bbde
        for <linux-serial@vger.kernel.org>;
        Wed, 05 Apr 2023 07:48:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xxgQqLsGOzLe4pCbEfkz/EaZ+wxQSNX7N39w6RgURFA=;
 b=eZ3I4zrvFPqu1M2TRu3krk2dat6R4RsYQhkGqaGoZg8Dz6mJCvbWnek5gvnvQgcjpjAr2r
 bTRBnWepQHm+WBIGdWQ4PLzvhZn31PC0F9cp62IHtxLXazhDtRCbaI7ueuveVH6am0Qj7Hi+
 s6ni7+kz2sNpWRjDVWYpZGbw0OQ4I=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 4/9] tty: n_gsm: fix unneeded initialization of ret in gsm_dlci_config
Date:   Wed,  5 Apr 2023 07:47:25 +0200
Message-Id: <20230405054730.3850-4-daniel.starke@siemens.com>
In-Reply-To: <20230405054730.3850-1-daniel.starke@siemens.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The variable 'ret' is not used before assignment from gsm_activate_mux().
Still it gets initialized to zero at declaration.

Fix this as remarked in the link below by removing the initialization.

Fixes: edd5f60c3400 ("tty: n_gsm: fix mux activation issues in gsm_config()")
Link: https://lore.kernel.org/all/b42bc4d1-cc9d-d115-c981-aaa053bdc59f@kernel.org/

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index eb21ca583642..d42b92cbae88 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3276,7 +3276,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 {
-	int ret = 0;
+	int ret;
 	int need_close = 0;
 	int need_restart = 0;
 
-- 
2.34.1

