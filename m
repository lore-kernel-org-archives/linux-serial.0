Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01524C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiDNJsm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbiDNJqn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:43 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:44:01 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4A7004C
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:44:01 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202204140942543e580eba70988bc664
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=d8jKoM9faKsGDQmqC/btc4Rd+AthsQGvuIMNUMeUktA=;
 b=bnygzUD5p6LhzJ+6pWthHULcIJN48ylDv+Bvyl3FblVIRF+VXzJZnTWUwOH9Z3OZSE1tYH
 eyViCjnp2AZY4wZ8Nled9dCfHdzJlMDgDkDECHEfBYhYf88iOopLiNRbR8LYUc0rVNkwp70E
 LQqN0n4ufysRsTKmPQ7V+5Hipcxss=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 20/20] tty: n_gsm: fix incorrect UA handling
Date:   Thu, 14 Apr 2022 02:42:25 -0700
Message-Id: <20220414094225.4527-20-daniel.starke@siemens.com>
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
the newer 27.010 here. Chapter 5.4.4.2 states that any received unnumbered
acknowledgment (UA) with its poll/final (PF) bit set to 0 shall be
discarded. Currently, all UA frame are handled in the same way regardless
of the PF bit. This does not comply with the standard.
Remove the UA case in gsm_queue() to process only UA frames with PF bit set
to 1 to abide the standard.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1905a0fea89b..cf861598a646 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1871,7 +1871,6 @@ static void gsm_queue(struct gsm_mux *gsm)
 			}
 		}
 		break;
-	case UA:
 	case UA|PF:
 		if (cr == 0 || dlci == NULL)
 			break;
-- 
2.25.1

