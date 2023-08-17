Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FFC41513
	for <linux-serial@archiver.kernel.org>; Thu, 17 Aug 2023 09:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbjHQJfB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349786AbjHQJen (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Aug 2023 05:34:43 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 02:34:10 PDT
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252E35B0
        for <linux-serial@vger.kernel.org>; Thu, 17 Aug 2023 02:34:10 -0700 (PDT)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20230817093256d3b60245526609b95d
        for <linux-serial@vger.kernel.org>;
        Thu, 17 Aug 2023 11:32:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bqMAjODLK3mjjebOSIQBSi40u+kU7athQOobAmxO108=;
 b=M/zLDqJn2/ZCqVxARIT5/0nDkEOJ0yccjkT3UBiAGxE0B/oifj871q3BHBVTICfREMrVdt
 dMV7yoHEH5FHPb3p2dWcvqPZTzGMA3w5kV8tcIY1zci5gzcB4gOfpJiPrUp6jkn5LyCdeNh3
 SFbsvdl9n1n9elLgYRXp1w6GQps+M=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 3/9] tty: n_gsm: remove unneeded initialization of ret in gsm_dlci_config
Date:   Thu, 17 Aug 2023 11:32:25 +0200
Message-Id: <20230817093231.2317-3-daniel.starke@siemens.com>
In-Reply-To: <20230817093231.2317-1-daniel.starke@siemens.com>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
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

v5 -> v6:
No changes.

Link: https://lore.kernel.org/all/20230517155704.5701-3-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index a4268515920e..f6d3c4766e47 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3279,7 +3279,6 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 {
-	int ret = 0;
 	int need_close = 0;
 	int need_restart = 0;
 
@@ -3358,7 +3357,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
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

