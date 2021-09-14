Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73743C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B57661155
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhINJPn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34600 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhINJPi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 90616220D5;
        Tue, 14 Sep 2021 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptWzO8anEDZUJbbMX+rmrDqkj4g7V1LAPYQTnvJTFXg=;
        b=VxAY61NZ/P6DOUa6H3xqGUUv578TxOdU6CuArvd+ibeyzofdUaNtb0pyvRPjOomZGIGigT
        6AlfkON4urLAhMkMy3UpqirnpubXkYA6s9n9JYyJR/8p3IzBfvRAcW2DuWcl/6ZVXOPR2H
        QfE+ucrgDaqiwUgURcw7ttn3GwqYwLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptWzO8anEDZUJbbMX+rmrDqkj4g7V1LAPYQTnvJTFXg=;
        b=g1nTVx8iBsjCS2nrbWqPE3UpsXMNJjK0zM1J7NgKQsgQxrNlEufvPp9hkPibYpKIjTpGg2
        XJQVUK8LpQ4ZU+BQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 74E02A3B9E;
        Tue, 14 Sep 2021 09:14:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/16] tty: drop tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:15 +0200
Message-Id: <20210914091415.17918-9-jslaby@suse.cz>
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
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). All
users were converted, so remove tty_flip_buffer_push() completely.

One less exported function.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_buffer.c | 17 -----------------
 include/linux/tty_flip.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 635d0af229b7..19b44639c464 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -550,23 +550,6 @@ static void flush_to_ldisc(struct work_struct *work)
 
 }
 
-/**
- *	tty_flip_buffer_push	-	terminal
- *	@port: tty port to push
- *
- *	Queue a push of the terminal flip buffers to the line discipline.
- *	Can be called from IRQ/atomic context.
- *
- *	In the event of the queue being busy for flipping the work will be
- *	held off and retried later.
- */
-
-void tty_flip_buffer_push(struct tty_port *port)
-{
-	tty_schedule_flip(port);
-}
-EXPORT_SYMBOL(tty_flip_buffer_push);
-
 /**
  *	tty_buffer_init		-	prepare a tty buffer structure
  *	@port: tty port to initialise
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 9916acb5de49..7efef54df932 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -16,7 +16,6 @@ int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		const unsigned char *chars, char flag, size_t size);
 int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 		size_t size);
-void tty_flip_buffer_push(struct tty_port *port);
 void tty_schedule_flip(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag);
 
-- 
2.33.0

