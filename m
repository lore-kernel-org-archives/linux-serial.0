Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9F7C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiDNJqX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241906AbiDNJqQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:16 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:52 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D8870CFD
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:43:52 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220414094244c15898557eeba214ba
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=E2kKLS8GAqSiKmByiMNtnOdHF+DKznLVuFly18vV66E=;
 b=Lce7cR9J8iUMbPujFITx6yqHBjcQuhmRgD1nb6f5DEcqcMrrhRrxwRNLaQhcmDCd+mD/Co
 /zhSiKH80FygpTw+DRXT1PEi5myPXyfdxJ2gF+a80ji9q9m5ZdUCeTmOFGcAACiNG8594fHL
 iN3/yQ+LyD89rQILExEF7HV/ZDCqs=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 08/20] tty: n_gsm: fix insufficient txframe size
Date:   Thu, 14 Apr 2022 02:42:13 -0700
Message-Id: <20220414094225.4527-8-daniel.starke@siemens.com>
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
the newer 27.010 here. Chapter 5.7.2 states that the maximum frame size
(N1) refers to the length of the information field (i.e. user payload).
However, 'txframe' stores the whole frame including frame header, checksum
and start/end flags. We also need to consider the byte stuffing overhead.
Define constant for the protocol overhead and adjust the 'txframe' size
calculation accordingly to reserve enough space for a complete mux frame
including byte stuffing for advanced option mode. Note that no byte
stuffing is applied to the start and end flag.
Also use MAX_MTU instead of MAX_MRU as this buffer is used for data
transmission.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 2e3da8a4697e..cc90b03ce005 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -73,6 +73,8 @@ module_param(debug, int, 0600);
  */
 #define MAX_MRU 1500
 #define MAX_MTU 1500
+/* SOF, ADDR, CTRL, LEN1, LEN2, ..., FCS, EOF */
+#define PROT_OVERHEAD 7
 #define	GSM_NET_TX_TIMEOUT (HZ*10)
 
 /*
@@ -2264,7 +2266,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 		kfree(gsm);
 		return NULL;
 	}
-	gsm->txframe = kmalloc(2 * MAX_MRU + 2, GFP_KERNEL);
+	gsm->txframe = kmalloc(2 * (MAX_MTU + PROT_OVERHEAD - 1), GFP_KERNEL);
 	if (gsm->txframe == NULL) {
 		kfree(gsm->buf);
 		kfree(gsm);
-- 
2.25.1

