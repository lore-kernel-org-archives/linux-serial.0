Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848DBC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 11:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbhKVLUA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:20:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54040 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbhKVLT6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 06:19:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 299041FD5B;
        Mon, 22 Nov 2021 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637579811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEm+8vA9TCtL9DYsnrtmbGRRDo10Kj7WKBTDoClpP9I=;
        b=rCDnM0RwIv5qarsHL34rHo/R7eQYKGi4deMZB4/mDl8ENy5l6AtpDUji7JQaYWv9bnGadu
        LFkIPA1auB4hFwSXOVCmD46HNMqYrD729vysCKlB1uncjmP0BVQnxiCzK21qRI5y1QPmlU
        DDD7jCcZr31cWucqFhBdQdEKX8X1Np0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637579811;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEm+8vA9TCtL9DYsnrtmbGRRDo10Kj7WKBTDoClpP9I=;
        b=8IyANcO6gqekMJKuEKeJK1xvikSQ+QI+yGakWkSD6hWT0tRr7W7Z39h3oQEIRnhwBTrAJ7
        /RMYJQJ6pKMitQAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 01309A3B88;
        Mon, 22 Nov 2021 11:16:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 3/3] tty: drop tty_schedule_flip()
Date:   Mon, 22 Nov 2021 12:16:48 +0100
Message-Id: <20211122111648.30379-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122111648.30379-1-jslaby@suse.cz>
References: <20211122111648.30379-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). All
users were converted in the previous patches, so remove
tty_schedule_flip() completely while inlining its body into
tty_flip_buffer_push().

One less exported function.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
[v2] drop tty_schedule_flip (and not tty_flip_buffer_push)

 drivers/tty/tty_buffer.c | 30 ++++++++----------------------
 include/linux/tty_flip.h |  1 -
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6c7e65b1d9a1..5b6875057ce2 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -401,27 +401,6 @@ int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 }
 EXPORT_SYMBOL(__tty_insert_flip_char);
 
-/**
- *	tty_schedule_flip	-	push characters to ldisc
- *	@port: tty port to push from
- *
- *	Takes any pending buffers and transfers their ownership to the
- *	ldisc side of the queue. It then schedules those characters for
- *	processing by the line discipline.
- */
-
-void tty_schedule_flip(struct tty_port *port)
-{
-	struct tty_bufhead *buf = &port->buf;
-
-	/* paired w/ acquire in flush_to_ldisc(); ensures
-	 * flush_to_ldisc() sees buffer data.
-	 */
-	smp_store_release(&buf->tail->commit, buf->tail->used);
-	queue_work(system_unbound_wq, &buf->work);
-}
-EXPORT_SYMBOL(tty_schedule_flip);
-
 /**
  *	tty_prepare_flip_string		-	make room for characters
  *	@port: tty port
@@ -566,7 +545,14 @@ static void flush_to_ldisc(struct work_struct *work)
 
 void tty_flip_buffer_push(struct tty_port *port)
 {
-	tty_schedule_flip(port);
+	struct tty_bufhead *buf = &port->buf;
+
+	/*
+	 * Paired w/ acquire in flush_to_ldisc(); ensures flush_to_ldisc() sees
+	 * buffer data.
+	 */
+	smp_store_release(&buf->tail->commit, buf->tail->used);
+	queue_work(system_unbound_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 9916acb5de49..483d41cbcbb7 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -17,7 +17,6 @@ int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 		size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
-void tty_schedule_flip(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag);
 
 static inline int tty_insert_flip_char(struct tty_port *port,
-- 
2.33.1

