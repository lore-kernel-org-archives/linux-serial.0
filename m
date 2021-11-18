Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA9CC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B261A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbhKRHel (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbhKRHe3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87D4E217BA;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTeOOnQNO75JtVQW4CESGGZ4HTSK1TMhZTUI4ncNsMk=;
        b=FLqjvskEniwX23Glto6wCPPPWIW0fwUjkMdYFPt0aio8fkSQIN3OCu9gprEyTFHLKkD8Cv
        EjI42MqlhNSVfJ6CQCItjusR2uW9jd0bLiOhpBGuQ5MP6rjQ62pk3QKyAkVHTek9Y5MkF4
        tokEFXjjTzrCYhN+hZSwt0UIvug72xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTeOOnQNO75JtVQW4CESGGZ4HTSK1TMhZTUI4ncNsMk=;
        b=r0F+oj7TFLgEDE1iajFP/sGQ5sONiOn0TKs03Ww9CNHoHZ95caX9OnGt8Jl798nMmItkzb
        mk5JRfR30hwjAeCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 619E1A3B83;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/19] mxser: use tty_port_close() in mxser_close()
Date:   Thu, 18 Nov 2021 08:31:16 +0100
Message-Id: <20211118073125.12283-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Finally, the mxser_close() code in is mostly identical to
tty_port_close(), so replace the code by a single call to the function.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 4dafa16aa29c..6ab8899ada9c 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -896,29 +896,9 @@ static void mxser_flush_buffer(struct tty_struct *tty)
 	tty_wakeup(tty);
 }
 
-/*
- * This routine is called when the serial port gets closed.  First, we
- * wait for the last remaining data to be sent.  Then, we unlink its
- * async structure from the interrupt chain if necessary, and we free
- * that IRQ if nothing is left in the chain.
- */
 static void mxser_close(struct tty_struct *tty, struct file *filp)
 {
-	struct mxser_port *info = tty->driver_data;
-	struct tty_port *port = &info->port;
-
-	if (tty_port_close_start(port, tty, filp) == 0)
-		return;
-	mutex_lock(&port->mutex);
-	if (tty_port_initialized(port) && C_HUPCL(tty))
-		tty_port_lower_dtr_rts(port);
-	mxser_shutdown_port(port);
-	tty_port_set_initialized(port, 0);
-	mutex_unlock(&port->mutex);
-	/* Right now the tty_port set is done outside of the close_end helper
-	   as we don't yet have everyone using refcounts */	
-	tty_port_close_end(port, tty);
-	tty_port_tty_set(port, NULL);
+	tty_port_close(tty->port, tty, filp);
 }
 
 static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
-- 
2.33.1

