Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97ADC32774
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 06:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiHWGZO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 02:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbiHWGZM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 02:25:12 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 23:25:10 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14DD3FA34
        for <linux-serial@vger.kernel.org>; Mon, 22 Aug 2022 23:25:10 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220823062404daa3899c154b96617e
        for <linux-serial@vger.kernel.org>;
        Tue, 23 Aug 2022 08:24:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B1dzZJlG7TGF0lm6bL2tVAEmM2Y6LezQL41zIAhlggg=;
 b=TtaJR7vSW7D6Y/VxG1HyJYEHVlVaDnw2woliDZikEja25884j+ACb82mSpemqAH4lzSrsk
 aO8NAplhcNQBNWkVoG0E/3ioNiN/rW4gV1vZzC6hVpbe6InEtfsP9ed91TFwPiQN4b3t2wHp
 Rh7yTln0g1gLzzo81iIL2QUoSaUMM=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 2/6] tty: n_gsm: name gsm tty device minors
Date:   Tue, 23 Aug 2022 08:22:55 +0200
Message-Id: <20220823062259.4754-2-daniel.starke@siemens.com>
In-Reply-To: <20220823062259.4754-1-daniel.starke@siemens.com>
References: <20220823062259.4754-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Add a macro which defines the possible number of virtual devices for n_gsm
to improve code readability.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

No changes since v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5bf09d129357..ed399d57b197 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -164,6 +164,9 @@ struct gsm_dlci {
 	struct net_device *net; /* network interface, if created */
 };
 
+/* Total number of supported devices */
+#define GSM_TTY_MINORS		256
+
 /* DLCI 0, 62/63 are special or reserved see gsmtty_open */
 
 #define NUM_DLCI		64
@@ -3748,7 +3751,7 @@ static int __init gsm_init(void)
 		return status;
 	}
 
-	gsm_tty_driver = tty_alloc_driver(256, TTY_DRIVER_REAL_RAW |
+	gsm_tty_driver = tty_alloc_driver(GSM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_HARDWARE_BREAK);
 	if (IS_ERR(gsm_tty_driver)) {
 		pr_err("gsm_init: tty allocation failed.\n");
-- 
2.34.1

