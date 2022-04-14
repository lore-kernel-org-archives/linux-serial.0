Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8DC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiDNJqU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiDNJqP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:15 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:50 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C570924
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:43:50 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220414094242f3bd7b303f1dd5c7c3
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JjX0QExE5G0gdz7UMXnS8e0N4K1XjQpP52q6ISsyKsU=;
 b=YFV5IXw4YFUyNLztxoQnz4iwDHjU2ZZ7ie3Yvvn5YDEXtidCy8U1db6wpK47Kzd3mecqGe
 GLMIjIN03UMbs9aDhv3ztElAX7nYURG7S61RPancztV4uzuyo8HianLsTIAbwhMMzWQlCIOc
 7yRp2aaB+nIUnJr6xLxtwdXEBGQvg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 05/20] tty: n_gsm: fix wrong signal octet encoding in convergence layer type 2
Date:   Thu, 14 Apr 2022 02:42:10 -0700
Message-Id: <20220414094225.4527-5-daniel.starke@siemens.com>
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
the newer 27.010 here. Chapter 5.5.2 describes that the signal octet in
convergence layer type 2 can be either one or two bytes. The length is
encoded in the EA bit. This is set 1 for the last byte in the sequence.
gsmtty_modem_update() handles this correctly but gsm_dlci_data_output()
fails to set EA to 1. There is no case in which we encode two signal octets
as there is no case in which we send out a break signal.
Therefore, always set the EA bit to 1 for the signal octet to fix this.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index de97a3810731..3ba2505908e3 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -832,7 +832,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 			break;
 		case 2:	/* Unstructed with modem bits.
 		Always one byte as we never send inline break data */
-			*dp++ = gsm_encode_modem(dlci);
+			*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
 			break;
 		}
 		WARN_ON(kfifo_out_locked(&dlci->fifo, dp , len, &dlci->lock) != len);
-- 
2.25.1

