Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861CC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C661A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhKRHei (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243855AbhKRHe3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5183E1FD39;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/QwmVIo4NuJ1aRYyOTf7oP5YEDe0VshbVIMT5meUs0=;
        b=K+rSW6AFrcPiKJ7UfJ3E6O2eCibCQab5QXNo73+USM9gKs91kLAmDC7OQ6iLon1DyUvjv8
        EKZPJpLxSf6sb/9gfFvFaOLYh0fS+gdMbN+nfuoO9DCyIs2De1O1tJoUTSZoRn5HDCFxOU
        huGrqvE6Sx0lC+epYgsRyDszF2LILPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/QwmVIo4NuJ1aRYyOTf7oP5YEDe0VshbVIMT5meUs0=;
        b=OTCDnkF+ancg1xwGfE6mdr5Gb4H2hJPX6Nw4FFvhrAI7t74a47xshfCQvlZp7S+DB+dEP1
        vQmRK3wjYYtCOFBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2BB01A3B84;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/19] mxser: don't flush buffer from mxser_close() directly
Date:   Thu, 18 Nov 2021 08:31:15 +0100
Message-Id: <20211118073125.12283-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I fail to see the point of calling mxser_flush_buffer() from
mxser_close():
1) The SW xmit buffer is freed in mxser_shutdown_port() right after the
   call to mxser_flush_buffer().  And all 'cnt', 'head', and 'tail' are
   properly initialized to 0 in mxser_activate().
2) The HW buffer is flushed in mxser_shutdown_port() via
   mxser_disable_and_clear_FIFO() too.

So the effect of doing it by mxser_flush_buffer() in mxser_close() is
none. Hence remove it, so that when we use tty_port_close() later, the
code is 1:1 identical.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 45ee1122a5f7..4dafa16aa29c 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -910,7 +910,6 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 	mutex_lock(&port->mutex);
-	mxser_flush_buffer(tty);
 	if (tty_port_initialized(port) && C_HUPCL(tty))
 		tty_port_lower_dtr_rts(port);
 	mxser_shutdown_port(port);
-- 
2.33.1

