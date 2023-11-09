Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757C4C4167B
	for <linux-serial@archiver.kernel.org>; Thu,  9 Nov 2023 08:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjKIIux convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Nov 2023 03:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjKIIuu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Nov 2023 03:50:50 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE81FFB
        for <linux-serial@vger.kernel.org>; Thu,  9 Nov 2023 00:50:48 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=06912c668f=fe@dev.tdt.de>)
        id 1r10kR-001kJI-77
        for linux-serial@vger.kernel.org; Thu, 09 Nov 2023 09:50:47 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1r10kQ-00DSaI-SM
        for linux-serial@vger.kernel.org; Thu, 09 Nov 2023 09:50:46 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id A4B9C24004B
        for <linux-serial@vger.kernel.org>; Thu,  9 Nov 2023 09:50:46 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 696A4240049;
        Thu,  9 Nov 2023 09:50:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id E96FB211D4;
        Thu,  9 Nov 2023 09:50:45 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [Patch v8 2/6] leds: ledtrig-tty: free allocated ttyname buffer on deactivate
Date:   Thu,  9 Nov 2023 09:50:34 +0100
Message-ID: <20231109085038.371977-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231109085038.371977-1-fe@dev.tdt.de>
References: <20231109085038.371977-1-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-purgate-ID: 151534::1699519847-857377EA-184CCDDD/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ttyname buffer for the ledtrig_tty_data struct is allocated in the
sysfs ttyname_store() function. This buffer must be released on trigger
deactivation. This was missing and is thus a memory leak.

While we are at it, the tty handler in the ledtrig_tty_data struct should
also be returned in case of the trigger deactivation call.

Fixes: fd4a641ac88f ("leds: trigger: implement a tty trigger")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/leds/trigger/ledtrig-tty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index 8ae0d2d284af..3e69a7bde928 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -168,6 +168,10 @@ static void ledtrig_tty_deactivate(struct led_classdev *led_cdev)
 
 	cancel_delayed_work_sync(&trigger_data->dwork);
 
+	kfree(trigger_data->ttyname);
+	tty_kref_put(trigger_data->tty);
+	trigger_data->tty = NULL;
+
 	kfree(trigger_data);
 }
 
-- 
2.30.2

