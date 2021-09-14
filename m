Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D281C4167E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DBF60F58
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhINJPm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhINJPh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 47E81200E2;
        Tue, 14 Sep 2021 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txOd2IWUIzDSEFZp5372yeQmEvrfSft2wWeQObhBtmQ=;
        b=Ji4MUNTGGQyTZ+hFIkdlpNPwXoDGHzXXxeiGQdON33E6pNbzW2NNz4JwLSSygvyeVFt5mD
        jAYuWzaViaue1ATKk9rn29sxKWgt0g8c1sTzvmvwIqSBh95Jy1HQhWl+rAulc/PdEJKgRJ
        oLN9rqe/K1wnjGFqZFv+rbRhWZVGiGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txOd2IWUIzDSEFZp5372yeQmEvrfSft2wWeQObhBtmQ=;
        b=ttzstxSjRCq5UcgkxklHOopri5R6NOZ5g0oejhtNt08CifpekTXQdd46iYbLByipBFi3cy
        i+UW18w74OUJsiBg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 161CCA3B8E;
        Tue, 14 Sep 2021 09:14:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, David Lin <dtwlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        linux-staging@lists.linux.dev, greybus-dev@lists.linaro.org
Subject: [PATCH 14/16] tty: drivers/staging/, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:13 +0200
Message-Id: <20210914091415.17918-7-jslaby@suse.cz>
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
going to remove the former, so call the latter directly in
drivers/staging/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: linux-staging@lists.linux.dev
Cc: greybus-dev@lists.linaro.org
---
 drivers/staging/fwserial/fwserial.c | 4 ++--
 drivers/staging/gdm724x/gdm_tty.c   | 2 +-
 drivers/staging/greybus/uart.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index e8fa7f53cd5e..b2d3f95edbc3 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -518,7 +518,7 @@ static void fwtty_emit_breaks(struct work_struct *work)
 		if (c < t)
 			break;
 	}
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 
 	if (port->mstatus & (UART_LSR_BI << 24))
 		schedule_delayed_work(&port->emit_breaks, FREQ_BREAKS);
@@ -565,7 +565,7 @@ static int fwtty_rx(struct fwtty_port *port, unsigned char *data, size_t len)
 
 	c = tty_insert_flip_string_fixed_flag(&port->port, data, TTY_NORMAL, n);
 	if (c > 0)
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	n -= c;
 
 	if (n) {
diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 04df6f9f5403..95a3b4e61fec 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -129,7 +129,7 @@ static int gdm_tty_recv_complete(void *data,
 	if (data && len) {
 		if (tty_buffer_request_room(&gdm->port, len) == len) {
 			tty_insert_flip_string(&gdm->port, data, len);
-			tty_flip_buffer_push(&gdm->port);
+			tty_schedule_flip(&gdm->port);
 		} else {
 			return TO_HOST_BUFFER_REQUEST_FAIL;
 		}
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index e6d860a9678e..2bdc2401b652 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -122,7 +122,7 @@ static int gb_uart_receive_data_handler(struct gb_operation *op)
 			recv_data_size, count);
 	}
 	if (count)
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 	return 0;
 }
 
-- 
2.33.0

