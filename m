Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B5C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C12060F58
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhINJPh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhINJPg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 09E5B1FDD8;
        Tue, 14 Sep 2021 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKo4iuOq73+bUNtI4yKJlmudRKyHwvKMnK09aennftc=;
        b=bfPz8iGJxaVHOCjIVpVMwtHnIo4pIR8piSYQLpWZ/igZotO2dIbhJXlLwZFGvRj1365wm4
        S6c7yzZW61Z0UBRn+1RbAR2o6RudLIbAwG64WNz9GQ+9a1XirDeQ0EsPbkfhBCZiFymUfh
        wdUoEnblJqI7BkA6jpZGYCZMDpROXEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKo4iuOq73+bUNtI4yKJlmudRKyHwvKMnK09aennftc=;
        b=QJvLKmdYUxFLXR8uHnZ0GkTnP+Eq+/VdFsJ7a2B6QrYQkk76XFhPDD8MRwTQocIj+t3qR1
        itMljLJuVDgbh5DQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE9E3A3B98;
        Tue, 14 Sep 2021 09:14:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 11/16] tty: drivers/usb/, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:10 +0200
Message-Id: <20210914091415.17918-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the former, so call the latter directly in the rest of
drivers/usb/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/class/cdc-acm.c            | 2 +-
 drivers/usb/gadget/function/u_serial.c | 2 +-
 drivers/usb/host/xhci-dbgtty.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 8bbd8e29e60d..eeea1ed7fd71 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -480,7 +480,7 @@ static void acm_process_read_urb(struct acm *acm, struct urb *urb)
 
 	tty_insert_flip_string(&acm->port, urb->transfer_buffer,
 			urb->actual_length);
-	tty_flip_buffer_push(&acm->port);
+	tty_schedule_flip(&acm->port);
 }
 
 static void acm_read_bulk_callback(struct urb *urb)
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 6f68cbeeee7c..39fa27b63cbd 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -426,7 +426,7 @@ static void gs_rx_push(struct work_struct *work)
 	 * so we won't get callbacks and can hold port_lock
 	 */
 	if (do_push)
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 
 
 	/* We want our data queue to become empty ASAP, keeping data
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 6e784f2fc26d..48b7e7f52d75 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -344,7 +344,7 @@ static void dbc_rx_push(struct tasklet_struct *t)
 	}
 
 	if (do_push)
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 
 	if (!list_empty(queue) && tty) {
 		if (!tty_throttled(tty)) {
-- 
2.33.0

