Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8138C4332F
	for <linux-serial@archiver.kernel.org>; Tue,  3 May 2022 06:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiECGfJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 May 2022 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiECGfC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 May 2022 02:35:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B83F381B2;
        Mon,  2 May 2022 23:31:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 562DB1F74C;
        Tue,  3 May 2022 06:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSVRncgXdxhSPnVu1HuIPNNJumIspe/QnB20qz/St8A=;
        b=livOX+eqi0gqvVmRuIoSMusLlBiZsQJe79CErg/SCugI6OfWuMX39YzG98FzqW0zWQldFk
        MRrH57oXVUw7ZHCQHnL6nIAeOjHep/yuG65lsZvREaP5FGZnKzcirGpOXUV0kN0deqCewU
        xQC+oDAk211IIhDrB0RXRBxBxaHKwu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSVRncgXdxhSPnVu1HuIPNNJumIspe/QnB20qz/St8A=;
        b=iy/H9Iu8/5AC8ky2uJdj5hCRPtHFsk/ianeeCPqclSW6ijOcXHI/oERBEz2bRJzcfCWieY
        kunN/D42qT4fJaDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 216502C141;
        Tue,  3 May 2022 06:31:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/11] serial: pic32: don't assign pic32_sport::cts_gpio twice
Date:   Tue,  3 May 2022 08:31:19 +0200
Message-Id: <20220503063122.20957-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503063122.20957-1-jslaby@suse.cz>
References: <20220503063122.20957-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sport->cts_gpio is first assigned -EINVAL and few lines below using
of_get_named_gpio(). Remove the first (useless) assignment.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index c3b4fd0b5b76..08e79d7f34f7 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -892,7 +892,6 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	sport->irq_rx		= irq_of_parse_and_map(np, 1);
 	sport->irq_tx		= irq_of_parse_and_map(np, 2);
 	sport->clk		= devm_clk_get(&pdev->dev, NULL);
-	sport->cts_gpio		= -EINVAL;
 	sport->dev		= &pdev->dev;
 
 	/* Hardware flow control: gpios
-- 
2.36.0

