Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D491CC49EA3
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DFE60FE6
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhFRGS4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60222 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C48B821B4E;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5Gnrezmz3Bzu2npHjqRoddFJXVH2LBHHWxf0qe4Ju4=;
        b=RylYCkc9puEfh1exMaZFI6glnRtKULADzmRFkq0iGpZpNmQZvuGNGLTmvFf/EGd/Q0YIoJ
        nxrR1DN77zE2EBuCz206wiUIpKpTlfRLcK5+80+DcTEV4mO/j7OwWO/rm5QXKNNMcGI+OB
        yNyCQAc0xndWI3+6H4h5GxUUDsdNm2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5Gnrezmz3Bzu2npHjqRoddFJXVH2LBHHWxf0qe4Ju4=;
        b=h9b4d4yxIm49r0w4XFapImghrEs6Rk1BdQjVi3VqI8zhB9JWBN1TgxsnvragtzGsHCdMjc
        GArxBHDAq5m0aqDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9C173A3BCA;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 50/70] mxser: rework and simplify mxser_open
Date:   Fri, 18 Jun 2021 08:14:56 +0200
Message-Id: <20210618061516.662-51-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In mxser_open, tty->port is already set thanks to
tty_port_register_device in ->probe. So we can simply use container_of
to deduce the struct mxser_port's pointer. Thus avoiding divisions and
complex computations.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1e54e94a7ca6..ea5e61a5a173 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -856,15 +856,12 @@ static void mxser_shutdown_port(struct tty_port *port)
  */
 static int mxser_open(struct tty_struct *tty, struct file *filp)
 {
-	struct mxser_port *info;
-	int line = tty->index;
+	struct tty_port *tport = tty->port;
+	struct mxser_port *port = container_of(tport, struct mxser_port, port);
 
-	info = &mxser_boards[line / MXSER_PORTS_PER_BOARD].ports[line % MXSER_PORTS_PER_BOARD];
-	if (!info->ioaddr)
-		return -ENODEV;
+	tty->driver_data = port;
 
-	tty->driver_data = info;
-	return tty_port_open(&info->port, tty, filp);
+	return tty_port_open(tport, tty, filp);
 }
 
 static void mxser_flush_buffer(struct tty_struct *tty)
-- 
2.32.0

