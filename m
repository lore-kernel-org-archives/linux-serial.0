Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D76C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiDNJso (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiDNJqn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:43 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:44:01 PDT
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CDD70928
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:44:01 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202204140942525a26cdd311193ec211
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qo+J4Lih8268JeqdwObz7YR4B/SLCefExJgGvrS1nSY=;
 b=jsHEiAIF2Jf6ldjL7SBTyTHT55mj4nYgv6c0+epwdy+uBGwb9KUizKzVG1KGiSJZZcx2q7
 uemSzfZw7idF4wiY2HiQgt2xYGgtcPtXPdzhuxi1/ei02mxHSQFJOk9RTEDjw/Dtbc91SCQ3
 9HqZDdg/aeWd/BrYVXjGyfEooWstE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 18/20] tty: n_gsm: fix implicit CR bit encoding in address field
Date:   Thu, 14 Apr 2022 02:42:23 -0700
Message-Id: <20220414094225.4527-18-daniel.starke@siemens.com>
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
the newer 27.010 here. Chapter 5.2.1.2 describes the encoding of the
address field within the frame header. It is made up of the DLCI address,
command/response (CR) bit and EA bit.
Use the predefined CR value instead of a plain 2 in alignment to the
remaining code and to make the encoding obvious.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1e135a71860f..ecd2ecc61b14 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -754,7 +754,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 
 	*--dp = msg->ctrl;
 	if (gsm->initiator)
-		*--dp = (msg->addr << 2) | 2 | EA;
+		*--dp = (msg->addr << 2) | CR | EA;
 	else
 		*--dp = (msg->addr << 2) | EA;
 	*fcs = gsm_fcs_add_block(INIT_FCS, dp , msg->data - dp);
-- 
2.25.1

