Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6383C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA0161247
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhIVIBL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:01:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37400 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhIVIBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E566221E8;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632297579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJ1vAHBSNPildf/4eP8o3NwX+hnWlE0EtKlIafdDkFQ=;
        b=YrBlItJ5Ek9BgnEf29+PO4KcXFA0UQ8fkGLWVRHd41dXlsuIokZdTy9XzSkPXwnhZyrCG1
        PiHNvO4SdXsulvnf7hKwPJ8D85c1dt30xV609EaNFc4gIcdpeYqYN9Xa/FfCD5IWxivz9O
        xSC05nrFf1DhaYr39Wqc0CCmjRhMiTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632297579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJ1vAHBSNPildf/4eP8o3NwX+hnWlE0EtKlIafdDkFQ=;
        b=7ZtSksxnSJ7tQ0K3VmCf2DJbyMVtLnYofkg3JhS8rAUkjR0N6qCZ2MBC3XPHVVdKNjHFDn
        xMxVgvm3OWZLsHDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE2A8A3B8D;
        Wed, 22 Sep 2021 07:59:38 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/7] mxser: simplify condition in mxser_receive_chars_new
Date:   Wed, 22 Sep 2021 09:59:33 +0200
Message-Id: <20210922075938.31390-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075938.31390-1-jslaby@suse.cz>
References: <20210922075938.31390-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_receive_chars_old() is used whenever MOXA_MUST_LSR_RERR is set in
status no matter the HW ID (the last 'if'). So there is no need for
another check of MOXA_MUST_LSR_RERR _with_ hwid == MOXA_MUST_MU860_HWID
(the third 'if').  Hence remove this subcase. That allows us to check
status on a single line with both UART_LSR_BRK_ERROR_BITS (from the
second 'if') and MOXA_MUST_LSR_RERR (the last 'if').

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index b9cc41782ce1..f907de56e08b 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1550,11 +1550,7 @@ static bool mxser_receive_chars_new(struct tty_struct *tty,
 
 	if (hwid == MOXA_OTHER_UART)
 		return false;
-	if (status & UART_LSR_BRK_ERROR_BITS)
-		return false;
-	if (hwid == MOXA_MUST_MU860_HWID && (status & MOXA_MUST_LSR_RERR))
-		return false;
-	if (status & MOXA_MUST_LSR_RERR)
+	if (status & (UART_LSR_BRK_ERROR_BITS | MOXA_MUST_LSR_RERR))
 		return false;
 
 	gdl = inb(port->ioaddr + MOXA_MUST_GDL_REGISTER);
-- 
2.33.0

