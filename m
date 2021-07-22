Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41476C63793
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 11:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2490C61357
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 11:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhGVLLI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:11:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59388 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhGVLLI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 07:11:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2B1522262C;
        Thu, 22 Jul 2021 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626954702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=S6NcoCyW4nlsHKyDFur3SlXg0Nq3VcKQz1V531PspZA=;
        b=EaEXcudo4M+tANeuWzjPOAQz3jMllCidAjxP7i01GGKjTV8lLzbHpjsFu2Wzy+qdRa528f
        lA8QKlMHFGBQ6CjfdjXdQuyBzInNRuy3jfUhxFX2zQfzMeG83TB1FET62HJsGCNzeTwaH0
        5rHwrfAzuLJkoa15DPMYGFnTYo3l0Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626954702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=S6NcoCyW4nlsHKyDFur3SlXg0Nq3VcKQz1V531PspZA=;
        b=o+nMEeEz8ihrjXb64apZWkY2gDSIZTMYCkYC1MAyPabWuSD8QGJTG9WS117xlIgrqBXRnm
        lHV05SGzALAe6gBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D7AC7A3B84;
        Thu, 22 Jul 2021 11:51:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 1/2] cx20442: tty_ldisc_ops::write_wakeup is optional
Date:   Thu, 22 Jul 2021 13:51:40 +0200
Message-Id: <20210722115141.516-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

TTY layer does nothing if tty_ldisc_ops::write_wakeup is NULL, so there
is no need to implement an empty one in cx20442. Drop it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/cx20442.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index ec8d6e74b467..65c6b92d7b5f 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -279,11 +279,6 @@ static void v253_receive(struct tty_struct *tty, const unsigned char *cp,
 	}
 }
 
-/* Line discipline .write_wakeup() */
-static void v253_wakeup(struct tty_struct *tty)
-{
-}
-
 struct tty_ldisc_ops v253_ops = {
 	.name = "cx20442",
 	.owner = THIS_MODULE,
@@ -291,7 +286,6 @@ struct tty_ldisc_ops v253_ops = {
 	.close = v253_close,
 	.hangup = v253_hangup,
 	.receive_buf = v253_receive,
-	.write_wakeup = v253_wakeup,
 };
 EXPORT_SYMBOL_GPL(v253_ops);
 
-- 
2.32.0

