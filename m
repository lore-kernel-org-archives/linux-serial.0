Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D7C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 11:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiFOLRQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiFOLRO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 07:17:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FA3B3DC
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 04:17:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z14so6187762pjb.4
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HROt9F3Q8hzxTeq/HaqrOEyNoRmpauqjeCqvroXNKgM=;
        b=UMCGwYC+S4IbeHTAJ7B51ddkcuEv8wfVpCTITrkG8HyAv510J8R7Bgy+XrZCbAzjFn
         0PgfdKmcby1A7l6eLSACZzBZCeGCzxzDBWCkm0BNkLnIWUaD9rEh7hEQMyNlhcyq1WvI
         XT1B6S80K7k8ueP4oo2SLJTi7WE/FGjqzbjYeaH9vxCcYraX4LWJhZxehpRBZ6el5ZFy
         afaioLEcbnZk00UMA4wK1XPOuH0FvUbVXBxqegw49PUv/imIzqThEasGoigq/UCtzPjW
         FIl7DNsuEkUZOI8GBwP/gXQ4G0k0IcvHNQ39mcEputeilUKqZoGI9JMSBVFWGiFj9HiS
         Fcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HROt9F3Q8hzxTeq/HaqrOEyNoRmpauqjeCqvroXNKgM=;
        b=qPJKqs5smPeTFqIedhSqeCmSHCERqLN0AGbwZfxL5WwGoutIGCtne5SNJHBKUI728E
         uIz/14fc8YQHgKLQlxbA/3eA7CzlJjCSBKkIWubbItpYeBl4Wh9xa8mCIP/xDad50iTv
         kMqFYi9ZLf/K0UNwS+rC/bhVSL5WkIOUv6tHoH0NT5c6r7+PiLnQECkDA4DjzKVwjvHN
         XSHLOvAhdhTQrVvVtldtQWbNpZCDNxWlDZiA9DGnobpcN5ijpEd+xe1+uk2MlHFsKAnH
         2fmi/YdQLUrtcguINwIlyXIIeGY55mSDZJrivs6eRPBssXXtjYzxj23C5qPOv/76cGVT
         F5sQ==
X-Gm-Message-State: AJIora9znilgIu+j7C/9Rbn6eEj8S7+8z5N8gSjTcsnN42wFSbA6hMWd
        X8Q3SlnPuje5zP5cXopZdJxqt+/QsJQPVA==
X-Google-Smtp-Source: AGRyM1v8nWBK+Na+EY738x4CkFh1R4Kae7MJrc8c5q8qG/WW0+gecb2HLJ8k+sQq847oGnGJw1ypcQ==
X-Received: by 2002:a17:90b:1c87:b0:1ca:f4e:4fbe with SMTP id oo7-20020a17090b1c8700b001ca0f4e4fbemr9670668pjb.159.1655291833319;
        Wed, 15 Jun 2022 04:17:13 -0700 (PDT)
Received: from localhost.localdomain ([43.155.90.222])
        by smtp.googlemail.com with ESMTPSA id q21-20020a170902bd9500b0016760c06b76sm9017751pls.194.2022.06.15.04.17.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 04:17:12 -0700 (PDT)
From:   cael <juanfengpy@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial@vger.kernel.org, juanfengpy@gmail.com
Subject: [PATCH v5] tty: fix hang on tty device with no_room set
Date:   Wed, 15 Jun 2022 19:17:01 +0800
Message-Id: <1655291821-19676-1-git-send-email-juanfengpy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YqmmdRynrDSzNL0W@kroah.com>
References: <YqmmdRynrDSzNL0W@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: caelli <juanfengpy@gmail.com>

We have met a hang on pty device, the reader was blocking
at epoll on master side, the writer was sleeping at wait_woken
inside n_tty_write on slave side, and the write buffer on
tty_port was full, we found that the reader and writer would
never be woken again and blocked forever.

The problem was caused by a race between reader and kworker:
n_tty_read(reader):  n_tty_receive_buf_common(kworker):
                    |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
                    |room <= 0
copy_from_read_buf()|
n_tty_kick_worker() |
                    |ldata->no_room = true

After writing to slave device, writer wakes up kworker to flush
data on tty_port to reader, and the kworker finds that reader
has no room to store data so room <= 0 is met. At this moment,
reader consumes all the data on reader buffer and calls
n_tty_kick_worker to check ldata->no_room which is false and
reader quits reading. Then kworker sets ldata->no_room=true
and quits too.

If write buffer is not full, writer will wake kworker to flush data
again after following writes, but if write buffer is full and writer
goes to sleep, kworker will never be woken again and tty device is
blocked.

This problem can be solved with a check for read buffer size inside
n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
is true, a call to n_tty_kick_worker is necessary to keep flushing
data to reader.

Signed-off-by: caelli <juanfengpy@gmail.com>
---
Patch changelogs between v1 and v2:
	-add barrier inside n_tty_read and n_tty_receive_buf_common;
	-comment why barrier is needed;
	-access to ldata->no_room is changed with READ_ONCE and WRITE_ONCE;
Patch changelogs between v2 and v3:
	-in function n_tty_receive_buf_common, add unlikely to check
	 ldata->no_room, eg: if (unlikely(ldata->no_room)), and READ_ONCE
	 is removed here to get locality;
	-change comment for barrier to show the race condition to make
	 comment easier to understand;
Patch changelogs between v3 and v4:
	-change subject from 'tty: fix a possible hang on tty device' to
	 'tty: fix hang on tty device with no_room set' to make subject 
	 more obvious;
Patch changelogs between v4 and v5:
	-name is changed from cael to caelli, li is added as the family
	 name and caelli is the fullname.

 drivers/tty/n_tty.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..544f782b9a11 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 
 	/* Did the input worker stop? Restart it */
-	if (unlikely(ldata->no_room)) {
-		ldata->no_room = 0;
+	if (unlikely(READ_ONCE(ldata->no_room))) {
+		WRITE_ONCE(ldata->no_room, 0);
 
 		WARN_RATELIMIT(tty->port->itty == NULL,
 				"scheduling with invalid itty\n");
@@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 			if (overflow && room < 0)
 				ldata->read_head--;
 			room = overflow;
-			ldata->no_room = flow && !room;
+			WRITE_ONCE(ldata->no_room, flow && !room);
 		} else
 			overflow = 0;
 
@@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 	} else
 		n_tty_check_throttle(tty);
 
+	if (unlikely(ldata->no_room)) {
+		/*
+		 * Barrier here is to ensure to read the latest read_tail in
+		 * chars_in_buffer() and to make sure that read_tail is not loaded
+		 * before ldata->no_room is set, otherwise, following race may occur:
+		 * n_tty_receive_buf_common() |n_tty_read()
+		 * chars_in_buffer() > 0      |
+		 *                            |copy_from_read_buf()->chars_in_buffer()==0
+		 *                            |if (ldata->no_room)
+		 * ldata->no_room = 1         |
+		 * Then both kworker and reader will fail to kick n_tty_kick_worker(),
+		 * smp_mb is paired with smp_mb() in n_tty_read().
+		 */
+		smp_mb();
+		if (!chars_in_buffer(tty))
+			n_tty_kick_worker(tty);
+	}
+
 	up_read(&tty->termios_rwsem);
 
 	return rcvd;
@@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		if (time)
 			timeout = time;
 	}
-	if (tail != ldata->read_tail)
+	if (tail != ldata->read_tail) {
+		/*
+		 * Make sure no_room is not read before setting read_tail,
+		 * otherwise, following race may occur:
+		 * n_tty_read()		                |n_tty_receive_buf_common()
+		 * if(ldata->no_room)->false            |
+		 *			                |ldata->no_room = 1
+		 *                                      |char_in_buffer() > 0
+		 * ldata->read_tail = ldata->commit_head|
+		 * Then copy_from_read_buf() in reader consumes all the data
+		 * in read buffer, both reader and kworker will fail to kick
+		 * tty_buffer_restart_work().
+		 * smp_mb is paired with smp_mb() in n_tty_receive_buf_common().
+		 */
+		smp_mb();
 		n_tty_kick_worker(tty);
+	}
 	up_read(&tty->termios_rwsem);
 
 	remove_wait_queue(&tty->read_wait, &wait);
-- 
2.27.0

