Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D1C77B60
	for <linux-serial@archiver.kernel.org>; Wed, 26 Apr 2023 08:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbjDZIDj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Apr 2023 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbjDZIDg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Apr 2023 04:03:36 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035A3598
        for <linux-serial@vger.kernel.org>; Wed, 26 Apr 2023 01:03:32 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202304260803303979a9d9c3efaf709d
        for <linux-serial@vger.kernel.org>;
        Wed, 26 Apr 2023 10:03:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xx1dZ9evczfWs6mTbL4YlHvxtmGbUbagLFOnGgHTeoI=;
 b=XuUQJT2WG5DehG0o+Dj51+tV8lafeJCVbcaZuMDf8dYR67lzQL/AqNjJLnFn9gXOV71c/Q
 5AT1vNnUH+9cqPWiQuK8B4KYaNfrYKSXOHpvtzzdvyNcKN29LlzVz0HnjuDMxVvicFL1foqe
 Wg74gBZMyeFqdzevY96QvVERuEPtg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 3/8] tty: n_gsm: remove unneeded initialization of ret in gsm_dlci_config
Date:   Wed, 26 Apr 2023 10:03:10 +0200
Message-Id: <20230426080315.7595-3-daniel.starke@siemens.com>
In-Reply-To: <20230426080315.7595-1-daniel.starke@siemens.com>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
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

Fix this as remarked in the link below by moving the declaration to the
first assignment.

Link: https://lore.kernel.org/all/b42bc4d1-cc9d-d115-c981-aaa053bdc59f@kernel.org/

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

v3 -> v4:
No changes.

Link: https://lore.kernel.org/all/20230424075251.5216-3-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 66edcf65a4dd..ebb71957f783 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3277,7 +3277,6 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 {
-	int ret = 0;
 	int need_close = 0;
 	int need_restart = 0;
 
@@ -3356,7 +3355,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	 * and removing from the mux array
 	 */
 	if (gsm->dead) {
-		ret = gsm_activate_mux(gsm);
+		int ret = gsm_activate_mux(gsm);
 		if (ret)
 			return ret;
 		if (gsm->initiator)
-- 
2.34.1

