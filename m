Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A3C11F76
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 02:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C77F613DC
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 02:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhGJCkM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jul 2021 22:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235608AbhGJCji (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jul 2021 22:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B21FA6124C;
        Sat, 10 Jul 2021 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625884527;
        bh=YBbsfupXMjTT6ifevQa5TsXdZ6/h/HIV/MLtHSlXhUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtR8czNAg2ruxX7meBTjc13MKKB7PAiX4OoTFLvfrcvk2Pq3XZXoslh4M2FpoKc7Z
         ki7K8bq4+OnFcRliy7Y8ddP/D0UbAsLMg0BKblS/yCKAd5ty4FFvn4hksXStw9nu5x
         mlJY4OzUKRWr+zmGdY0cr6NuGu2daVEEDCcEvIJjkMfynsCvIiAcUbVzsKxhf1IGLp
         AorCVFlU8ufDAzU8F1Scx9ErjIyBTrSf944rh/I/lecD+1dsfX+wG4irLvoOoS2Ht1
         TF/kLAK7uHlrJet5kedn6KFtlefWHqk+aBmsHDHDpXv/H5ksOJ/GWWuZAJSPnp9ewY
         8o9FhnXW4KUZw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/33] tty: serial: 8250: serial_cs: Fix a memory leak in error handling path
Date:   Fri,  9 Jul 2021 22:34:51 -0400
Message-Id: <20210710023516.3172075-9-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710023516.3172075-1-sashal@kernel.org>
References: <20210710023516.3172075-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit fad92b11047a748c996ebd6cfb164a63814eeb2e ]

In the probe function, if the final 'serial_config()' fails, 'info' is
leaking.

Add a resource handling path to free this memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/dc25f96b7faebf42e60fe8d02963c941cf4d8124.1621971720.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/serial_cs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 8106353ce7aa..38e8045a36cc 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -305,6 +305,7 @@ static int serial_resume(struct pcmcia_device *link)
 static int serial_probe(struct pcmcia_device *link)
 {
 	struct serial_info *info;
+	int ret;
 
 	dev_dbg(&link->dev, "serial_attach()\n");
 
@@ -319,7 +320,15 @@ static int serial_probe(struct pcmcia_device *link)
 	if (do_sound)
 		link->config_flags |= CONF_ENABLE_SPKR;
 
-	return serial_config(link);
+	ret = serial_config(link);
+	if (ret)
+		goto free_info;
+
+	return 0;
+
+free_info:
+	kfree(info);
+	return ret;
 }
 
 static void serial_detach(struct pcmcia_device *link)
-- 
2.30.2

